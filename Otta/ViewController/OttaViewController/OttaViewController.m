//
//  OttaViewController.m
//  Otta
//
//  Created by Steven Ojo on 7/27/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//
#define openSansFontRegular [UIFont fontWithName:@"OpenSans-Light" size:18.00f];
#import "OttaViewController.h"

@interface OttaViewController ()<EAIntroDelegate>

@end

@implementation OttaViewController
@synthesize ottaBackingView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"OttaGreenBackground.png"]];
    
    [self initIntroViews];
}


-(void) initIntroViews
{
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"";
    page1.descFont = openSansFontRegular;
    page1.desc = @"Ask a question.";
    page1.bgImage = [UIImage imageNamed:@"OttaGreenBackground.png"];
    page1.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"OttaIntroImage.png"]];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"";
    page2.descFont = openSansFontRegular;
    page2.desc = @"Get input.";
    page2.bgImage = [UIImage imageNamed:@"OttaGreenBackground.png"];
    page2.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"OttaIntroMessage.png"]];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"";
    page3.descFont = openSansFontRegular;
    page3.desc = @"Answer your friends’ questions";
    page3.bgImage = [UIImage imageNamed:@"OttaGreenBackground.png"];
    page3.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"OttaIntroAnswer.png"]];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:self.ottaBackingView.bounds andPages:@[page1,page2,page3]];
    intro.swipeToExit = NO;
    
    [intro setDelegate:self];
    [intro showInView:self.ottaBackingView animateDuration:0.6];
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

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (textView.textColor == [UIColor lightGrayColor]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(textView.text.length == 0){
        textView.textColor = [UIColor lightGrayColor];
      //  itsTextView.text = @"Ask a question...";
        [textView resignFirstResponder];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        if(textView.text.length == 0){
            textView.textColor = [UIColor lightGrayColor];
           // itsTextView.text = @"Ask a question...";
            [textView resignFirstResponder];
        }
        return NO;
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}


@end
