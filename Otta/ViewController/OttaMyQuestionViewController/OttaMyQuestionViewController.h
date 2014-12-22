//
//  OttaMyQuestionViewController.h
//  Otta
//
//  Created by Thien Chau on 11/30/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVPullToRefresh.h"

@interface OttaMyQuestionViewController : UIViewController
- (IBAction)pressMenuBtn:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;

- (IBAction)pressBtnLogo:(id)sender;
@end
