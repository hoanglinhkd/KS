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
#import  "OttaAnswer.h"

static NSString * const BasicCellId = @"BasicQuestionCellId";
static NSString * const MediaCellId = @"MediaQuestionCellId";

@implementation OttaQuestionFeedCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setAnswers:(NSArray *)answers {
    _answers = answers;
    [self.tableView reloadData];
}

#pragma Table datasource delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self hasImageAtIndexPath:indexPath]) {
        int height = [self heightForImageCellAtIndexPath:indexPath];

        return height;
    } else {
        return [self heightForBasicCellAtIndexPath:indexPath] -10;
        
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
    NSLog(@"Basic height %f",size.height);
    return size.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSIndexPath *firstAnswer =[NSIndexPath indexPathForRow:0 inSection:0];

    
    if (!_isViewAllMode &&[self hasImageAtIndexPath:firstAnswer])
        
        return 3;
    
    return [self.answers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self hasImageAtIndexPath:indexPath]) {
        return [self galleryCellAtIndexPath:indexPath];
        
    } else {
        return [self basicCellAtIndexPath:indexPath];
    }
}

#pragma mark Basic Cell

- (OttaBasicQuestionCell *)basicCellAtIndexPath:(NSIndexPath *)indexPath {
    OttaBasicQuestionCell *cell = [self.tableView dequeueReusableCellWithIdentifier:BasicCellId forIndexPath:indexPath];
    [self configureBasicCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureBasicCell:(OttaBasicQuestionCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    OttaAnswer *answer = self.answers[indexPath.row];
    [self setTitleForCell:cell item:answer];
    [self setOrderForCell:cell order:[NSString stringWithFormat:@"%d", indexPath.row +1]];
   
}

- (void)setTitleForCell:(OttaBasicQuestionCell *)cell item:(OttaAnswer *)item {
    NSString *title = item.answerText?: NSLocalizedString(@"[No Title]", nil);
    [cell.titleLbl setText:title];
}

- (void)setOrderForCell:(OttaBasicQuestionCell *)cell order:(NSString *)order {
    [cell.orderLbl setText:order];
}

#pragma mark Media Cell

- (BOOL)hasImageAtIndexPath:(NSIndexPath *)indexPath {
    OttaAnswer *answer = (OttaAnswer*)[self.answers objectAtIndex:indexPath.row];
    if (answer.answerImage) {
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
    OttaAnswer *item = self.answers[indexPath.row];
    [self setTitleForCell:cell item:item];
    [self setOrderForCell:cell order:[NSString stringWithFormat:@"%d", indexPath.row +1]];
    [self setImageForCell:(id)cell item:item];
    cell.imageBtn.tag = indexPath.row;
    if (self.answers.count > 3 ) {
        if (indexPath.row == 2 && _isViewAllMode == FALSE) {
            cell.viewAllBtn.hidden = NO;
            cell.collapseBtn.hidden = YES;
            cell.collapseHeghtConstraint.constant = 22;
        } else if (indexPath.row == self.answers.count -1 ) {
            cell.collapseBtn.hidden = NO;
            cell.viewAllBtn.hidden = YES;
            cell.collapseHeghtConstraint.constant = 22;
        } else {
            cell.viewAllBtn.hidden = YES;
            cell.collapseBtn.hidden = YES;
            cell.collapseHeghtConstraint.constant = 0;
        }

    } else {
        cell.viewAllBtn.hidden = YES;
        cell.collapseBtn.hidden = YES;
        cell.collapseHeghtConstraint.constant = 0;
    }

}
#pragma mark Tableview Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
}


- (void)setImageForCell:(OttaMediaQuestionCell *)cell item:(OttaAnswer *)item {
    
    [cell.customImageView setImage:nil];
    [cell.customImageView setImage:item.answerImage];
}


- (IBAction)collapseBtnTapped:(id)sender {
    _isViewAllMode = NO;
    [self.tableView reloadData];
    
    UITableView *tv = (UITableView *) self.superview.superview;
    NSIndexPath* pathOfTheCell = [tv indexPathForCell:self];
    
    [self.delegate optionCell:self collapseBtnTapped:[NSNumber numberWithInt:pathOfTheCell.row]];
    [UIView animateWithDuration:0.25 animations:^{
        
        [tv beginUpdates];
        [tv endUpdates];
        
    }];
}

- (IBAction)viewAllBtnTapped:(id)sender {
    _isViewAllMode = YES;
    [self.tableView reloadData];
    UITableView *tv = (UITableView *) self.superview.superview;
    NSIndexPath* pathOfTheCell = [tv indexPathForCell:self];
    [self.delegate optionCell:self viewMoreBtnTapped:[NSNumber numberWithInt:pathOfTheCell.row]];
    [UIView animateWithDuration:0.25 animations:^{

        [tv beginUpdates];
        [tv endUpdates];
    }];
}

- (IBAction)imageBtnTapped:(id)sender {
    UIButton *btn = (UIButton *)sender;
    
}
@end
