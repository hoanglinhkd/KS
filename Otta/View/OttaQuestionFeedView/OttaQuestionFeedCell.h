//
//  OttaQuestionFeedCell.h
//  Otta
//
//  Created by Gambogo on 11/18/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OttaQuestionFeedCell : UITableViewCell <UITableViewDataSource,  UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;

@property (weak, nonatomic) IBOutlet UILabel *ownerNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *questionLbl;
@property (strong, nonatomic) NSArray *feedItems;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
