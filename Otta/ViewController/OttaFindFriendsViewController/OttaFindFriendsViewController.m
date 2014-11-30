//
//  OttaFindFriendsViewController.m
//  Otta
//
//  Created by Thien Chau on 11/17/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaFindFriendsViewController.h"
#import <RHAddressBook/AddressBook.h>
#import <Parse/Parse.h>
#import "FBRequestConnection.h"
#import "MBProgressHUD.h"

@interface OttaFindFriendsViewController ()
{
    OttaFriendsCell *lastCellSelected;
    RHAddressBook *addressBook;
    NSArray *listPeople;
    NSMutableArray *friends;
    NSMutableArray *searchResults;
    BOOL isSearching;
}
@end

@implementation OttaFindFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    addressBook = [[RHAddressBook alloc] init] ;
    searchResults = [NSMutableArray array ];
    // Do any additional setup after loading the view.
    self.txtLabel.text = [@"Find Friends" toCurrentLanguage];
    if (_isFromContact){
        self.txtLabel.text = [@"Find Contacts" toCurrentLanguage];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(_isFromContact) {
        [self loadLocalContacts];
    } else { //Facebook
        [self loadFacebookFriends];
    }
}

- (void) loadFacebookFriends
{
    if(_isInviteMode) {
        
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [FBRequestConnection startWithGraphPath:@"/me/taggable_friends"  //@"/me/invitable_friends"
                                     parameters:nil
                                     HTTPMethod:@"GET"
                              completionHandler:^(
                                                  FBRequestConnection *connection,
                                                  id result,
                                                  NSError *error
                                                  )
         {
             
             if(result) {
                 NSArray *listInvitableFriends = [result objectForKey:@"data"];
                 if(listInvitableFriends.count > 0) {
                     friends = [self loadFriendsFromUnregisterdFacebooks:listInvitableFriends];
                 }
                 [_tableFriends reloadData];
             }
             
             [MBProgressHUD hideHUDForView:self.view animated:YES];
         }];
        
    } else {
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [FBRequestConnection startForMyFriendsWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
            
            if (!error) {
                
                NSArray *friendObjects = [result objectForKey:@"data"];
                NSMutableArray *friendIds = [NSMutableArray arrayWithCapacity:friendObjects.count];
                for (NSDictionary *friendObject in friendObjects) {
                    [friendIds addObject:[friendObject objectForKey:@"id"]];
                }
                
                PFQuery *friendQuery = [PFUser query];
                
                [friendQuery whereKey:@"facebookId" containedIn:friendIds];
                [friendQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                    friends = [self loadFriendsFromRegisterdFacebooks:objects];
                    [_tableFriends reloadData];
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                }];
            } else {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }
        }];
    }
}

- (void)loadLocalContacts
{
    //This is use Address Book
    //https://github.com/heardrwt/RHAddressBook
    if ([RHAddressBook authorizationStatus] == RHAuthorizationStatusNotDetermined
        || [RHAddressBook authorizationStatus] == RHAuthorizationStatusDenied){
        
        [addressBook requestAuthorizationWithCompletion:^(bool granted, NSError *error) {
            if(granted) {
                [self loadContact];
            } else {
                [self dismissViewControllerAnimated:YES completion:nil];
            }
        }];
    } else {
        [self loadContact];
    }
}

- (void)loadContact {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        
        listPeople = [addressBook people];
        [self loadDataFromContacts:[NSMutableArray arrayWithArray:listPeople]];
        
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray*) loadFriendsFromUnregisterdFacebooks:(NSArray*)listFacebooks
{
    if(!friends) {
        friends = [NSMutableArray array];
    }
    
    if (friends.count > 0) {
        [friends removeAllObjects];
    }
    
    for (NSDictionary *friendObject in listFacebooks) {
        NSString *friendID = [friendObject objectForKey:@"id"];
        NSString *friendName = [friendObject objectForKey:@"name"];
        OttaFriend *friendToAdd = [[OttaFriend alloc] initWithName:friendName friendStatus:NO];
        friendToAdd.facebookUserTokenId = friendID;
        friendToAdd.name = friendName;
        [friends addObject:friendToAdd];
    }
    
    return friends;
}

