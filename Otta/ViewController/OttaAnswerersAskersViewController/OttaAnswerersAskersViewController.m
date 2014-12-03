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

@interface OttaAnswerersAskersViewController ()
{
    NSArray *arr;
    UIColor *cusGreencolor;
}
@end

@implementation OttaAnswerersAskersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    cusGreencolor = [UIColor colorWithRed:0.486275 green:0.741176 blue:0.192157 alpha:1];
    [self.navigationController setNavigationBarHidden:YES];
    self.isAnswererTab = YES;
    // Do any additional setup after loading the view.
    self.friends = [[NSMutableArray alloc] init];
    [self updateAnswerersAskersCount];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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

    OttaFriend *f = (OttaFriend *)[self.friends objectAtIndex:indexPath.row];
    cell.lblText.text = f.name;

    if (f.isFriend){
        btnImage = [UIImage imageNamed:@"Otta_friends_button_added.png"];
    } else {
        btnImage = [UIImage imageNamed:@"Otta_friends_button_add.png"];
    }
    [cell.imgIcon setImage:btnImage];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.friends count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    OttaFriend *f = (OttaFriend *)[self.friends objectAtIndex:indexPath.row];
    
    [[OttaAlertManager sharedManager] showFriendAlertOnView:self.view withName:f.name complete:^(FriendAction action) {
        
    }];
}

- (IBAction)menuButtonPressed:(id)sender {
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

- (IBAction)txtChanged:(UITextField *)sender {
    NSPredicate *predicate =  [NSPredicate predicateWithFormat:
                               @"name CONTAINS[cd] %@", sender.text];
    [self.friends removeAllObjects];
    self.friends = [[NSMutableArray alloc] initWithArray:arr];
    if (![sender.text isEqual: @""]){
        NSArray *newArr = [arr filteredArrayUsingPredicate:predicate];
        self.friends = [[NSMutableArray alloc] initWithArray:newArr];
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
    //PFQuery *query = [PFUser query];
    //PFUser *user1  = (PFUser *)[query getObjectWithId:@"3fRlGvQ8Ld"];
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
    //PFQuery *query = [PFUser query];
    //PFUser *user1  = (PFUser *)[query getObjectWithId:@"3fRlGvQ8Ld"];
    self.isAnswererTab = isAnswererTab;
    switch (isAnswererTab) {
        case YES:
        {
            self.lblAnswerers.textColor = cusGreencolor;
            self.lblAnswerersCount.textColor = cusGreencolor;
            self.lblAskers.textColor = [UIColor blackColor];
            self.lblAskersCount.textColor = [UIColor blackColor];
            [[OttaParseClientManager sharedManager] getAllUsersFollowToUser:[PFUser currentUser] withBlock:^(NSArray *array, NSError *error) {
                [self.friends removeAllObjects];
                for(PFUser *user in array) {
                    NSString *fullname = [NSString stringWithFormat:@"%@ %@", user[@"firstName"], user[@"lastName"]];
                    OttaFriend *friend = [[OttaFriend alloc] initWithName:fullname friendStatus:NO];
                    friend.pfUser = user;
                    [self.friends addObject:friend];
                    
                    
                }
                [self.table reloadData];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            }];

        }
            break;
        case NO:
        {
            self.lblAskers.textColor = cusGreencolor;
            self.lblAskersCount.textColor = cusGreencolor;
            self.lblAnswerers.textColor = [UIColor blackColor];
            self.lblAnswerersCount.textColor = [UIColor blackColor];
            [[OttaParseClientManager sharedManager] getAllUsersFollowFromUser:[PFUser currentUser] withBlock:^(NSArray *array, NSError *error) {
                [self.friends removeAllObjects];
                for(PFUser *user in array) {
                    NSString *fullname = [NSString stringWithFormat:@"%@ %@", user[@"firstName"], user[@"lastName"]];
                    OttaFriend *friend = [[OttaFriend alloc] initWithName:fullname friendStatus:NO];
                    friend.pfUser = user;
                    [self.friends addObject:friend];
                }
                [self.table reloadData];
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                
            }];
        }
            break;
        default:
            break;

    }
}

@end
