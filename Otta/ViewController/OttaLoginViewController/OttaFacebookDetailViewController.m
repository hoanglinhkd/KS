//
//  OttaFacebookDetailViewController.m
//  Otta
//
//  Created by Gambogo on 11/23/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaFacebookDetailViewController.h"
#import <Parse/Parse.h>

@implementation OttaFacebookDetailViewController

-(void) viewDidLoad
{
    [super viewDidLoad];
    
    [self initViews];
}

-(void) initViews
{
    //Facebook Page
    if ([_emailFacebookDetail respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor whiteColor];
        _emailFacebookDetail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[@"Email" toCurrentLanguage] attributes:@{NSForegroundColorAttributeName: color, NSFontAttributeName : [UIFont fontWithName:@"OpenSans-Light" size:20.0]}];
    }
    
    if ([_phoneFacebookDetail respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor whiteColor];
        _phoneFacebookDetail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[@"Phone" toCurrentLanguage] attributes:@{NSForegroundColorAttributeName: color, NSFontAttributeName : [UIFont fontWithName:@"OpenSans-Light" size:20.0]}];
    }
}

-(IBAction)facebookLogin:(id)sender
{
    
}


@end