-(NSMutableArray*) loadFriendsFromRegisterdFacebooks:(NSArray*)listFacebooks
{
    if(!friends) {
        friends = [NSMutableArray array];
    }
    
    if (friends.count > 0) {
        [friends removeAllObjects];
    }
    
    for (PFUser *curUser in listFacebooks) {
        OttaFriend *friendToAdd = [[OttaFriend alloc] initWithName:curUser.username friendStatus:NO];
        friendToAdd.emailAdress = curUser.email;
        friendToAdd.pfUser = curUser;
        friendToAdd.name = [NSString stringWithFormat:@"%@ %@", curUser[@"firstName"], curUser[@"lastName"]];
        [friends addObject:friendToAdd];
    }
    
    return friends;
}

//Return true if found
-(BOOL) findUserInformation:(PFUser*)curUser contact:(RHPerson*)contact
{
    NSString *phoneNumber = [curUser objectForKey:@"phone"];
    if(phoneNumber.length > 0) {
        //List phone to compare
        RHMultiValue *phoneNumbers = contact.phoneNumbers;
        NSArray *listPhoneCompare = [phoneNumbers values];
        
        for (NSString *curPhone in listPhoneCompare) {
            if([phoneNumber isEqualToString:curPhone]) {
                return YES;
            }
        }
    }
    
    NSString *email = [curUser objectForKey:@"email"];
    if(email.length > 0) {
        //List Email to compare
        RHMultiValue *emails = contact.emails;
        NSArray *listEmails = [emails values];
        
        for (NSString *curEmail in listEmails) {
            if([email isEqualToString:curEmail]) {
                return YES;
            }
        }
    }
    
    return NO;
}
- (void)loadDataFromContacts:(NSMutableArray*) listContacts{
    
    if (!friends) {
        friends = [NSMutableArray array];
    }
    
    if (friends.count > 0) {
        [friends removeAllObjects];
    }
    
    if(_isInviteMode) {
        
        NSMutableArray *listEmail = [NSMutableArray array];
        NSMutableArray *listPhone = [NSMutableArray array];
        
        
        for (RHPerson *curPersion in listContacts) {
            
            //List phone to compare
            RHMultiValue *phoneNumbers = curPersion.phoneNumbers;
            NSArray *listPhoneCompare = [phoneNumbers values];
            
            for (NSString *curPhone in listPhoneCompare) {
                [listPhone addObject:curPhone];
            }
            
            //List Email to compare
            RHMultiValue *emails = curPersion.emails;
            NSArray *listEmails = [emails values];
            
            for (NSString *curEmail in listEmails) {
                [listEmail addObject:curEmail];
            }
        }

        
        PFQuery * phoneQuery = [PFQuery queryWithClassName:@"User"];
        [phoneQuery whereKey:@"phone" containedIn:listPhone];
        
        PFQuery * emailQuery = [PFQuery queryWithClassName:@"User"];
        [emailQuery whereKey:@"email" containedIn:listEmail];
        
        PFQuery *query = [PFQuery orQueryWithSubqueries:@[phoneQuery, emailQuery]];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            
            //Remove redundant contacts
            for (PFUser *curUser in objects) {
                for (RHPerson *curPersion in listContacts) {
                    if([self findUserInformation:curUser contact:curPersion]) {
                        
                        [listContacts removeObjectsInArray:[NSArray arrayWithObject:curPersion]];
                        break;
                    }
                }
            }
            
            //Load contacts to invite
            for (RHPerson *curPersion in listContacts) {
                
                OttaFriend *friendToAdd = [[OttaFriend alloc] initWithName:curPersion.name friendStatus:NO];
                
                //List phone to compare
                RHMultiValue *phoneNumbers = curPersion.phoneNumbers;
                NSArray *listPhoneCompare = [phoneNumbers values];
                
                //
                friendToAdd.phoneNumber = listPhoneCompare.count > 0 ? listPhoneCompare[0] : @"";
                
                //List Email to compare
                RHMultiValue *emails = curPersion.emails;
                NSArray *listEmails = [emails values];
                friendToAdd.emailAdress = listEmails.count > 0 ? listEmails[0] : @"";
                
                [friends addObject:friendToAdd];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableFriends reloadData];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
            
        }];
        
    } else {
        
        NSMutableArray *listEmail = [NSMutableArray array];
        NSMutableArray *listPhone = [NSMutableArray array];
        
        
        for (RHPerson *curPersion in listContacts) {
            
            //List phone to compare
            RHMultiValue *phoneNumbers = curPersion.phoneNumbers;
            NSArray *listPhoneCompare = [phoneNumbers values];
            
            for (NSString *curPhone in listPhoneCompare) {
                [listPhone addObject:curPhone];
            }
            
            //List Email to compare
            RHMultiValue *emails = curPersion.emails;
            NSArray *listEmails = [emails values];
            
            for (NSString *curEmail in listEmails) {
                [listEmail addObject:curEmail];
            }
        }
        
        PFQuery * phoneQuery = [PFQuery queryWithClassName:@"User"];
        [phoneQuery whereKey:@"phone" containedIn:listPhone];
        
        PFQuery * emailQuery = [PFQuery queryWithClassName:@"User"];
        [emailQuery whereKey:@"email" containedIn:listEmail];
        
        PFQuery *query = [PFQuery orQueryWithSubqueries:@[phoneQuery, emailQuery]];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            
            //Remove redundant contacts
            for (PFUser *curUser in objects) {
                OttaFriend *friendToAdd = [[OttaFriend alloc] initWithName:curUser.username friendStatus:NO];
                friendToAdd.emailAdress = curUser.email;
                friendToAdd.pfUser = curUser;
                friendToAdd.name = [NSString stringWithFormat:@"%@ %@", curUser[@"firstName"], curUser[@"lastName"]];
                [friends addObject:friendToAdd];
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_tableFriends reloadData];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
        }];
    }
}

