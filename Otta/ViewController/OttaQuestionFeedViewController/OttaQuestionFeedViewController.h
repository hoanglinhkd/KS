//
//  OttaQuestionFeedViewController.h
//  Otta
//
//  Created by Gambogo on 11/18/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OttaQuestionFeedCell.h"
#import "OttaMediaQuestionDetailViewController.h"

@interface OttaQuestionFeedViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, OttaQuestionFeedCellDelegate, OttaMediaQuestionDetailViewControllerDelegate>


@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)pressBtnLogo:(id)sender;

@property (strong, nonatomic)NSIndexPath *currentSelectedCell;
+ (OttaQuestionFeedViewController*)sharedInstance;

@end
