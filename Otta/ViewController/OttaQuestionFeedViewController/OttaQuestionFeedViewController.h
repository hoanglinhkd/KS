//
//  OttaQuestionFeedViewController.h
//  Otta
//
//  Created by Gambogo on 11/18/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OttaQuestionFeedCell.h"
#import "SVPullToRefresh.h"

@interface OttaQuestionFeedViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, OttaQuestionFeedCellDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)pressBtnLogo:(id)sender;
@end
