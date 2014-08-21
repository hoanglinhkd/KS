//
//  OttaAskViewController.h
//  Otta
//
//  Created by Steven Ojo on 8/20/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OttaAnswerTableController.h"
@interface OttaAskViewController : UIViewController
@property (nonatomic,strong)OttaAnswerTableController * answerViewController;
@property (nonatomic,strong)IBOutlet UITableView * answerTableView;
-(IBAction)addQuestionButtonText:(id)sender;

@end
