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

enum screenTypes
{
    Answerers,
    Askers
};

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
    
    // Do any additional setup after loading the view.
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData{
    /*
    OttaFriend *f1 = [[OttaFriend alloc] initWithName:@"Jamie Moskowitz" friendStatus:YES];
    OttaFriend *f2 = [[OttaFriend alloc] initWithName:@"Danny Madriz" friendStatus:NO];
    OttaFriend *f3 = [[OttaFriend alloc] initWithName:@"Brandon Baer" friendStatus:YES];
    OttaFriend *f4 = [[OttaFriend alloc] initWithName:@"Austin Thomas" friendStatus:YES];
    OttaFriend *f5 = [[OttaFriend alloc] initWithName:@"Chloe Fulton" friendStatus:NO];
    OttaFriend *f6 = [[OttaFriend alloc] initWithName:@"David Chu" friendStatus:YES];
    OttaFriend *f7 = [[OttaFriend alloc] initWithName:@"Peter Carey" friendStatus:NO];
    arr = [[NSArray alloc] initWithObjects:f1,f2,f3,f4,f5,f6,f7,nil];
    self.friends = [[NSMutableArray alloc] initWithObjects:f1,f2,f3,f4,f5,f6,f7,nil];
     */
    self.friends = [[NSMutableArray alloc] initWithObjects:nil];
    [self updateUI:Askers];
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
    NSLog(@"friend name: ------------- %@",f.name);

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
    [self updateUI:Answerers];
}

- (IBAction)btnAskPressed:(id)sender {
    [self updateUI:Askers];
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

- (void) updateUI:(enum screenTypes) type
{
    PFQuery *query = [PFUser query];
    //PFUser *user1  = (PFUser *)[query getObjectWithId:@"3fRlGvQ8Ld"];


    switch (type) {
        case Answerers:
        {
            self.lblAnswerers.textColor = cusGreencolor;
            self.lblAnswerersCount.textColor = cusGreencolor;
            self.lblAskers.textColor = [UIColor blackColor];
            self.lblAskersCount.textColor = [UIColor blackColor];
            [[OttaParseClientManager sharedManager] getAllFollowToUser:[PFUser currentUser] withBlock:^(NSArray *array, NSError *error) {
                [self.friends removeAllObjects];
                for (id curUserFollow in array) {
                    PFUser *curFollow = [curUserFollow objectForKey:@"from"];
                    PFUser *user  = (PFUser *)[query getObjectWithId:curFollow.objectId];
                    NSString *fullname = [NSString stringWithFormat:@"%@ %@", user[@"firstName"], user[@"lastName"]];
                    OttaFriend *friend = [[OttaFriend alloc] initWithName:fullname friendStatus:NO];
                    friend.pfUser = user;
                    [self.friends addObject:friend];
                }
                [self.table reloadData];
            }];

            }
            break;
        case Askers:
        {
            self.lblAskers.textColor = cusGreencolor;
            self.lblAskersCount.textColor = cusGreencolor;
            self.lblAnswerers.textColor = [UIColor blackColor];
            self.lblAnswerersCount.textColor = [UIColor blackColor];
            [[OttaParseClientManager sharedManager] getAllFollowFromUser:[PFUser currentUser] withBlock:^(NSArray *array, NSError *error) {
                [self.friends removeAllObjects];
                
                for (id curUserFollow in array) {
                    PFUser *curTo = [curUserFollow objectForKey:@"to"];
                    PFUser *user  = (PFUser *)[query getObjectWithId:curTo.objectId];
                    NSString *fullname = [NSString stringWithFormat:@"%@ %@", user[@"firstName"], user[@"lastName"]];
                    OttaFriend *friend = [[OttaFriend alloc] initWithName:fullname friendStatus:NO];
                    friend.pfUser = user;
                    [self.friends addObject:friend];
                }
                [self.table reloadData];
            }];
        }
            break;
        default:
            break;

    }
}

@end
