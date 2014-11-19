//
//  OttaFindFriendsViewController.m
//  Otta
//
//  Created by Thien Chau on 11/17/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaFindFriendsViewController.h"
#import <RHAddressBook/AddressBook.h>

@interface OttaFindFriendsViewController ()
{
    OttaFriendsCell *lastCellSelected;
    BOOL isFromContact;//facebook = 1, contacts = 2
    RHAddressBook *addressBook;
    NSArray *listPeople;
    NSMutableArray *friends;
}
@end

@implementation OttaFindFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    addressBook = [[RHAddressBook alloc] init] ;
    
    // Do any additional setup after loading the view.
    self.txtLabel.text = @"Find Friends";
    if (isFromContact){
        self.txtLabel.text = @"Find Contacts";
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    //This is use Address Book
    //https://github.com/heardrwt/RHAddressBook
    if ([RHAddressBook authorizationStatus] == RHAuthorizationStatusNotDetermined
        || [RHAddressBook authorizationStatus] == RHAuthorizationStatusDenied){
        
        [addressBook requestAuthorizationWithCompletion:^(bool granted, NSError *error) {
            if(granted) {
                listPeople = [addressBook people];
                [self loadData];
                [_tableFriends reloadData];
            } else {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
    } else {
        listPeople = [addressBook people];
        [self loadData];
        [_tableFriends reloadData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        friendToAdd.phoneList = [NSMutableArray arrayWithArray:listPhoneCompare];
        
        //List Email to compare
        RHMultiValue *emails = curPersion.emails;
        NSArray *listEmails = [emails values];
        friendToAdd.emailList = [NSMutableArray arrayWithArray:listEmails];
        
        [friends addObject:friendToAdd];
    }
    
    /*
    OttaFriend *f1 = [[OttaFriend alloc] initWithName:@"Jamie Moskowitz" friendStatus:YES];
    OttaFriend *f2 = [[OttaFriend alloc] initWithName:@"Danny Madriz" friendStatus:NO];
    OttaFriend *f3 = [[OttaFriend alloc] initWithName:@"Brandon Baer" friendStatus:YES];
    OttaFriend *f4 = [[OttaFriend alloc] initWithName:@"Austin Thomas" friendStatus:YES];
    OttaFriend *f5 = [[OttaFriend alloc] initWithName:@"Chloe Fulton" friendStatus:NO];
    OttaFriend *f6 = [[OttaFriend alloc] initWithName:@"David Chu" friendStatus:YES];
    OttaFriend *f7 = [[OttaFriend alloc] initWithName:@"Peter Carey" friendStatus:NO];*/
    //friends = [[NSArray alloc] initWithObjects:f1,f2,f3,f4,f5,f6,f7,nil];
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



@end
