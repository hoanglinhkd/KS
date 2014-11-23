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
#import "OttaTransitionViewController.h"

@interface OttaAnswerersAskersViewController : OttaTransitionViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btnAddNew;
@property (weak, nonatomic) IBOutlet UIButton *btnInvite;
@property (weak, nonatomic) IBOutlet UITextField *txtLabel;
@property (strong, nonatomic) NSMutableArray *friends;
@property (weak, nonatomic) IBOutlet UITableView *table;
- (IBAction)btnAddNew:(id)sender;
- (IBAction)btnInvite:(id)sender;
- (IBAction)txtChanged:(UITextField *)sender;

@end
