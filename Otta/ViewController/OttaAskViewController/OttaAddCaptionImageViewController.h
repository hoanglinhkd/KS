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


@end

@interface OttaAddCaptionImageViewController : UIViewController

@property (nonatomic, assign) id<OttaAddCaptionDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIImageView *selectedImageView;
@property (weak, nonatomic) IBOutlet SZTextView *captionTextView;
@property (weak, nonatomic) IBOutlet UITextView *questionTextView;
@property (weak, nonatomic) IBOutlet UIView *parentViewCaption;
@property (weak, nonatomic) UIImage *image;
@property (strong, nonatomic) NSString *question;

@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrollContent;
@end
