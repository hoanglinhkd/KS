//
//  OttaViewController.m
//  Otta
//
//  Created by Steven Ojo on 7/27/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//
#define openSansFontRegular [UIFont fontWithName:@"OpenSans-Light" size:18.00f];
#import "OttaViewController.h"

@interface OttaViewController ()

@end

@implementation OttaViewController
@synthesize ottaBackingView;

- (void)viewDidLoad
{
  
    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"OttaGreenBackground.png"]];
    
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"";
    page1.descFont = openSansFontRegular;

    page1.desc = @"Decision-making gone social for the indecisive, the curious, and the practical.";
    
    page1.bgImage = [UIImage imageNamed:@"OttaGreenBackground.png"];
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"";
    page2.descFont = openSansFontRegular;
    page2.desc = @"Ask a question, specify the options, give a deadline, and get your friends' input.";
    page2.bgImage = [UIImage imageNamed:@"OttaGreenBackground.png"];
    
    [UIFont fontWithName:@"OpenSans-Extrabold" size:13.0f];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"";
    page3.descFont = openSansFontRegular;
    page3.desc = @"Select and send an answer to your friends' questions to help them decide. ";
    page3.bgImage = [UIImage imageNamed:@"OttaGreenBackground.png"];

    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.ottaBackingView.bounds andPages:@[page1,page2,page3]];
    intro.swipeToExit = NO;
    
    [intro setDelegate:self];
    [intro showInView:self.ottaBackingView animateDuration:0.6];


    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)introDidFinish
{
    NSLog(@"Intro finished...");
    
}


-(void)intro:(EAIntroView*)intro pageAppeared:(EAIntroPage*)page withIndex:(int)pageIndex
{
    NSLog(@"Page appeared...");
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

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [self animateTextView: YES];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [self animateTextView:NO];
}

- (void) animateTextView:(BOOL) up
{
    const int movementDistance =200.00; // tweak as needed
    const float movementDuration = 0.3f; // tweak as needed
    int movement= movement = (up ? -movementDistance : movementDistance);
    NSLog(@"%d",movement);
    
    [UIView beginAnimations: @"anim" context: nil];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration: movementDuration];
    self.view.frame = CGRectOffset(self.inputView.frame, 0, movement);
    [UIView commitAnimations];
}



@end
