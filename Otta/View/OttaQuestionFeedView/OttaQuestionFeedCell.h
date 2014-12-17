//
//  OttaQuestionFeedCell.h
//  Otta
//
//  Created by Gambogo on 11/18/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OttaQuestionFeedCell;
@protocol OttaQuestionFeedCellDelegate

@optional

- (void)optionCell:(OttaQuestionFeedCell*)cell viewMoreBtnTapped:(id)row;
- (void)optionCell:(OttaQuestionFeedCell*)cell collapseBtnTapped:(id)row;
- (void)optionCell:(OttaQuestionFeedCell*)cell imageBtnTappedAtRow:(id)row;

- (void)optionCell:(OttaQuestionFeedCell*)cell didSelectRowAtIndexPath:(NSIndexPath*)idxPath; 

@end

@interface OttaQuestionFeedCell : UITableViewCell <UITableViewDataSource,  UITableViewDelegate>

@property (weak, nonatomic) id <OttaQuestionFeedCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;

@property (weak, nonatomic) IBOutlet UILabel *ownerNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *questionLbl;
@property (strong, nonatomic) NSArray *answers;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) BOOL isViewAllMode;
@property (nonatomic) int cell3Position;

- (IBAction)collapseBtnTapped:(id)sender;
- (IBAction)viewAllBtnTapped:(id)sender;
- (IBAction)imageBtnTapped:(id)sender;


@end
