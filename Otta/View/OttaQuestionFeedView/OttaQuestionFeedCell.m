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

    OttaAnswer* answer = [[OttaAnswer alloc] init];
    answer.answerText = @"Caesar Blah Caesar Blah Caesar  Blah Caesar Caesar Blah Caesar Blah Caesar  Blah Caesar";
    //answer.answerImage = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];
    
    OttaAnswer* answer1 = [[OttaAnswer alloc] init];
    answer1.answerText = @"Thousand Islands";
    answer1.answerImage = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];
    
    OttaAnswer* answer2 = [[OttaAnswer alloc] init];
    answer2.answerText = @"Strawberry Something";
    //answer2.answerImage = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];
    
    OttaAnswer* answer3 = [[OttaAnswer alloc] init];
    answer3.answerText = @"Japanese noddle with pork";
    answer3.answerImage = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];
    
    
    self.feedItems = [NSArray arrayWithObjects:answer,answer1,answer2,answer3, nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma Table datasource delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
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
    return size.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.feedItems count];
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
    OttaAnswer *answer = self.feedItems[indexPath.row];
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
    OttaAnswer *answer = (OttaAnswer*)[self.feedItems objectAtIndex:indexPath.row];
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
    OttaAnswer *item = self.feedItems[indexPath.row];
    [self setTitleForCell:cell item:item];
    [self setOrderForCell:cell order:[NSString stringWithFormat:@"%d", indexPath.row +1]];
    [self setImageForCell:(id)cell item:item];
}

- (void)setImageForCell:(OttaMediaQuestionCell *)cell item:(OttaAnswer *)item {
    
    [cell.customImageView setImage:nil];
    [cell.customImageView setImage:item.answerImage];
}


@end
