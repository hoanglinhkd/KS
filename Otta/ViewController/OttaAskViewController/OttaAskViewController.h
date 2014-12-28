//
//  OttaAskViewController.h
//  Otta
//
//  Created by Steven Ojo on 8/20/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OttaAnswerTableController.h"
#import "CZPhotoPickerController.h"
#import "TPKeyboardAvoidingTableView.h"
#import "OttaOptionCell.h"
#import "OttaAddCaptionImageViewController.h"
#import "OttaTransitionViewController.h"
#import "SZTextView.h"
#import "OttaAnswerersViewController.h"

@interface OttaAskViewController : OttaTransitionViewController <UITableViewDataSource, UITableViewDelegate, OttaOptionCellDelegate, OttaAddCaptionDelegate, OttaAnswerersViewControllerDelegate>

//@property (nonatomic,strong) OttaAnswerTableController * answerViewController;
//@property (nonatomic,strong) IBOutlet TPKeyboardAvoidingTableView * answerTableView;
@property (nonatomic,strong) CZPhotoPickerController * photoPicker;
@property (nonatomic,strong) IBOutlet SZTextView * itsTextView;
@property (nonatomic,strong) UITextView *activeTextField;
@property (nonatomic,strong) IBOutlet UITableView *tableAsk;
@property (nonatomic,strong) IBOutlet NSLayoutConstraint *heightAskContent;
@property (nonatomic, strong) NSMutableArray* optionsArray;
@property (weak, nonatomic) IBOutlet UIButton *btnNext;




- (IBAction)btnNextPress:(id)sender;

- (IBAction)pressBtnLogo:(id)sender;

@end
