//
//  OttaQuestionFeedCell.h
//  Otta
//
//  Created by Gambogo on 11/18/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OttaQuestionFeedCell : UITableViewCell <UITableViewDataSource,  UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;

@property (weak, nonatomic) IBOutlet UILabel *ownerNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *questionLbl;
@property (strong, nonatomic) NSArray *answers;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) BOOL isViewAllMode;
@property (nonatomic) int cell3Position;

- (IBAction)collapseBtnTapped:(id)sender;
- (IBAction)viewAllBtnTapped:(id)sender;


@end