-(void) selectAllFriends
{
    for (OttaFriend *curFriend in friends) {
        if (!curFriend.isFriend) {
            curFriend.isSelected = YES;
        }
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
    
    NSString *substring = [NSString stringWithString:textField.text];
    substring = [substring
                 stringByReplacingCharactersInRange:range withString:string];
    if(substring.length > 0) {
        isSearching = YES;
        [self searchWithName:substring];
    } else {
        isSearching = NO;
        [_tableFriends reloadData];
    }
    return YES;
}

- (void)searchWithName:(NSString*)searchname
{
    [searchResults removeAllObjects];
    for (OttaFriend *curFriend in friends) {
        if([curFriend.name rangeOfString:searchname options:NSCaseInsensitiveSearch].location != NSNotFound) {
            [searchResults addObject:curFriend];
        }
    }
    [_tableFriends reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 57.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIImage *image;
    
    static NSString *cellIdentifier = @"OttaFindFriendsCellID";
    
    OttaFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:
                          cellIdentifier];
    if (cell == nil) {
        cell = [[OttaFriendsCell alloc] initWithStyle:
                UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    image = [UIImage imageNamed:@"Otta_friends_button_add.png"];
    
    if([searchResults count] > 0 && isSearching) {
        
        OttaFriend *f = (OttaFriend *)[searchResults objectAtIndex:indexPath.row];
        cell.lblText.text = f.name;
        [cell.lblText setFont:[UIFont fontWithName:@"OpenSans-Light" size:18.00f]];
        
        if (f.isFriend || f.isSelected){
            image = [UIImage imageNamed:@"Otta_friends_button_added.png"];
        }
        
    } else {
        if (indexPath.row == 0){
            cell.lblText.text = [@"Select All" toCurrentLanguage];
            [cell.lblText setFont:[UIFont fontWithName:@"OpenSans-Semibold" size:18.00f]];
        } else {
            OttaFriend *f = (OttaFriend *)[friends objectAtIndex:indexPath.row -1];
            cell.lblText.text = f.name;
            [cell.lblText setFont:[UIFont fontWithName:@"OpenSans-Light" size:18.00f]];
            
            if (f.isFriend || f.isSelected){
                image = [UIImage imageNamed:@"Otta_friends_button_added.png"];
            }
        }
    }
    
    [cell.imgIcon setImage:image];
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(isSearching) {
        return [searchResults count];
    }
    return [friends count] + 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //Searching
    if(isSearching) {
        
        OttaFriend *curFriend = [searchResults objectAtIndex:indexPath.row];
        if(!curFriend.isFriend) {
            curFriend.isSelected = !curFriend.isSelected;
            [tableView reloadData];
        }
        
    } else {
        if(indexPath.row == 0) {
            
            [self selectAllFriends];
            [tableView reloadData];
            
        } else {
            OttaFriend *curFriend = [friends objectAtIndex:indexPath.row - 1]; //we don't use index = 0;
            if(!curFriend.isFriend) {
                curFriend.isSelected = !curFriend.isSelected;
                [tableView reloadData];
            }
        }
    }
}

- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)nextButtonPressed:(id)sender
{
    if(!_isFromContact && _isInviteMode) {
        
        NSMutableString *listUserId = [[NSMutableString alloc] initWithString:@""];
        
        for (OttaFriend *curFriend in friends) {
            if(curFriend.isSelected) {
                [listUserId appendFormat:@"%@,", curFriend.facebookUserTokenId];
            }
        }
        
        if (listUserId.length > 0) {
            
            [listUserId deleteCharactersInRange:NSMakeRange([listUserId length] - 1, 1)];
            
            [self postToUserFeed:listUserId];
        
        } else {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void) publishFeed:(NSString*) listUserId
{
    // Put together the dialog parameters
    NSMutableDictionary *params =
    [NSMutableDictionary dictionaryWithObjectsAndKeys:
     @"Facebook SDK for iOS", @"name",
     @"Build great social apps and get more installs.", @"caption",
     @"The Facebook SDK for iOS makes it easier and faster to develop Facebook integrated iOS apps.", @"description",
     @"https://developers.facebook.com/ios", @"link",
     @"https://raw.github.com/fbsamples/ios-3.x-howtos/master/Images/iossdk_logo.png", @"picture",
     listUserId, @"suggestions",
     nil];
    
    // Invoke the dialog
    [FBWebDialogs presentFeedDialogModallyWithSession:nil parameters:params handler:
     ^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
         if (error) {
             // Error launching the dialog or publishing a story.
             NSLog(@"Error publishing story.");
         }
         else {
             if (result == FBWebDialogResultDialogNotCompleted) {
                 // User clicked the "x" icon
                 NSLog(@"User canceled story publishing.");
             } else {
                 
             }
         }
     }];
}

-(void) postToUserFeed:(NSString*) listUserId
{
    NSMutableDictionary* params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                   @"https://developers.facebook.com/ios", @"link",
                                   @"https://developers.facebook.com/attachment/iossdk_logo.png", @"picture",
                                   @"Facebook SDK for iOS", @"name",
                                   @"Build great social apps and get more installs.", @"caption",
                                   @"The Facebook SDK for iOS makes it easier and faster to develop Facebook integrated iOS apps.", @"description",
                                   @"155021662189", @"place",
                                   listUserId, @"tags",
                                   nil];
    
    [FBRequestConnection startWithGraphPath:@"me/feed"
                                 parameters:params
                                 HTTPMethod:@"POST"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                              
                              NSLog(@"%@", error);
                              
                          }];
}

@end
