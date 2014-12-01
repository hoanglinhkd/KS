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

@property (weak, nonatomic) IBOutlet UITextField *txtLabel;
@property (strong, nonatomic) NSMutableArray *friends;
@property (weak, nonatomic) IBOutlet UITableView *table;

- (IBAction)txtChanged:(UITextField *)sender;

- (IBAction)btnAnswerPressed:(id)sender;
- (IBAction)btnAskPressed:(id)sender;
@end
