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
    _imgMain.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tapped = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
    tapped.numberOfTapsRequired = 1;
    [_imgMain addGestureRecognizer:tapped];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
    NSLog(@"touch here");
}

-(void)displayViewAction
{
    _viewAction.hidden = NO;
    _txtContent.hidden = YES;
    _txtImageDescription.returnKeyType = UIReturnKeyDone;
    _txtContent.returnKeyType = UIReturnKeyDone;
}

-(void)displayContent:(NSString *)answerContent
{
    _viewAction.hidden = TRUE;
    _txtContent.hidden = FALSE;
    [_txtContent setText:answerContent];
    _txtContent.returnKeyType = UIReturnKeyDone;
}

- (IBAction)textButtonPressed:(id)sender {
    _viewAction.hidden = TRUE;
    _txtContent.hidden = FALSE;
    _txtContent.delegate = self;
    _answer.answerHasContent = YES;
    [_txtContent becomeFirstResponder];
    [_txtContent setText:_answer.answerText];
    _txtContent.returnKeyType = UIReturnKeyDone;
    
    if([_delegate respondsToSelector:@selector(optionCell:textBeginEditing:)]) {
        [_delegate optionCell:self textBeginEditing:_txtContent];
    }
}

- (IBAction)imageButtonPressed:(id)sender {
    if([_delegate respondsToSelector:@selector(optionCell:beginTakePicture:)]) {
        [_delegate optionCell:self beginTakePicture:_imgMain];
    }
    _answer.answerHasphoto = YES;
    _txtImageDescription.delegate = self;
    _txtImageDescription.returnKeyType = UIReturnKeyDone;
}

- (void)displayThumbAndCaption:(UIImage*)thumb caption:(NSString*)caption {
    
    [self.viewAction setHidden:YES];
    [self.viewContent2 setHidden:NO];
    _imgMain.hidden = FALSE;
    _imgMain.image = thumb;
    _txtImageDescription.hidden = FALSE;
    _txtImageDescription.text = caption;
    _txtImageDescription.returnKeyType = UIReturnKeyDone;
    _answer.answerImage = thumb;
    _answer.answerText = caption;
}

- (void)displayCabtion:(id)caption {
    [self.viewAction setHidden:YES];
    [self.viewContent2 setHidden:NO];
    _answer.answerText = caption;
    _txtImageDescription.hidden = FALSE;
    _txtImageDescription.text = caption;
    _txtImageDescription.returnKeyType = UIReturnKeyDone;
}


#pragma mark - Auto Height Cell
- (void) enableAutoHeightCell
{
    self.txtImageDescription.delegate = self;
    self.txtContent.delegate = self;
}

-(void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
    if([_delegate respondsToSelector:@selector(optionCell:textView:willChangeHeight:)]) {
        [_delegate optionCell:self textView:growingTextView willChangeHeight:height];
    }
}

-(void)growingTextViewDidChange:(HPGrowingTextView *)growingTextView
{
    _answer.answerText = growingTextView.text;
}

#pragma mark textView delegate

- (void)growingTextViewDidEndEditing:(HPGrowingTextView *)growingTextView
{
    if (growingTextView == _txtContent) {
        if([_delegate respondsToSelector:@selector(optionCell:textEndEditing:)]) {
            [_delegate optionCell:self textEndEditing:_txtContent.text];
        }
    } else if (growingTextView == _txtImageDescription) {
        if([_delegate respondsToSelector:@selector(optionCell:textEndEditing:)]) {
            [_delegate optionCell:self textEndEditing:_txtImageDescription.text];
        }
    }
    
}

- (BOOL)growingTextView:(HPGrowingTextView *)growingTextView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [growingTextView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView {
    
    return YES;
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    [_txtContent resignFirstResponder];
    if([_delegate respondsToSelector:@selector(optionCell:textEndEditing:)]) {
        [_delegate optionCell:self textEndEditing:_txtContent];
    }
    
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
{
    if ( [text isEqualToString:@"\n"] ) {
        [_txtContent resignFirstResponder];
        if([_delegate respondsToSelector:@selector(optionCell:textEndEditing:)]) {
            [_delegate optionCell:self textEndEditing:_txtContent.text];
        }
    }
    return YES;
}

#pragma mark - Selector
- (void)handlePinch:(UIPinchGestureRecognizer *)pinchGestureRecognizer
{
    //handle pinch
    if (self.delegate && [(NSObject*)self.delegate respondsToSelector:@selector(optionCell:needEditPicture:)]) {
        [self.delegate optionCell:self needEditPicture:_imgMain];
    }
}

@end
