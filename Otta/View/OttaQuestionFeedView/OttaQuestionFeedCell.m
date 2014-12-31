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
#import "OttaQuestionFeedViewController.h"

static NSString * const BasicCellId     = @"BasicQuestionCellId";
static NSString * const MediaCellId     = @"MediaQuestionCellId";
static NSString * const ViewAllCellId   = @"OttaViewAllCell";
static NSString * const DoneCellId      = @"OttaDoneButtonCell";

#define kIntervalForceDelete 5.0f
#define kDefaultShowedRow 0
#define kRowForViewAll 1
#define KRowForDoneButton 1
#define kSelectedColorCell [[UIColor grayColor] colorWithAlphaComponent:0.3f]
#define kHeightOfDoneButton 37.0f
#define kHeightOfViewAllCell 30.0f

@interface OttaQuestionFeedCell(){
    BOOL isForcedDelete;
    NSIndexPath *myIdxCacheForDelete;
}

@end

static NSObject *myObj;

@implementation OttaQuestionFeedCell
@synthesize selectedIndexPath, submittedIndexPath;
@synthesize isViewAllMode;

- (void)awakeFromNib {
    // Initialization code
    myObj = [[NSObject alloc] init];
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
            return [self.answers count] + KRowForDoneButton;
        }else{
            return [self.answers count] + kRowForViewAll;
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (isViewAllMode) {
        if (submittedIndexPath) {
            if (indexPath.row==0) {
                // Show simple row
                if ([self hasImageAtIndexPath:indexPath]) {
                    return [self galleryCellAtIndexPath:indexPath];
                } else {
                    return [self basicCellAtIndexPath:indexPath];
                }
            }else if (indexPath.row == 1){
                // is Done button
                return [self doneCellAtIndexPath:indexPath];
            }
        }else{
            // check lasted row
            if (indexPath.row == ([self tableView:tableView numberOfRowsInSection:0] - 1)) {
                if (selectedIndexPath) {
                    // is Done button
                    return [self doneCellAtIndexPath:indexPath];
                }else{
                    // is not selected => show view all
                    // is View All Cell
                    return [self cellViewAllAtIndexPath:indexPath];
                }
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
    NSString *title = ((NSString*)item[kDescription]).length > 0 ? item[kDescription] : @"";
    [cell.titleLbl setText:title];
}

- (void)setOrderForCell:(OttaBasicQuestionCell *)cell order:(NSIndexPath*)idx {
    [cell.orderLbl setText:[NSString stringWithFormat:@"%ld", idx.row + 1]];
    
    if (submittedIndexPath) {
        if (idx.row == 0) {
            cell.orderLbl.backgroundColor = kSelectedColor;
            cell.orderLbl.text = [NSString stringWithFormat:@"%ld", submittedIndexPath.row + 1];
            cell.backgroundColor = kSelectedColorCell;
            [self boldFontForLabel:cell.orderLbl];
            [self boldFontForLabel:cell.titleLbl];
        }
    }else{
        if (idx.row == selectedIndexPath.row && selectedIndexPath != nil) {
            cell.orderLbl.backgroundColor = kSelectedColor;
            cell.orderLbl.text = [NSString stringWithFormat:@"%ld", selectedIndexPath.row + 1];
            cell.backgroundColor = kSelectedColorCell;
            [self boldFontForLabel:cell.orderLbl];
            [self boldFontForLabel:cell.titleLbl];
        }else{
            cell.orderLbl.backgroundColor = kDefaultColorBackGround;
            cell.backgroundColor = [UIColor whiteColor];
            [self regularFontForLabel:cell.orderLbl];
            [self regularFontForLabel:cell.titleLbl];
        }
    }
    
}
- (void) selectAnswerIndex:(NSInteger)answerIndex
{
    //Refresh UI
    [self deselectCell];
    [self tableView:_tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:answerIndex inSection:0]];
}
- (void) deselectCell
{
    NSInteger rowCount = [self tableView:_tableView numberOfRowsInSection:0] - kRowForViewAll;
    for (int i = 0; i < rowCount; i ++) {
        NSIndexPath *indexPathRestore = [NSIndexPath indexPathForRow:i inSection:0];
        OttaBasicQuestionCell *cell = (OttaBasicQuestionCell*)[_tableView cellForRowAtIndexPath:indexPathRestore];
        cell.orderLbl.backgroundColor = kDefaultColorBackGround;
        [self regularFontForLabel:cell.orderLbl];
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
    cell.backgroundColor = cell.btnSubmit.backgroundColor;
    if (submittedIndexPath) {
        [cell.btnSubmit setTitle:@"Done" forState:UIControlStateNormal];
        [cell.btnSubmit removeTarget:self action:@selector(submitCellSelected:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnSubmit addTarget:self action:@selector(doneCellSelected:) forControlEvents:UIControlEventTouchUpInside];
    }else if(selectedIndexPath){
        [cell.btnSubmit setTitle:@"Submit" forState:UIControlStateNormal];
        [cell.btnSubmit removeTarget:self action:@selector(doneCellSelected:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnSubmit addTarget:self action:@selector(submitCellSelected:) forControlEvents:UIControlEventTouchUpInside];
    }
    return cell;
}
#pragma mark - View All Cell
- (OttaViewAllCell*)cellViewAllAtIndexPath:(NSIndexPath*)indexPath{
    OttaViewAllCell *cell = [self.tableView dequeueReusableCellWithIdentifier:ViewAllCellId forIndexPath:indexPath];
    
    if (isViewAllMode) {
        [cell.btnViewAll setTitle:@"Collapse" forState:UIControlStateNormal];
        [cell.btnViewAll removeTarget:self action:@selector(viewAllBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnViewAll addTarget:self action:@selector(collapseBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    }else{
        [cell.btnViewAll setTitle:@"View options..." forState:UIControlStateNormal];
        [cell.btnViewAll removeTarget:self action:@selector(collapseBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
        [cell.btnViewAll addTarget:self action:@selector(viewAllBtnTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return cell;
}

#pragma mark Tableview Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    /*
    if (!isViewAllMode) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        return;
    }
     */
    if (self.selectedIndexPath==nil && submittedIndexPath==nil) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        if (indexPath.row == [self tableView:self.tableView numberOfRowsInSection:0] - 1) {
            if (self.isViewAllMode) {
                [self collapseBtnTapped:nil];
            }else{
                [self viewAllBtnTapped:nil];
            }
            return;
        }
    }
    if (indexPath.row >= self.answers.count) {
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
        return;
    }
    
    
    if (selectedIndexPath == indexPath) {
        // for deselected current cell
        selectedIndexPath = nil;
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        /*
        OttaBasicQuestionCell *cell = (OttaBasicQuestionCell*)[tableView cellForRowAtIndexPath:indexPath];
        cell.orderLbl.backgroundColor = kDefaultColorBackGround;
        [self regularFontForLabel:cell.orderLbl];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
         */
    }else{
        // for current selected cell
        selectedIndexPath = indexPath;
    }
    
    // update show submit button
    [UIView animateWithDuration:0.0 animations:^{
        if (self.delegate && ([(NSObject*)self.delegate respondsToSelector:@selector(questionFeedCell:DidSelectedRowAtIndexPath:withSelectedIndex:)])) {
            UITableView *tbView = (UITableView*)self.superview.superview;
            NSIndexPath *referIdxPath = [tbView indexPathForCell:self];
            [self.delegate questionFeedCell:self DidSelectedRowAtIndexPath:referIdxPath withSelectedIndex:selectedIndexPath];
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
    UIButton *btn = (UIButton *)sender;
    NSInteger row = btn.tag;
    [self.delegate optionCell:self imageBtnTappedAtRow:row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (isViewAllMode) {
        if(submittedIndexPath){
            if (indexPath.row==0) {
                // Show simple row
                if ([self hasImageAtIndexPath:indexPath]) {
                    return [self heightForImageCellAtIndexPath:indexPath];
                } else {
                    return [self heightForBasicCellAtIndexPath:indexPath];
                    
                }
            }else if (indexPath.row == 1){
                // is Done button
                return kHeightOfDoneButton;
            }
        }else{
            if (indexPath.row == ([self tableView:tableView numberOfRowsInSection:0] - 1)) {
                if (selectedIndexPath) {
                    // is Done button
                    return kHeightOfDoneButton;
                }else{
                    // is View All Cell
                    return kHeightOfViewAllCell;
                }
            }
        }
    }else{
        if (indexPath.row == 0) {
            return kHeightOfViewAllCell;
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
        
        [self.delegate questionFeedCell:self optionCell:(OttaBasicQuestionCell*)[self.tableView cellForRowAtIndexPath:submittedIndexPath] withReferIndexPath:referIdxPath didSubmitRowAtIndexPath:submittedIndexPath withMaximumCount:maxCount];
        
        
    }
}
- (void)doneCellSelected:(id)sender{
    if (isForcedDelete)
        return;
    
    isForcedDelete = YES;
    UITableView *tbView = (UITableView*)self.superview.superview;
    NSIndexPath *referIdxPath = [tbView indexPathForCell:self];
    NSLog(@"referIdxPath %ld",referIdxPath.row);
    
    if (referIdxPath!=nil) {
        NSLog(@"refer %ld",referIdxPath.row);
        if (self.delegate && [((NSObject*)self.delegate) respondsToSelector:@selector(questionFeedCell:needToForceRemoveAtReferIndex:)]) {
            // remove perform seletor
            [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(doneCellSelected:) object:nil];
            
            // Transfer delegate action to ViewController
            [self.delegate questionFeedCell:self needToForceRemoveAtReferIndex:referIdxPath];
        }
    }
}

- (void) startPerformSelectorForDelete{
    // add perform Selector
    [self performSelector:@selector(doneCellSelected:) withObject:self afterDelay:kIntervalForceDelete];
}


#pragma mark - Utils
-(void)boldFontForLabel:(UILabel *)label{
    UIFont *newFont = [UIFont fontWithName:@"OpenSans-Bold" size:15];
    label.font = newFont;
}
-(void)regularFontForLabel:(UILabel*)label{
    UIFont *newFont = [UIFont fontWithName:@"OpenSans" size:15];
    label.font = newFont;
}
@end




















