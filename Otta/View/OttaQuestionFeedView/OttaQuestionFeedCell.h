//
//  OttaQuestionFeedCell.h
//  Otta
//
//  Created by Gambogo on 11/18/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OttaBasicQuestionCell.h"

#define kDefaultColorBackGround [UIColor colorWithRed:143*1.0/255 green:202*1.0/255 blue:64*1.0/255 alpha:1.0f]

@class OttaQuestionFeedCell;
@protocol OttaQuestionFeedCellDelegate

@optional

- (void)optionCell:(OttaQuestionFeedCell*)cell viewMoreBtnTapped:(id)row;
- (void)optionCell:(OttaQuestionFeedCell*)cell collapseBtnTapped:(id)row;
- (void)optionCell:(OttaQuestionFeedCell*)cell imageBtnTappedAtRow:(id)row;

- (void)questionFeedCell:(OttaQuestionFeedCell*)cell DidSelectedRowAtIndexPath:(NSIndexPath*)indexPath;
- (void)questionFeedCell:(OttaQuestionFeedCell*)parentCell optionCell:(OttaBasicQuestionCell*)cell withReferIndexPath:(NSIndexPath*)referIdx didSubmitRowAtIndexPath:(NSIndexPath*)childIdxPath withMaximumCount:(NSInteger)maxCount;
- (void)questionFeedCell:(OttaQuestionFeedCell*)parentCell needToForceRemoveAtReferIndex:(NSIndexPath*)indexPath;
@end

@interface OttaQuestionFeedCell : UITableViewCell <UITableViewDataSource,  UITableViewDelegate>


@property (strong, nonatomic) UIButton *viewForSubmit;
@property (strong, nonatomic) NSIndexPath *selectedIndexPath;
@property (strong, nonatomic) NSIndexPath *submittedIndexPath;
@property (weak, nonatomic) id <OttaQuestionFeedCellDelegate>delegate;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;

@property (weak, nonatomic) IBOutlet UILabel *ownerNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *questionLbl;
@property (strong, nonatomic) NSMutableArray *answers;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) BOOL isViewAllMode;
@property (nonatomic) int cell3Position;

- (IBAction)collapseBtnTapped:(id)sender;
- (IBAction)viewAllBtnTapped:(id)sender;
- (IBAction)imageBtnTapped:(id)sender;
- (void) startPerformSelectorForDelete;

- (void) selectAnswerIndex:(int)answerIndex;
- (void) deselectCell;
@end
