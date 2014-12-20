//
//  OttaAddCaptionImageViewController.m
//  Otta
//
//  Created by Gambogo on 11/18/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaAddCaptionImageViewController.h"
#import "OttaAppDelegate.h"

@interface OttaAddCaptionImageViewController ()

@property (nonatomic, strong) NSLayoutConstraint *bottomConstraint;

- (void)keyboardWillHide:(NSNotification *)sender;
- (void)keyboardDidShow:(NSNotification *)sender;

@end

@implementation OttaAddCaptionImageViewController

-(IBAction)btnNextTapped:(id)sender
{
    if([self.delegate respondsToSelector:@selector(addCaptionVC:addCaption:)]) {
        [self.delegate addCaptionVC:self addCaption:_captionTextView.text];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)btnDiscardTapped:(id)sender
{
    OttaAppDelegate *appDelegate = (OttaAppDelegate*)[UIApplication sharedApplication].delegate;
    [[OttaAlertManager sharedManager] showYesNoAlertOnView:appDelegate.window withContent:[@"Do you want to delete ?" toCurrentLanguage] complete:^{
        
        if([self.delegate respondsToSelector:@selector(deleteCaptionVC:)]) {
            [self.delegate deleteCaptionVC:self];
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } cancel:^{
        
    }];
}

-(void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(_shouldHideBtnDiscard) {
        [_btnDiscard setHidden:YES];
    }
    
    self.selectedImageView.image = self.image;
    self.questionTextView.text = self.question;
    [_questionTextView setFont:[UIFont fontWithName:@"OpenSans-Light" size:17.00f]];
    
    _captionTextView.placeholderTextColor = [UIColor whiteColor];
    _captionTextView.placeholder = [@"Add a caption?" toCurrentLanguage];
    _captionTextView.delegate = self;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];;
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}


#pragma mark - Notification Handlers

- (void)keyboardDidShow:(NSNotification *)sender {
    NSDictionary *userInfo = sender.userInfo;
    NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    CGRect keyboardFrameEnd = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardFrameEnd = [self.view convertRect:keyboardFrameEnd fromView:nil];
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionBeginFromCurrentState | curve animations:^{
        self.view.frame = CGRectMake(0, 0, keyboardFrameEnd.size.width, keyboardFrameEnd.origin.y);
    } completion:nil];
}

- (void)keyboardWillHide:(NSNotification *)sender {
    NSDictionary *userInfo = sender.userInfo;
    NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    UIViewAnimationCurve curve = [userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
    
    CGRect keyboardFrameEnd = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    keyboardFrameEnd = [self.view convertRect:keyboardFrameEnd fromView:nil];
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionBeginFromCurrentState | curve animations:^{
        self.view.frame = CGRectMake(0, 0, keyboardFrameEnd.size.width, keyboardFrameEnd.origin.y);
    } completion:nil];
}

@end
