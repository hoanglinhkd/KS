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
    [self.delegate addCaptionVC:self addCaption:_captionTextView.text];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.selectedImageView.image = self.image;
}
@end
