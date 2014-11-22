//
//  OttaQuestionFeedViewController.h
//  Otta
//
//  Created by Dong Duong on 11/18/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OttaQuestionFeedCell.h"

@interface OttaQuestionFeedViewController : UIViewController <UITableViewDataSource, OttaQuestionFeedCellDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end
