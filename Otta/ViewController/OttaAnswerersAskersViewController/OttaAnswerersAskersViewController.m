//
//  OttaFindFriendsViewController.m
//  Otta
//
//  Created by Thien Chau on 11/17/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaAnswerersAskersViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "OttaAlertManager.h"
#import "OttAddFriendViewController.h"
#import "OttaParseClientManager.h"
#import "SideMenuViewController.h"


@interface OttaAnswerersAskersViewController ()
{
    NSMutableArray *arr;
}
@end

@implementation OttaAnswerersAskersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    self.isAnswererTab = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self updateAnswerersAskersCount];
    [self updateUI:self.isAnswererTab];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 57.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"OttaFindFriendsCellID";
    
    OttaFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:
                          cellIdentifier];
    if (cell == nil) {
        cell = [[OttaFriendsCell alloc] initWithStyle:
                UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    PFObject *follow = _follows[indexPath.row];
    PFUser *user;
    
    if (_isAnswererTab) {
        user = follow[kFrom];
    } else {
        user = follow[kTo];
    }
    
    cell.lblText.text = @"";
    //[user fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
    
    NSString *name = [NSString stringWithFormat:@"%@ %@", user[kFirstName], user[kLastName]];
    cell.lblText.text = name;
    
    //}];
    
    if ([follow[kIsBlocked] boolValue] && _isAnswererTab) {
        cell.lblText.textColor = [UIColor redColor];
    } else {
        cell.lblText.textColor = [UIColor blackColor];
    }
    [cell.imgIcon setImage:[UIImage imageNamed:@"Otta_friends_button_added.png"]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_follows count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    PFObject *follow = _follows[indexPath.row];
    PFUser *user;
    
    if (_isAnswererTab) {
        user = follow[kFrom];
    } else {
        user = follow[kTo];
    }
    NSString *name = [NSString stringWithFormat:@"%@ %@", user[kFirstName], user[kLastName]];
    BOOL isBlocked = [follow[kIsBlocked] boolValue];
    
    
    if (_isAnswererTab) {
        [[OttaAlertManager sharedManager] showFriendAlertOnView:self.view withName:name isBlock:isBlocked complete:^(FriendAction action) {
            switch (action) {
                case FriendActionBlock:
                {
                    [self actionBlockOrUnblock:isBlocked row:indexPath.row];
                }
                    break;
                case FriendActionRemove:
                {
                    [self actionRemove:indexPath.row];
                }
                    break;
                default:
                    break;
            }
        }];
    } else {
        [[OttaAlertManager sharedManager] showFriendNoBlockOnView:self.view withName:name complete:^(FriendAction action) {
            if (action == FriendActionRemove) {
                [self actionRemove:indexPath.row];
            }
        }];
    }
}

- (void)actionBlockOrUnblock:(BOOL)isBlocked row:(NSInteger)row {
    
    if([OttaNetworkManager isOfflineShowedAlertView]) {
        return;
    }
    
    [[OttaLoadingManager sharedManager] show];
    PFObject *follow = _follows[row];
    
    [[OttaParseClientManager sharedManager] setBlockFollow:follow withValue:!isBlocked withBlock:^(BOOL isSucceeded, NSError *error) {
        //[self updateAnswerersAskersCount];
        [_table reloadData];
        [[OttaLoadingManager sharedManager] hide];
    }];
}

- (void)actionRemove:(NSInteger)row {
    
    if([OttaNetworkManager isOfflineShowedAlertView]) {
        return;
    }
    
    [[OttaLoadingManager sharedManager] show];
    PFObject *follow = _follows[row];
    [[OttaParseClientManager sharedManager] removeFollow:follow withBlock:^(BOOL isSucceeded, NSError *error) {
        //remove object in list manually for fixing cache issue
        arr = [NSMutableArray arrayWithArray:_follows];
        [arr removeObjectAtIndex:row];
        _follows = [[NSArray alloc] initWithArray:arr];
        _followsStorage = [[NSArray alloc] initWithArray:arr];
        
        [self updateAnswerersAskersCount];
        [_table reloadData];
        [[OttaLoadingManager sharedManager] hide];
    }];
}

- (IBAction)menuButtonPressed:(id)sender {
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

- (IBAction)txtChanged:(UITextField *)sender {
    _follows = [[NSArray alloc] initWithArray:_followsStorage];
    if (![sender.text  isEqual: @""]){
        arr = [[NSMutableArray alloc] init];
        for (int i= 0; i < [_follows count]; i++) {
            PFObject *follow = _follows[i];
            PFUser *user;
            if (_isAnswererTab) {
                user = follow[kFrom];
            } else {
                user = follow[kTo];
            }
            NSString *name = [NSString stringWithFormat:@"%@ %@", user[kFirstName], user[kLastName]];
            if ([name rangeOfString:sender.text options:NSCaseInsensitiveSearch].location != NSNotFound){
                [arr addObject:_follows[i]];
            }
        }
        _follows = [[NSArray alloc] initWithArray:arr];
    }
    [self.table reloadData];
}

- (IBAction)btnAnswerPressed:(id)sender {
    [self updateUI:YES];
}

- (IBAction)btnAskPressed:(id)sender {
    [self updateUI:NO];
}

- (IBAction)pressBtnLogo:(id)sender {
    [[SideMenuViewController sharedInstance] selectRowAtIndex:[NSIndexPath indexPathForRow:0 inSection:0] forViewController:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"AddNewSegue"])
    {
        OttAddFriendViewController *vc = [segue destinationViewController];
        vc.isFromInApp = YES;
        vc.isInviteMode = NO;
    }
    
    if ([[segue identifier] isEqualToString:@"inviteSegue"])
    {
        OttAddFriendViewController *vc = [segue destinationViewController];
        vc.isFromInApp = YES;
        vc.isInviteMode = YES;
    }
}

- (void) updateAnswerersAskersCount {
    
    if([OttaNetworkManager isOfflineShowedAlertView]) {
        return;
    }
    
    [[OttaParseClientManager sharedManager] countUsersFollowToUser:[PFUser currentUser] withBlock:^(int count, NSError *error) {
        self.lblAnswerersCount.text = [NSString stringWithFormat:@"%d",count];
    }];
    [[OttaParseClientManager sharedManager] countUsersFollowFromUser:[PFUser currentUser] withBlock:^(int count, NSError *error) {
        self.lblAskersCount.text = [NSString stringWithFormat:@"%d",count];
    }];
}

- (void) updateUI:(BOOL) isAnswererTab
{
    
    if([OttaNetworkManager isOfflineShowedAlertView]) {
        return;
    }
    
    _follows = [NSArray new];
    [_table reloadData];
    
    [[OttaLoadingManager sharedManager] show];
    self.isAnswererTab = isAnswererTab;
    _txtLabel.text = @"";
    if (isAnswererTab) {
        self.lblAnswerers.textColor = cusGreencolor;
        self.lblAnswerersCount.textColor = cusGreencolor;
        self.lblAskers.textColor = [UIColor blackColor];
        self.lblAskersCount.textColor = [UIColor blackColor];
        [[OttaParseClientManager sharedManager] getAllFollowToUser:[PFUser currentUser] withBlock:^(NSArray *array, NSError *error) {
            _follows = [[NSArray alloc] initWithArray:array];
            _followsStorage = [[NSArray alloc] initWithArray:array];
            self.lblAnswerersCount.text = [NSString stringWithFormat:@"%ld",_follows.count];
            [self.table reloadData];
            [[OttaLoadingManager sharedManager] hide];
        }];

    } else {
            
        self.lblAskers.textColor = cusGreencolor;
        self.lblAskersCount.textColor = cusGreencolor;
        self.lblAnswerers.textColor = [UIColor blackColor];
        self.lblAnswerersCount.textColor = [UIColor blackColor];
        
        [[OttaParseClientManager sharedManager] getAllFollowFromUser:[PFUser currentUser] withBlock:^(NSArray *array, NSError *error) {
            _follows = [[NSArray alloc] initWithArray:array];
            _followsStorage = [[NSArray alloc] initWithArray:array];
            self.lblAskersCount.text = [NSString stringWithFormat:@"%ld",_follows.count];
            [self.table reloadData];
            [[OttaLoadingManager sharedManager] hide];
        }];
    }

}

@end