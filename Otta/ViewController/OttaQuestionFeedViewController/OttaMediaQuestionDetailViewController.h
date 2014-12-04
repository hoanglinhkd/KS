//
//  OttaMediaQuestionDetailViewController.h
//  Otta
//
//  Created by Thien Chau on 11/30/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OttaQuestion.h"

@interface OttaMediaQuestionDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *questionbl;
@property (strong, nonatomic) OttaQuestion *question;
@property (weak, nonatomic) IBOutlet UILabel *ownerNameLbl;
@property (weak, nonatomic) IBOutlet UILabel *expirationDateLbl;
@property (weak, nonatomic) IBOutlet UIScrollView *imgscrollView;
@property (weak, nonatomic) IBOutlet UILabel *orderLbl;
@property (weak, nonatomic) IBOutlet UILabel *optionLbl;
@property (weak, nonatomic) IBOutlet UIButton *selectBtn;

@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
- (IBAction)leftBtnTapped:(id)sender;

- (IBAction)rightBtnTapped:(id)sender;

@property int currentOption;

@end
