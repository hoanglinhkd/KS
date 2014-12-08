//
//  OttaFindFriendsViewController.h
//  Otta
//
//  Created by Thien Chau on 11/17/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OttaFriendsCell.h"
#import "OttaFriend.h"
#import <MessageUI/MessageUI.h>

@interface OttaFindFriendsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MFMessageComposeViewControllerDelegate, MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableFriends;
@property (weak, nonatomic) IBOutlet UILabel *inviteLbl;
@property (assign) BOOL isFromContact;//facebook = false, contacts = true
@property (assign) BOOL isInviteMode;
@property (weak, nonatomic) IBOutlet UIView *inviteView;
@property (weak, nonatomic) IBOutlet UILabel *connectCaption;
@property (weak, nonatomic) IBOutlet UILabel *smsLbl;
@property (weak, nonatomic) IBOutlet UILabel *emailLbl;
@property (weak, nonatomic) IBOutlet UIButton *toggleBtn;
@property (weak, nonatomic) IBOutlet UITextField *txtFindContactFriends;

- (IBAction)changeInviteMethod:(id)sender;
- (IBAction)nextButtonPressed:(id)sender;

@end
