//
//  OttaMediaQuestionDetailViewController.h
//  Otta
//
//  Created by Dong Duong on 11/30/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OttaQuestion.h"

@interface OttaMediaQuestionDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *questionbl;
@property (weak, nonatomic) OttaQuestion *question;
@property (weak, nonatomic) IBOutlet UILabel *ownerNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *expirationDateLbl;
@property (weak, nonatomic) IBOutlet UIScrollView *imgscrollView;
@property (weak, nonatomic) IBOutlet UILabel *orderLbl;
@property (weak, nonatomic) IBOutlet UILabel *optiionCell;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@end
