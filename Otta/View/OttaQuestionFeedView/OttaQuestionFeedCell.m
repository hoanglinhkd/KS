//
//  OttaQuestionFeedCell.m
//  Otta
//
//  Created by Gambogo on 11/18/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaQuestionFeedCell.h"
#import "OttaBasicQuestionCell.h"
#import "OttaMediaQuestionCell.h"
#import "OttaViewAllCell.h"
#import "OttaDoneButtonCell.h"
#import "OttaAnswer.h"
#import "OttaParseClientManager.h"

static NSString * const BasicCellId     = @"BasicQuestionCellId";
static NSString * const MediaCellId     = @"MediaQuestionCellId";
static NSString * const ViewAllCellId   = @"OttaViewAllCell";
static NSString * const DoneCellId      = @"OttaDoneButtonCell";

#define kIntervalForceDelete 5.0f
#define kDefaultShowedRow 0
#define kRowForViewAll 1
#define KRowForDoneButton 1

@interface OttaQuestionFeedCell(){
    BOOL isForcedDelete;
}

@end

@implementation OttaQuestionFeedCell
@synthesize selectedIndexPath, submittedIndexPath;
@synthesize isViewAllMode;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setAnswers:(NSMutableArray *)answers {
    _answers = answers;
    
    isForcedDelete = NO;
    if(submittedIndexPath){
        _answers = [NSMutableArray arrayWithObject:answers[submittedIndexPath.row]];
    }
    [self.tableView reloadData];
}

