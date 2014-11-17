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
#import  "OttaQuestion.h"

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

#pragma Table datasource delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.feedItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self basicCellAtIndexPath:indexPath];
}

- (OttaBasicQuestionCell *)basicCellAtIndexPath:(NSIndexPath *)indexPath {
    OttaBasicQuestionCell *cell = [self.tableView dequeueReusableCellWithIdentifier:BasicCellId forIndexPath:indexPath];
    [self configureBasicCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureBasicCell:(OttaBasicQuestionCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSString *item = self.feedItems[indexPath.row];
    [self setTitleForCell:cell item:item];
   
}

- (void)setTitleForCell:(OttaBasicQuestionCell *)cell item:(NSString *)item {
    NSString *title = item?: NSLocalizedString(@"[No Title]", nil);
    [cell.titleLbl setText:title];
}

@end
