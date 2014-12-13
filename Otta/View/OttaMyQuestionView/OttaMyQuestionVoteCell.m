//
//  OttaMyQuestionVoteCell.m
//  Otta
//
//  Created by Linh.Nguyen on 12/8/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaMyQuestionVoteCell.h"
#import "OttaUser.h"

@interface OttaMyQuestionVoteCell()<UITableViewDataSource, UITableViewDelegate>{
    NSArray *arrData;
}
@end

@implementation OttaMyQuestionVoteCell

- (void)awakeFromNib {
    // Initialization code
    self.tvVoteList.delegate   = self;
    self.tvVoteList.dataSource = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(NSArray *)datas{
    arrData = [[NSArray alloc] initWithArray:datas];
    [self.tvVoteList reloadData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return arrData.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"OttaMyQuestionVoteChildCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont fontWithName:@"OpenSans" size:13];
    }
    OttaUser *dto = [arrData objectAtIndex:indexPath.row];
    cell.textLabel.text = [@"       " stringByAppendingFormat:@"%@ %@",dto.firstName,dto.lastName];
    cell.backgroundColor = tableView.backgroundColor;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 20.0;
}
@end