#pragma mark - Table Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //NSIndexPath *firstAnswer =[NSIndexPath indexPathForRow:0 inSection:0];

    if (!isViewAllMode) {
        return kDefaultShowedRow + kRowForViewAll;
    }else{
        if (selectedIndexPath || submittedIndexPath) {
            return [self.answers count] + kRowForViewAll + KRowForDoneButton;
        }else{
            return [self.answers count] + kRowForViewAll;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (isViewAllMode) {
        if (selectedIndexPath || submittedIndexPath) {
            if (indexPath.row == ([self tableView:tableView numberOfRowsInSection:0] - 1)) {
                // is Done button
                return [self doneCellAtIndexPath:indexPath];
            }else if(indexPath.row == ([self tableView:tableView numberOfRowsInSection:0] - 2)){
                // is View All Cell
                return [self cellViewAllAtIndexPath:indexPath];
            }
        }else{
            if(indexPath.row == ([self tableView:tableView numberOfRowsInSection:0] - 1)){
                // is View All Cell
                return [self cellViewAllAtIndexPath:indexPath];
            }
        }
    }else{
        return [self cellViewAllAtIndexPath:indexPath];
    }
    
    if ([self hasImageAtIndexPath:indexPath]) {
        return [self galleryCellAtIndexPath:indexPath];
    } else {
        return [self basicCellAtIndexPath:indexPath];
    }
}
/*
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    viewForSubmit = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 40.0)];
    [viewForSubmit setBackgroundImage:[self imageFromColor:[UIColor orangeColor]] forState:UIControlStateNormal];
    [viewForSubmit setBackgroundImage:[self imageFromColor:kDefaultColorBackGround] forState:UIControlStateSelected];
    [viewForSubmit setBackgroundImage:[self imageFromColor:kDefaultColorBackGround] forState:UIControlStateHighlighted];
    
    
    if (submittedIndexPath == nil) {
        [viewForSubmit setTitle:@"Submit" forState:UIControlStateNormal];
        viewForSubmit.hidden = YES;
        [viewForSubmit addTarget:self action:@selector(submitCellSelected:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [viewForSubmit setTitle:@"Done" forState:UIControlStateNormal];
        viewForSubmit.hidden = NO;
        [viewForSubmit addTarget:self action:@selector(doneCellSelected:) forControlEvents:UIControlEventTouchUpInside];
        submittedIndexPath = nil;
    }
    
    return viewForSubmit;
}
 */
#pragma mark Basic Cell

- (OttaBasicQuestionCell *)basicCellAtIndexPath:(NSIndexPath *)indexPath {
    OttaBasicQuestionCell *cell = [self.tableView dequeueReusableCellWithIdentifier:BasicCellId forIndexPath:indexPath];
    [self configureBasicCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureBasicCell:(OttaBasicQuestionCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    PFObject *answer = self.answers[indexPath.row];
    [self setTitleForCell:cell item:answer];
    [self setOrderForCell:cell order:indexPath];
   
}

- (void)setTitleForCell:(OttaBasicQuestionCell *)cell item:(PFObject *)item {
    NSString *title = ((NSString*)item[kDescription]).length > 0 ? item[kDescription] : NSLocalizedString(@"[No Title]", nil);
    [cell.titleLbl setText:title];
}

- (void)setOrderForCell:(OttaBasicQuestionCell *)cell order:(NSIndexPath*)idx {
    [cell.orderLbl setText:[NSString stringWithFormat:@"%ld", idx.row + 1]];
    
    if (idx.row == submittedIndexPath.row && submittedIndexPath != nil) {
        cell.orderLbl.backgroundColor = [UIColor orangeColor];
    }else{
        cell.orderLbl.backgroundColor = kDefaultColorBackGround;
    }
}
- (void) selectAnswerIndex:(int)answerIndex
{
    //Refresh UI
    [self deselectCell];
    [self tableView:_tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:answerIndex inSection:0]];
}
- (void) deselectCell
{
    NSInteger rowCount = [self tableView:_tableView numberOfRowsInSection:0];
    for (int i = 0; i < rowCount; i ++) {
        NSIndexPath *indexPathRestore = [NSIndexPath indexPathForRow:i inSection:0];
        OttaBasicQuestionCell *cell = (OttaBasicQuestionCell*)[_tableView cellForRowAtIndexPath:indexPathRestore];
        cell.orderLbl.backgroundColor = kDefaultColorBackGround;
    }
    selectedIndexPath = nil;
}

#pragma mark Media Cell

- (BOOL)hasImageAtIndexPath:(NSIndexPath *)indexPath {
    PFObject *answer = [self.answers objectAtIndex:indexPath.row];

    if (((PFFile*)answer[kImage]).url.length > 0) {
        return true;
    }
    return false ;
}
- (OttaMediaQuestionCell *)galleryCellAtIndexPath:(NSIndexPath *)indexPath {
    OttaMediaQuestionCell *cell = [self.tableView dequeueReusableCellWithIdentifier:MediaCellId forIndexPath:indexPath];
    [self configureImageCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureImageCell:(OttaMediaQuestionCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    PFObject *item = self.answers[indexPath.row];
    [self setTitleForCell:cell item:item];
    [self setOrderForCell:cell order:indexPath];
    [self setImageForCell:(id)cell item:item];
    cell.imageBtn.tag = indexPath.row;
    cell.viewAllBtn.hidden = YES;
    cell.collapseBtn.hidden = YES;
}
#pragma mark - Done Cell
- (OttaDoneButtonCell *)doneCellAtIndexPath:(NSIndexPath *)indexPath{
    OttaDoneButtonCell *cell = [self.tableView dequeueReusableCellWithIdentifier:DoneCellId forIndexPath:indexPath];
   
    if (submittedIndexPath) {
        [cell.btnSubmit setTitle:@"Done" forState:UIControlStateNormal];
        [cell.btnSubmit addTarget:self action:@selector(doneCellSelected:) forControlEvents:UIControlEventTouchUpInside];
    }else if(selectedIndexPath){
        [cell.btnSubmit setTitle:@"Submit" forState:UIControlStateNormal];
        [cell.btnSubmit addTarget:self action:@selector(submitCellSelected:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}
#pragma mark - View All Cell
- (OttaViewAllCell*)cellViewAllAtIndexPath:(NSIndexPath*)indexPath{
    OttaViewAllCell *cell = [self.tableView dequeueReusableCellWithIdentifier:ViewAllCellId forIndexPath:indexPath];
    
    if (isViewAllMode) {
        [cell.btnViewAll setTitle:@"Collapse" forState:UIControlStateNormal];
        [cell.btnViewAll addTarget:self action:@selector(collapseBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [cell.btnViewAll setTitle:@"View all..." forState:UIControlStateNormal];
        [cell.btnViewAll addTarget:self action:@selector(viewAllBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return cell;
}

#pragma mark Tableview Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!isViewAllMode) {
        return;
    }
    if (indexPath.row >= self.answers.count) {
        return;
    }
    
    if (selectedIndexPath == indexPath) {
        selectedIndexPath = nil;
        OttaBasicQuestionCell *cell = (OttaBasicQuestionCell*)[tableView cellForRowAtIndexPath:indexPath];
        cell.orderLbl.backgroundColor = kDefaultColorBackGround;
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }else if(selectedIndexPath!=nil){
        OttaBasicQuestionCell *cell = (OttaBasicQuestionCell*)[tableView cellForRowAtIndexPath:selectedIndexPath];
        cell.orderLbl.backgroundColor = kDefaultColorBackGround;
    }
    
    selectedIndexPath = indexPath;
    OttaBasicQuestionCell *cell = (OttaBasicQuestionCell*)[tableView cellForRowAtIndexPath:indexPath];
    cell.orderLbl.backgroundColor = [UIColor orangeColor];
    
    // update show submit button
    [UIView animateWithDuration:0.0 animations:^{
        if (self.delegate && ([(NSObject*)self.delegate respondsToSelector:@selector(questionFeedCell:DidSelectedRowAtIndexPath:)])) {
            UITableView *tbView = (UITableView*)self.superview.superview;
            NSIndexPath *referIdxPath = [tbView indexPathForCell:self];
            [self.delegate questionFeedCell:self DidSelectedRowAtIndexPath:referIdxPath];
        }
        
    } completion:^(BOOL finished) {
        if (finished) {
            //[self.tableView beginUpdates];
            //[self.tableView endUpdates];
        }
    }];
    
}

- (void)setImageForCell:(OttaMediaQuestionCell *)cell item:(PFObject *)item {
    
    [cell.customImageView setImage:nil];

    if (item[kImage] != nil){
        cell.customImageView.image = [UIImage imageNamed:@"thumb.png"];
        [item[kImage] getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
            if (!error) {
                cell.customImageView.image = [UIImage imageWithData:data];
            }
        }];
    } else {
        //Remove because don't have image data
        //[cell.customImageView setImage:item[kImage]];
    }
}


- (IBAction)collapseBtnTapped:(id)sender {
    if (self.delegate && [((NSObject*)self.delegate) respondsToSelector:@selector(optionCell:collapseBtnTapped:)]) {
        UITableView *tv = (UITableView *) self.superview.superview;
        NSIndexPath* pathOfTheCell = [tv indexPathForCell:self];
        [self.delegate optionCell:self collapseBtnTapped:pathOfTheCell];
    }
}

- (IBAction)viewAllBtnTapped:(id)sender {
    if (self.delegate && [((NSObject*)self.delegate) respondsToSelector:@selector(optionCell:viewMoreBtnTapped:)]) {
        UITableView *tv = (UITableView *) self.superview.superview;
        NSIndexPath* pathOfTheCell = [tv indexPathForCell:self];
        [self.delegate optionCell:self viewMoreBtnTapped:pathOfTheCell];
    }
}


- (IBAction)imageBtnTapped:(id)sender {
    return;
    UIButton *btn = (UIButton *)sender;
    NSInteger row = btn.tag;
    [self.delegate optionCell:self imageBtnTappedAtRow:[NSNumber numberWithInteger:row]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isViewAllMode) {
        if (selectedIndexPath || submittedIndexPath) {
            if (indexPath.row == ([self tableView:tableView numberOfRowsInSection:0] - 1)) {
                // is Done button
                return 40.0;
            }else if(indexPath.row == ([self tableView:tableView numberOfRowsInSection:0] - 2)){
                // is View All Cell
                return 30.0;
            }
        }else{
            if (indexPath.row == ([self tableView:tableView numberOfRowsInSection:0] - 1)) {
                return 30.0;
            }
        }
    }else{
        if (indexPath.row == 0) {
            return 30.0;
        }
    }
    
    if ([self hasImageAtIndexPath:indexPath]) {
        return [self heightForImageCellAtIndexPath:indexPath];
    } else {
        return [self heightForBasicCellAtIndexPath:indexPath];
        
    }
}

- (CGFloat)heightForImageCellAtIndexPath:(NSIndexPath *)indexPath
{
    static OttaMediaQuestionCell *sizingCell = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tableView dequeueReusableCellWithIdentifier:MediaCellId];
    });
    
    [self configureImageCell:sizingCell atIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:sizingCell];
}

- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath {
    static OttaBasicQuestionCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tableView dequeueReusableCellWithIdentifier:BasicCellId];
    });
    
    [self configureBasicCell:sizingCell atIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:sizingCell];
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    //NSLog(@"Basic height %f",size.height);
    return size.height;
}

#pragma mark - Utils
- (UIImage *)imageFromColor:(UIColor *)color {
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
#pragma mark - Selectors
- (void)submitCellSelected:(id)sender{
    
    UITableView *tbView = (UITableView*)self.superview.superview;
    NSIndexPath *referIdxPath = [tbView indexPathForCell:self];
    NSLog(@"%ld",referIdxPath.row);
    if (self.delegate && [((NSObject*)self.delegate) respondsToSelector:@selector(questionFeedCell:optionCell:withReferIndexPath:didSubmitRowAtIndexPath:withMaximumCount:)]) {
        
        submittedIndexPath = [NSIndexPath indexPathForRow:selectedIndexPath.row inSection:0];
        NSInteger maxCount = [self tableView:self.tableView numberOfRowsInSection:0];
        
        selectedIndexPath = nil;
        
        [self.delegate questionFeedCell:self optionCell:(OttaBasicQuestionCell*)[self.tableView cellForRowAtIndexPath:submittedIndexPath] withReferIndexPath:referIdxPath didSubmitRowAtIndexPath:submittedIndexPath withMaximumCount:maxCount];
        
        
    }
}
- (void)doneCellSelected:(id)sender{
    if (isForcedDelete)
        return;
    
    isForcedDelete = YES;
    UITableView *tbView = (UITableView*)self.superview.superview;
    NSIndexPath *referIdxPath = [tbView indexPathForCell:self];
    if (self.delegate && [((NSObject*)self.delegate) respondsToSelector:@selector(questionFeedCell:needToForceRemoveAtReferIndex:)]) {
        
        submittedIndexPath = nil;
        selectedIndexPath = nil;
        isViewAllMode = NO;
        [self.delegate questionFeedCell:self needToForceRemoveAtReferIndex:referIdxPath];
    }
}

- (void) startPerformSelectorForDelete{
    [self performSelector:@selector(doneCellSelected:) withObject:nil afterDelay:kIntervalForceDelete];
}
@end




















