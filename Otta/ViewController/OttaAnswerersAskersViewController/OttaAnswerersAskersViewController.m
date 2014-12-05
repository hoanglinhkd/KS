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
#import "MBProgressHUD.h"

#define cusGreencolor [UIColor colorWithRed:0.486275 green:0.741176 blue:0.192157 alpha:1]

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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 57.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIImage *btnImage;
    
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
    
    [user fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        NSString *name = [NSString stringWithFormat:@"%@ %@", user[kFirstName], user[kLastName]];
        cell.lblText.text = name;
    }];
    
    if ([follow[kIsBlocked] boolValue]) {
        btnImage = [UIImage imageNamed:@"Otta_friends_button_block.png"];
    } else {
        btnImage = [UIImage imageNamed:@"Otta_friends_button_added.png"];
    }
    [cell.imgIcon setImage:btnImage];
    
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
    
    [[OttaAlertManager sharedManager] showFriendAlertOnView:self.view withName:name complete:^(FriendAction action) {
        switch (action) {
            case FriendActionBlock:
            {
                PFObject *follow = _follows[indexPath.row];
                [[OttaParseClientManager sharedManager] setBlockFollow:follow withValue:TRUE withBlock:^(BOOL isSucceeded, NSError *error) {
                    [self updateAnswerersAskersCount];
                    [_table reloadData];
                }];
            }
                break;
            case FriendActionRemove:
            {
                PFObject *follow = _follows[indexPath.row];
                [[OttaParseClientManager sharedManager] removeFollow:follow withBlock:^(BOOL isSucceeded, NSError *error) {
                    //remove object in list manually for fixing cache issue
                    arr = [NSMutableArray arrayWithArray:_follows];
                    [arr removeObjectAtIndex:indexPath.row];
                    _follows = [[NSArray alloc] initWithArray:arr];
                    _followsStorage = [[NSArray alloc] initWithArray:arr];
                    
                    [self updateAnswerersAskersCount];
                    [_table reloadData];
                }];
            }
                break;
            default:
                break;
        }
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
    
    [[OttaParseClientManager sharedManager] countUsersFollowToUser:[PFUser currentUser] withBlock:^(int count, NSError *error) {
        self.lblAnswerersCount.text = [NSString stringWithFormat:@"%d",count];
    }];
    [[OttaParseClientManager sharedManager] countUsersFollowFromUser:[PFUser currentUser] withBlock:^(int count, NSError *error) {
        self.lblAskersCount.text = [NSString stringWithFormat:@"%d",count];
    }];
}

- (void) updateUI:(BOOL) isAnswererTab
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
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
            [self.table reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];

    } else {
            
        self.lblAskers.textColor = cusGreencolor;
        self.lblAskersCount.textColor = cusGreencolor;
        self.lblAnswerers.textColor = [UIColor blackColor];
        self.lblAnswerersCount.textColor = [UIColor blackColor];
        
        [[OttaParseClientManager sharedManager] getAllFollowFromUser:[PFUser currentUser] withBlock:^(NSArray *array, NSError *error) {
            _follows = [[NSArray alloc] initWithArray:array];
            _followsStorage = [[NSArray alloc] initWithArray:array];
            [self.table reloadData];
            [MBProgressHUD hideHUDForView:self.view animated:YES];
        }];
    }

}

@end
