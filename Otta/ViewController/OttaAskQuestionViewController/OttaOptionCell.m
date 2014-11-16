//
//  OttaOptionCell.m
//  Otta
//
//  Created by Thien Chau on 11/13/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaOptionCell.h"
#import "CZPhotoPickerController.h"

@implementation OttaOptionCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)textButtonPressed:(id)sender {
    _viewAction.hidden = TRUE;
    _txtContent.hidden = FALSE;
    [_txtContent becomeFirstResponder];
    
    [_delegate optionCell:self textBeginEditing:_txtContent];
}

- (IBAction)imageButtonPressed:(id)sender {
    _viewAction.hidden = TRUE;
    _txtContent.hidden = FALSE;
    _imgMain.hidden = FALSE;
    [_delegate optionCell:self beginTakePicture:_imgMain];

}

@end
