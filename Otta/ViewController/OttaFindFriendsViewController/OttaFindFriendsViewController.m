//
//  OttaFindFriendsViewController.m
//  Otta
//
//  Created by Thien Chau on 11/17/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaFindFriendsViewController.h"

@interface OttaFindFriendsViewController ()
{
    OttaFriendsCell *lastCellSelected;
    BOOL isFromContact;//facebook = 1, contacts = 2
}
@end

@implementation OttaFindFriendsViewController
NSArray *friends;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.txtLabel.text = @"Find Friends";
    if (isFromContact){
        self.txtLabel.text = @"Find Contacts";
    }
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
    friends = [[NSArray alloc] initWithObjects:f1,f2,f3,f4,f5,f6,f7,nil];
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
        
        if (f.isFriend){
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
}



@end
