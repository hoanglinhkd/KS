//
//  OttaOptionCell.h
//  Otta
//
//  Created by Thien Chau on 11/13/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OttaOptionCell;
@protocol OttaOptionCellDelegate

@optional

- (void)optionCell:(OttaOptionCell*)cell textBeginEditing:(id)textview;
- (void)optionCell:(OttaOptionCell*)cell textEndEditing:(id)textview;
- (void)optionCell:(OttaOptionCell*)cell beginTakePicture:(id)imageView;

@end

@interface OttaOptionCell : UITableViewCell<OttaOptionCellDelegate>

@property (nonatomic, assign) id<OttaOptionCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UILabel *lblNumber;
@property (weak, nonatomic) IBOutlet UITextView *txtContent;
@property (weak, nonatomic) IBOutlet UIImageView *imgMain;
@property (weak, nonatomic) IBOutlet UIView *viewAction;

- (IBAction)textButtonPressed:(id)sender;
- (IBAction)imageButtonPressed:(id)sender;

@end


