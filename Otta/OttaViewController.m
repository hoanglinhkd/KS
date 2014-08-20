//
//  OttaViewController.m
//  Otta
//
//  Created by Steven Ojo on 7/27/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaViewController.h"

@interface OttaViewController ()

@end

@implementation OttaViewController

- (void)viewDidLoad
{
    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"OttaGreenBackground.png"]];

    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            [self performSegueWithIdentifier:@"AskViewControllerSegue" sender:self];

            //resultblock(YES);
            
        } else {
            NSLog(@"User with facebook logged in!");
            [self performSegueWithIdentifier:@"AskViewControllerSegue" sender:self];

            ///resultblock(YES);
            
        }
    }];
}



@end
