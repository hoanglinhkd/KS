//
//  OttaMyQuestionBasicCell.m
//  Otta
//
//  Created by cscv on 12/1/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaMyQuestionBasicCell.h"

@interface OttaMyQuestionBasicCell()<UITableViewDataSource, UITableViewDelegate>{
    NSArray *datas;
}

@end

@implementation OttaMyQuestionBasicCell
@synthesize tvData, lblTitle;

- (void)awakeFromNib {
    // Initialization code
    tvData.dataSource   = self;
    tvData.delegate     = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setData:(NSArray*)data{
    datas = [[NSArray alloc] initWithArray:data];
    [tvData reloadData];
}

#pragma mark - UITableview Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return datas.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
