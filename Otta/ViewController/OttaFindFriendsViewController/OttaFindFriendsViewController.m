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
#import <MessageUI/MessageUI.h>
#import "OttaAlertManager.h"

#define INVITE_METHOD_SMS 0
#define INVITE_METHOD_EMAIL 1

@interface OttaFindFriendsViewController ()
{
    OttaFriendsCell *lastCellSelected;
    RHAddressBook *addressBook;
    NSArray *listPeople;
    NSMutableArray *friends;
    int inviteMethod;
}
@end

@implementation OttaFindFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _isInviteMode = true;
    addressBook = [[RHAddressBook alloc] init] ;
    
    // Do any additional setup after loading the view.
    self.txtLabel.text = [@"Find Friends" toCurrentLanguage];
    if (_isFromContact){
        self.txtLabel.text = [@"Find Contacts" toCurrentLanguage];
    }
    
    _inviteLbl.text = [@"Invite" toCurrentLanguage];
    _smsLbl.text = [@"SMS" toCurrentLanguage];
    _emailLbl.text = [@"Email" toCurrentLanguage];
    
    _inviteView.hidden = !_isInviteMode;
    inviteMethod = INVITE_METHOD_SMS;
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if(_isFromContact) {
        [self loadLocalContacts];
    } else { //Facebook
        [self loadFacebookFriends];
    }
    
    _inviteView.hidden = !_isInviteMode;
}

- (void) loadFacebookFriends
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    //FBRequest* friendsRequest = [FBRequest requestForMyFriends];
    
    [FBRequestConnection startForMyFriendsWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
    //[friendsRequest startWithCompletionHandler: ^(FBRequestConnection *connection,NSDictionary* result,NSError *error) {
        if (!error) {
            
            NSArray *friendObjects = [result objectForKey:@"data"];
            NSMutableArray *friendIds = [NSMutableArray arrayWithCapacity:friendObjects.count];
            for (NSDictionary *friendObject in friendObjects) {
                [friendIds addObject:[friendObject objectForKey:@"id"]];
            }
            
            PFQuery *friendQuery = [PFUser query];
            [friendQuery whereKey:@"fbId" containedIn:friendIds];
            NSArray *friendUsers = [friendQuery findObjects];
            
            friends = [self loadFriendsFromRegisterdFacebooks:friendUsers];
            [_tableFriends reloadData];
        }
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
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
        [self loadData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableFriends reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        
        [friends addObject:friendToAdd];
    }
    
    return friends;
}

- (void)loadData{
    
    if (!friends) {
        friends = [NSMutableArray array];
    }
    
    if (friends.count > 0) {
        [friends removeAllObjects];
    }
    
    for (RHPerson *curPersion in listPeople) {
        
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
}

-(void) selectAllFriends
{
    for (OttaFriend *curFriend in friends) {
        if (!curFriend.isFriend) {
            curFriend.isSelected = YES;
        }
    }
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
    
    [cell.imgIcon setImage:image];
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [friends count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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


- (IBAction)changeInviteMethod:(id)sender {
    if(inviteMethod == INVITE_METHOD_SMS){
        inviteMethod = INVITE_METHOD_EMAIL;
        [_toggleBtn setBackgroundImage:[UIImage imageNamed:@"switch-2"] forState:UIControlStateNormal];
        _smsLbl.textColor = [UIColor lightGrayColor];
        _emailLbl.textColor = [UIColor whiteColor];
    }else{
        inviteMethod = INVITE_METHOD_SMS;
        [_toggleBtn setBackgroundImage:[UIImage imageNamed:@"switch-1"] forState:UIControlStateNormal];
        _smsLbl.textColor = [UIColor whiteColor];
        _emailLbl.textColor = [UIColor lightGrayColor];
    }
}

- (IBAction)backButtonPressed:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)nextButtonPressed:(id)sender {
    if (_isInviteMode) {
        if (inviteMethod == INVITE_METHOD_SMS) {
            [self sendInviteViaSMS];

        }else{
            [self sendInviteViaEmail];

        }
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark send sms
- (void)sendInviteViaSMS{
    NSMutableArray *recipients = [NSMutableArray array];
    for (OttaFriend *curFriend in friends) {
        if (!curFriend.isFriend && curFriend.isSelected) {
            [recipients addObject:curFriend.phoneNumber];
        }
    }
    
    
    MFMessageComposeViewController *controller = [[MFMessageComposeViewController alloc] init] ;
    if([MFMessageComposeViewController canSendText])
    {
        controller.body = [@"Join Otta" toCurrentLanguage];
        controller.recipients = recipients;
        controller.messageComposeDelegate = self;
        [self presentViewController:controller animated:YES completion:nil];
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    BOOL isSuccess = false;
    switch (result) {
        case MessageComposeResultCancelled:
            NSLog(@"Cancelled");
            break;
        case MessageComposeResultFailed:
            [[OttaAlertManager sharedManager] showSimpleAlertOnView:self.view withContent:[@"Can not send SMS" toCurrentLanguage] complete:nil];
            break;
            
        case MessageComposeResultSent:
            isSuccess = true;
            break;
        default:
            
            break;
            
    }
    if (isSuccess) {
        [self dismissViewControllerAnimated:YES completion:^(void) {
            [self dismissViewControllerAnimated:NO completion:nil];
        }];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
   
}

#pragma mark send sms
- (void)sendInviteViaEmail{
    NSMutableArray *recipients = [NSMutableArray array];
    for (OttaFriend *curFriend in friends) {
        if (!curFriend.isFriend && curFriend.isSelected) {
            [recipients addObject:curFriend.emailAdress];
        }
    }
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
        mail.mailComposeDelegate = self;
        [mail setSubject:[@"Join Otta" toCurrentLanguage]];
        [mail setMessageBody:[@"Join Otta to have fun!" toCurrentLanguage] isHTML:NO];
        [mail setToRecipients:recipients];
        [self presentViewController:mail animated:YES completion:nil];
        
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error

{
    BOOL isSuccess = false;
    switch (result) {
            
        case MFMailComposeResultSent:
            NSLog(@"You sent the email.");
            isSuccess = true;
            break;
        case MFMailComposeResultSaved:
            NSLog(@"You saved a draft of this email");
            break;
        case MFMailComposeResultCancelled:
            NSLog(@"You cancelled sending this email.");
            break;
        case MFMailComposeResultFailed:
            [[OttaAlertManager sharedManager] showSimpleAlertOnView:self.view withContent:[@"Could not send email" toCurrentLanguage] complete:nil];
            NSLog(@"Mail failed:  An error occurred when trying to compose this email");
            break;
        default:
            NSLog(@"An error occurred when trying to compose this email");
            break;
    }
    if (isSuccess) {
        [self dismissViewControllerAnimated:YES completion:^(void) {
            [self dismissViewControllerAnimated:NO completion:nil];
        }];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    
    
}




@end
