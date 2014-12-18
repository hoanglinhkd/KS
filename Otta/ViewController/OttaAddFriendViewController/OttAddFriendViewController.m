//
//  OttAddFriendViewController.m
//  Otta
//
//  Created by Thien Chau on 11/11/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttAddFriendViewController.h"
#import "OttaFriend.h"
#import "OttaFindFriendsViewController.h"
#import "OttaParseClientManager.h"
#import "OttaAlertManager.h"
#import "OttaAppDelegate.h"
#import "MBProgressHUD.h"

@interface OttAddFriendViewController()

@property (strong) NSMutableArray *friends;
@property (strong) NSMutableArray *searchResults;
@property (strong) NSMutableArray *listFollowedFriends;
@end

@implementation OttAddFriendViewController


- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"OttaSideMenuBackground.png"]];
    
    if (_isInviteMode) {
        _viewNameLbl.text = [@"INVITE" toCurrentLanguage];
        [_imgSearch setHidden:YES];
        [_txtSearch setHidden:YES];
    } else {
        _viewNameLbl.text = [@"CONNECT" toCurrentLanguage];
    }
    
    _listFollowedFriends = [NSMutableArray array];
    
    if([OttaNetworkManager isOnline]) {
        [[OttaParseClientManager sharedManager] getAllFollowFromUser:[PFUser currentUser] withBlock:^(NSArray *array, NSError *error) {
            
            [_listFollowedFriends removeAllObjects];
            for (id curUserFollow in array) {
                PFUser *curFollow = [curUserFollow objectForKey:@"to"];
                [_listFollowedFriends addObject:curFollow.objectId];
            }
        }];
    }
    
    [self updateNextButtonText];
    
    [self inittempData];
    
}

- (void)viewDidAppear:(BOOL)animated{
    if (_isInviteMode) {
        _viewNameLbl.text = [@"INVITE" toCurrentLanguage];
    }else{
        _viewNameLbl.text = [@"CONNECT" toCurrentLanguage];
    }
}
- (void)inittempData {
    _friends = [NSMutableArray array];
    _searchResults = [NSMutableArray array];
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)nextButtonPressed:(id)sender {
    if (_isFromInApp) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        if (!_isInviteMode) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            OttAddFriendViewController *addFriendVC = [storyboard instantiateViewControllerWithIdentifier:@"OttAddFriendViewController"];
            addFriendVC.isInviteMode = YES;
            addFriendVC.isFromInApp = NO;
            [self presentViewController:addFriendVC animated:YES completion:nil];
        } else {
            [self performSegueWithIdentifier:@"homeSegue" sender:self];
        }
    }
}

- (IBAction)checkButtonPressed:(id)sender {
    _doesAccessContact = !_doesAccessContact;
    if (_doesAccessContact) {
        [_btnCheck setBackgroundImage:[UIImage imageNamed:@"icon_check2.png"] forState:UIControlStateNormal];
    } else {
        [_btnCheck setBackgroundImage:[UIImage imageNamed:@"icon_uncheck.png"] forState:UIControlStateNormal];
    }
}

-(IBAction)btnFacebookFriendPressed:(id)sender
{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSArray *permissionsArray = FacebookPermissions;
    
    if ([FBSession activeSession].state == FBSessionStateCreatedTokenLoaded) {
        [[FBSession activeSession] openWithBehavior:FBSessionLoginBehaviorWithFallbackToWebView completionHandler:^(FBSession *session, FBSessionState status, NSError *error)
        {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if(!error) {
                [self performSegueWithIdentifier:@"connectFriendSegue" sender:@"FacebookFriends"];
            } else {
                [[OttaAlertManager sharedManager] showSimpleAlertWithContent:@"Cannot login Facebook" complete:nil];
            }
        }];
    } else {
        
        [FBSession.activeSession closeAndClearTokenInformation];
        [FBSession setActiveSession:nil];
        
        // create a new facebook session
        FBSession *fbSession = [[FBSession alloc] initWithPermissions:permissionsArray];
        [FBSession setActiveSession:fbSession];
        [fbSession openWithBehavior:FBSessionLoginBehaviorWithFallbackToWebView completionHandler:^(FBSession *session, FBSessionState status, NSError *error)
        {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if(!error) {
                [self performSegueWithIdentifier:@"connectFriendSegue" sender:@"FacebookFriends"];
            } else {
                [[OttaAlertManager sharedManager] showSimpleAlertWithContent:@"Cannot login Facebook" complete:nil];
            }
        }];
    }

    
    
}

-(IBAction)btnContactPressed:(id)sender
{
    [self performSegueWithIdentifier:@"connectFriendSegue" sender:@"Contacts"];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"connectFriendSegue"]) {
        OttaFindFriendsViewController *findFriendVC = segue.destinationViewController;
        NSString *senderValue = sender;
        if([senderValue isEqualToString:@"Contacts"]) {
            findFriendVC.isFromContact = YES;
            findFriendVC.isInviteMode = _isInviteMode;
        } else {
            findFriendVC.isFromContact = NO;
            findFriendVC.isInviteMode = _isInviteMode;
        }
    }
}

