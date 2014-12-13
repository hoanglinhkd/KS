//
//  OttaAddCaptionImageViewController.m
//  Otta
//
//  Created by Gambogo on 11/18/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaAddCaptionImageViewController.h"


@implementation OttaAddCaptionImageViewController

-(IBAction)btnNextTapped:(id)sender
{
    if([self.delegate respondsToSelector:@selector(addCaptionVC:addCaption:)]) {
        [self.delegate addCaptionVC:self addCaption:_captionTextView.text];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.selectedImageView.image = self.image;
    self.questionTextView.text = self.question;
    [_questionTextView setFont:[UIFont fontWithName:@"OpenSans-Light" size:17.00f]];
    
    _captionTextView.placeholderTextColor = [UIColor whiteColor];
    _captionTextView.placeholder = @"Add a caption?";
    
    [_scrollContent contentSizeToFit];
    [_scrollContent setContentOffset:_parentViewCaption.frame.origin animated:NO];
}


- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}


@end
