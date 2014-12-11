//
//  OttaOptionCell.h
//  Otta
//
//  Created by Thien Chau on 11/13/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPGrowingTextView.h"

@class OttaOptionCell;
@protocol OttaOptionCellDelegate

@optional

- (void)optionCell:(OttaOptionCell*)cell textBeginEditing:(id)textview;
- (void)optionCell:(OttaOptionCell*)cell textEndEditing:(id)textview;
- (void)optionCell:(OttaOptionCell*)cell beginTakePicture:(id)imageView;
- (void)optionCell:(OttaOptionCell*)cell textView:(HPGrowingTextView*)textViewUpdateHeight willChangeHeight:(float)height;
- (void)optionCell:(OttaOptionCell*)cell addCabtion:(id)caption;
- (void)optionCell:(OttaOptionCell*)cell needEditPicture:(id)imageView;

@end

@interface OttaOptionCell : UITableViewCell<OttaOptionCellDelegate, UITextViewDelegate, HPGrowingTextViewDelegate>

@property (nonatomic, assign) id <OttaOptionCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *lblNumber;
@property (weak, nonatomic) IBOutlet HPGrowingTextView *txtContent;
@property (weak, nonatomic) IBOutlet UIView *viewAction;
@property (weak, nonatomic) IBOutlet HPGrowingTextView *txtImageDescription;

@property (weak, nonatomic) IBOutlet UIView *viewContent2;
@property (weak, nonatomic) IBOutlet UIImageView *imgMain;

- (IBAction)textButtonPressed:(id)sender;
- (IBAction)imageButtonPressed:(id)sender;

- (void) enableAutoHeightCell;
- (void)displayThumbAndCaption:(UIImage*)thumb caption:(NSString*)caption;
- (void)displayCabtion:(id)caption;


@end
