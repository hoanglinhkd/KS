//
//  OttaFindFriendsViewController.m
//  Otta
//
//  Created by Thien Chau on 11/17/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaAnswerersAskersViewController.h"
#import "UIViewController+ECSlidingViewController.h"

@interface OttaAnswerersAskersViewController ()
{
    NSArray *arr;
}
@end

@implementation OttaAnswerersAskersViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    
    // Do any additional setup after loading the view.
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData{
    OttaFriend *f1 = [[OttaFriend alloc] initWithName:@"Jamie Moskowitz" friendStatus:YES];
    OttaFriend *f2 = [[OttaFriend alloc] initWithName:@"Danny Madriz" friendStatus:NO];
    OttaFriend *f3 = [[OttaFriend alloc] initWithName:@"Brandon Baer" friendStatus:YES];
    OttaFriend *f4 = [[OttaFriend alloc] initWithName:@"Austin Thomas" friendStatus:YES];
    OttaFriend *f5 = [[OttaFriend alloc] initWithName:@"Chloe Fulton" friendStatus:NO];
    OttaFriend *f6 = [[OttaFriend alloc] initWithName:@"David Chu" friendStatus:YES];
    OttaFriend *f7 = [[OttaFriend alloc] initWithName:@"Peter Carey" friendStatus:NO];
    arr = [[NSArray alloc] initWithObjects:f1,f2,f3,f4,f5,f6,f7,nil];
    self.friends = [[NSMutableArray alloc] initWithObjects:f1,f2,f3,f4,f5,f6,f7,nil];
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
    
    btnImage = [UIImage imageNamed:@"Otta_friends_button_add.png"];
    
    if (indexPath.row == 0){
        cell.lblText.text = @"Select All";
    } else{
        OttaFriend *f = (OttaFriend *)[self.friends objectAtIndex:indexPath.row-1];
        cell.lblText.text = f.name;
        
        if (f.isFriend){
            btnImage = [UIImage imageNamed:@"Otta_friends_button_added.png"];
        }
    }
    
    [cell.imgIcon setImage:btnImage];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.friends count]+1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)menuButtonPressed:(id)sender {
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}


- (IBAction)btnAddNew:(id)sender {
}

- (IBAction)btnInvite:(id)sender {
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

@end
