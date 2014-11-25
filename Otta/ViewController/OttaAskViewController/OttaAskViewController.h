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

@interface OttaAskViewController : OttaTransitionViewController <UITableViewDataSource, UITableViewDelegate, OttaOptionCellDelegate, OttaAddCaptionDelegate>

//@property (nonatomic,strong) OttaAnswerTableController * answerViewController;
//@property (nonatomic,strong) IBOutlet TPKeyboardAvoidingTableView * answerTableView;
@property (nonatomic,strong) CZPhotoPickerController * photoPicker;
@property (nonatomic,strong) IBOutlet UITextView * itsTextView;
@property (nonatomic,strong) UITextView *activeTextField;
@property (nonatomic,strong) IBOutlet UITableView *tableAsk;

@property (nonatomic, strong) NSMutableArray* optionsArray;
- (IBAction)btnNextPress:(id)sender;

@end
