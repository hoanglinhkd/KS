//
//  OttaMyQuestionVoteCell.h
//  Otta
//
//  Created by Linh.Nguyen on 12/8/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OttaMyQuestionVoteCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UITableView *tvVoteList;

- (void)setData:(NSArray*)datas;
@end
