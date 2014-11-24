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
    
    //[[OttaSessionManager sharedManager]loginWithFacebook];
    
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
    
    // Login PFUser using Facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        //[_activityIndicator stopAnimating]; // Hide loading indicator
        
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
                // resultblock(NO);
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
                //resultblock(NO);
                
            }
        } else if (user.isNew) {
            NSLog(@"User with facebook signed up and logged in!");
            [_loginView performSegueWithIdentifier:@"FindFriendSegue" sender:self];
            //[[OttaUserManager sharedManager] saveCurrentUser:user];;
        } else {
            NSLog(@"User with facebook logged in!");
            [_loginView performSegueWithIdentifier:@"homeSegue" sender:self];
            //[[OttaUserManager sharedManager] saveCurrentUser:user];
        }
    }];
    
}


@end