#pragma mark - Text Field

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    textField.text = @"";
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
    
    NSString *substring = [NSString stringWithString:textField.text];
    substring = [substring
                 stringByReplacingCharactersInRange:range withString:string];
    [self searchWithName:substring];
    return YES;
}

- (void)searchWithName:(NSString*)searchname
{
    if([OttaNetworkManager isOfflineShowedAlertView]) {
        return;
    }
    
    [[OttaParseClientManager sharedManager] findUsers:searchname withResult:^(NSArray *users, NSError *error) {
        [_searchResults removeAllObjects];
        for(PFUser *user in users) {
            //Ignore showing current user
            if ([[PFUser currentUser].objectId isEqualToString:user.objectId]) {
                continue;
            }
            
            //Finding followed friends
            BOOL isFollowed = NO;
            for (NSString *curId in _listFollowedFriends) {
                if([curId isEqualToString:user.objectId]){
                    isFollowed = YES;
                    break;
                }
            }
            
            NSString *fullname = [NSString stringWithFormat:@"%@ %@", user[@"firstName"], user[@"lastName"]];
            OttaFriend *friend = [[OttaFriend alloc] initWithName:fullname friendStatus:NO];
            friend.pfUser = user;
            friend.isSelected = isFollowed;
            [_searchResults addObject:friend];
            NSLog(@"Fullname: %@",fullname);
        }
        [_searchResultTableView reloadData];
    }];
   
    /*
    for(OttaFriend *friend in _friends) {
        NSRange substringRange = [[friend.name uppercaseString] rangeOfString:[searchname uppercaseString]];
        if (substringRange.location != NSNotFound) {
            [_searchResults addObject:friend];
        }
    }
    [_searchResultTableView reloadData];*/
}

#pragma mark tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"OttaFindFriendsCellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:
                UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    OttaFriend *friend = [_searchResults objectAtIndex:indexPath.row];
    cell.textLabel.text = friend.name;
    cell.textLabel.textColor = [UIColor whiteColor];
    
    if (friend.isSelected) {
        cell.accessoryView = [[ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"Otta_friends_button_added"]];
        [cell.accessoryView setFrame:CGRectMake(0, 0, 15, 15)];
    }else{
        cell.accessoryView = [[ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"Otta_friends_button_add"]];
        [cell.accessoryView setFrame:CGRectMake(0, 0, 15, 15)];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _searchResults.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OttaFriend *friend = [_searchResults objectAtIndex:indexPath.row];
    OttaAppDelegate *appDelegate = (OttaAppDelegate*)[UIApplication sharedApplication].delegate;
    
    if (friend.isSelected) {
        
//        [[OttaAlertManager sharedManager] showYesNoAlertOnView:appDelegate.window withContent:[NSString stringWithFormat:@"Do you want to unfollow %@ ?", friend.name] complete:^{
//            
//            [[OttaParseClientManager sharedManager] removeFollowFromUser:[PFUser currentUser] toUser:friend.pfUser withBlock:^(BOOL isSucceeded, NSError *error) {
//                if(isSucceeded) {
//                    
//                    //Remove follwed friends
//                    for (NSString *curUserId in _listFollowedFriends) {
//                        if([curUserId isEqualToString:friend.pfUser.objectId]) {
//                            [_listFollowedFriends removeObjectsInArray:[NSArray arrayWithObject:curUserId]];
//                            break;
//                        }
//                    }
//                    
//                    friend.isSelected = NO;
//                    [_searchResultTableView reloadData];
//                } else {
//                     [[OttaAlertManager sharedManager] showSimpleAlertOnView:appDelegate.window withContent:@"Error on unfollowing friend" complete:nil];
//                }
//            }];
//            
//        } cancel:^{
//            
//        }];
        
    } else {
        
        if([OttaNetworkManager isOfflineShowedAlertView]) {
            return;
        }
        
        [[OttaAlertManager sharedManager] showYesNoAlertOnView:appDelegate.window withContent:[NSString stringWithFormat:[@"Do you want to follow %@ ?" toCurrentLanguage], friend.name] complete:^{
            [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [[OttaParseClientManager sharedManager] followUser:[PFUser currentUser] toUser:friend.pfUser withBlock:^(BOOL isSucceeded, NSError *error) {
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if(isSucceeded) {
                    friend.isSelected = YES;
                    [_listFollowedFriends addObject:friend.pfUser.objectId];
                    [_searchResultTableView reloadData];
                    
                } else {
                    [[OttaAlertManager sharedManager] showSimpleAlertOnView:appDelegate.window withContent:@"Error on following friend" complete:nil];
                }
            }];
            
        } cancel:^{
            
        }];
    }
    
    
}

- (void) updateNextButtonText{
    if (_isFromInApp) {
        [_btnSkipNext setTitle:[@"Done" toCurrentLanguage] forState:UIControlStateNormal];
    }else{
        [_btnSkipNext setTitle:[@"Next" toCurrentLanguage] forState:UIControlStateNormal];
    }
}



@end
