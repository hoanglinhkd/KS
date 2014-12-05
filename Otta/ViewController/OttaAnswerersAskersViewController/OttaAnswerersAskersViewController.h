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


@property (strong, nonatomic) NSArray *follows;
@property (strong, nonatomic) NSArray *followsStorage;
@property (assign, nonatomic) BOOL isAnswererTab;//True=Answer,False = Asker


@property (weak, nonatomic) IBOutlet UITextField *txtLabel;
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UILabel *lblAnswerers;
@property (weak, nonatomic) IBOutlet UILabel *lblAskers;
@property (weak, nonatomic) IBOutlet UILabel *lblAskersCount;
@property (weak, nonatomic) IBOutlet UILabel *lblAnswerersCount;



- (IBAction)txtChanged:(UITextField *)sender;
- (IBAction)btnAnswerPressed:(id)sender;
- (IBAction)btnAskPressed:(id)sender;

@end
