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

@interface OttaFindFriendsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txtLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableFriends;

@end
