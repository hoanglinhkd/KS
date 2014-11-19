//
//  OttaOptionCell.m
//  Otta
//
//  Created by Thien Chau on 11/13/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaOptionCell.h"

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
    
    [_delegate optionCell:self beginTakePicture:_imgMain];
    
}
- (void)displayThumbAndCaption:(UIImage*)thumb caption:(NSString*)caption {
    
    [self.viewAction setHidden:YES];
    [self.viewContent2 setHidden:NO];
    _imgMain.hidden = FALSE;
    _imgMain.image = thumb;
    _txtImageDescription.hidden = FALSE;
    _txtImageDescription.text = caption;
}

- (void)displayCabtion:(id)caption {
    [self.viewAction setHidden:YES];
    [self.viewContent2 setHidden:NO];
    _txtImageDescription.hidden = FALSE;
    _txtImageDescription.text = caption;
}


#pragma mark - Auto Height Cell
- (void) enableAutoHeightCell
{
    self.txtImageDescription.delegate = self;
    self.txtContent.delegate = self;
}

-(void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    [_delegate optionCell:self textView:growingTextView willChangeHeight:height];
}

#pragma mark textView delegate
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView {
    
    return YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    [_txtContent resignFirstResponder];
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
{
    if ( [text isEqualToString:@"\n"] ) {
        [_txtContent resignFirstResponder];
    }
    return YES;
}

@end
