//
//  OttaAddCaptionImageViewController.h
//  Otta
//
//  Created by Gambogo on 11/18/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SZTextView.h"
#import "TPKeyboardAvoidingScrollView.h"

@class OttaAddCaptionImageViewController;

@protocol OttaAddCaptionDelegate <NSObject>

@optional

- (void)addCaptionVC:(OttaAddCaptionImageViewController*)captionVC addCaption:(id)caption;
- (void)cancelCaptionVC:(OttaAddCaptionImageViewController*)captionVC;
- (void)deleteCaptionVC:(OttaAddCaptionImageViewController*)captionVC;
@end

@interface OttaAddCaptionImageViewController : UIViewController <UITextViewDelegate>

@property (nonatomic, assign) id<OttaAddCaptionDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;
@property (weak, nonatomic) IBOutlet SZTextView *captionTextView;
@property (weak, nonatomic) IBOutlet UITextView *questionTextView;
@property (weak, nonatomic) IBOutlet UIButton *btnDiscard;
@property (assign, nonatomic) BOOL shouldHideBtnDiscard;
@property (weak, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *question;
@property (strong,nonatomic) NSString *captionValue;

@end
