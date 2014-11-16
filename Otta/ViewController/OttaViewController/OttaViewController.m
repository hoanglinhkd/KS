//
//  OttaViewController.m
//  Otta
//
//  Created by Steven Ojo on 7/27/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//
#import "OttaViewController.h"
#import "OttaAlertManager.h"
#import "MBProgressHUD.h"

@interface OttaViewController ()<EAIntroDelegate> {
    BOOL isJoinScreen;
}

@property (strong, nonatomic) OttaAlertManager* otta;

@end

@implementation OttaViewController
@synthesize ottaBackingView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"OttaSideMenuBackground.png"]];
    
    [self initViews];
    [self initIntroViews];
    [self showFirstIntroPage];
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
    
    //Login Page
    if ([_usernameTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor whiteColor];
        _usernameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[@"Email" toCurrentLanguage] attributes:@{NSForegroundColorAttributeName: color, NSFontAttributeName : [UIFont fontWithName:@"OpenSans-Light" size:20.0]}];
    }
    
    if ([_passwordTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor whiteColor];
        _passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[@"Password" toCurrentLanguage] attributes:@{NSForegroundColorAttributeName: color, NSFontAttributeName : [UIFont fontWithName:@"OpenSans-Light" size:20.0]}];
    }
    
    //Join Page
    if ([_firstNameJoinDetail respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor whiteColor];
        _firstNameJoinDetail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[@"Name" toCurrentLanguage] attributes:@{NSForegroundColorAttributeName: color, NSFontAttributeName : [UIFont fontWithName:@"OpenSans-Light" size:20.0]}];
    }
    
    if ([_lastNameJoinDetail respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor whiteColor];
        _lastNameJoinDetail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[@"Last Name" toCurrentLanguage] attributes:@{NSForegroundColorAttributeName: color, NSFontAttributeName : [UIFont fontWithName:@"OpenSans-Light" size:20.0]}];
    }
    
    if ([_phoneJoinDetail respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor whiteColor];
        _phoneJoinDetail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[@"Phone" toCurrentLanguage] attributes:@{NSForegroundColorAttributeName: color, NSFontAttributeName : [UIFont fontWithName:@"OpenSans-Light" size:20.0]}];
    }
    
    if ([_emailJoinDetail respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor whiteColor];
        _emailJoinDetail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[@"Email" toCurrentLanguage] attributes:@{NSForegroundColorAttributeName: color, NSFontAttributeName : [UIFont fontWithName:@"OpenSans-Light" size:20.0]}];
    }
    
    if ([_passwordJoinDetail respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor whiteColor];
        _passwordJoinDetail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[@"Password" toCurrentLanguage] attributes:@{NSForegroundColorAttributeName: color, NSFontAttributeName : [UIFont fontWithName:@"OpenSans-Light" size:20.0]}];
    }
    
    if ([_confirmPassJoinDetail respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor whiteColor];
        _confirmPassJoinDetail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[@"Confirm password" toCurrentLanguage] attributes:@{NSForegroundColorAttributeName: color, NSFontAttributeName : [UIFont fontWithName:@"OpenSans-Light" size:20.0]}];
    }
}

-(void) initIntroViews
{
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"";
    page1.descFont = [UIFont fontWithName:@"OpenSans-Semibold" size:22.00f];
    page1.desc = [@"Ask a question." toCurrentLanguage];
    page1.descPositionY = 120;
    page1.bgImage = [UIImage imageNamed:@"OttaSideMenuBackground.png"];
    page1.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"con_question.png"]];
    [page1.titleIconView setFrame:CGRectMake(0, 0, 75, 75)];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"";
    page2.descFont = [UIFont fontWithName:@"OpenSans-Semibold" size:22.00f];
    page2.desc = [@"Get input." toCurrentLanguage];
    page2.descPositionY = 120;
    page2.bgImage = [UIImage imageNamed:@"OttaSideMenuBackground.png"];
    page2.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_email.png"]];
    [page2.titleIconView setFrame:CGRectMake(0, 0, 75, 75)];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"";
    page3.descFont = [UIFont fontWithName:@"OpenSans-Semibold" size:22.00f];
    page3.desc = [@"Answer your friends’ questions" toCurrentLanguage];
    page3.descPositionY = 130;
    page3.bgImage = [UIImage imageNamed:@"OttaSideMenuBackground.png"];
    page3.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_open_mail.png"]];
    [page3.titleIconView setFrame:CGRectMake(0, 0, 75, 75)];
    
    EAIntroPage *page4 = [EAIntroPage page];
    page4.title = @"";
    page4.descFont = [UIFont fontWithName:@"OpenSans-Semibold" size:22.00f];
    page4.desc = [@"Decision-making gone social for the indecisive, the curious, and the practical." toCurrentLanguage];
    page4.descPositionY = 155;
    page4.bgImage = [UIImage imageNamed:@"OttaSideMenuBackground.png"];
    page4.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_check.png"]];
    [page4.titleIconView setFrame:CGRectMake(0, 0, 75, 75)];
    
    intro = [[EAIntroView alloc] initWithFrame:self.ottaBackingView.bounds andPages:@[page1,page2,page3, page4]];
    intro.swipeToExit = NO;
    intro.skipButton.hidden = YES;
    intro.pageControl.pageIndicatorTintColor = [UIColor colorWithRed:(151/255.0) green:(113/255.0) blue:(39/255.0) alpha:1.0];
    intro.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:(249/255.0) green:(175/255.0) blue:(27/255.0) alpha:1.0];
    
    [intro setDelegate:self];
    [intro showInView:self.ottaBackingView animateDuration:0.6];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Instro Page Delegate

-(void)introDidFinish
{
    NSLog(@"Intro finished...");
    
}


-(void)intro:(EAIntroView*)intro pageAppeared:(EAIntroPage*)page withIndex:(int)pageIndex
{
    NSLog(@"Page appeared...");
}

#pragma mark - Page Opening

-(void) showFirstIntroPage
{
    [self.ottaBackingView setUserInteractionEnabled:YES];
    [_btnLoginDetail setHidden:YES];
    [_btnBackPage setHidden:YES];
    [_emailTextField setHidden:YES];
    [_emailLine setHidden:YES];
    [_usernameTextField setHidden:YES];
    [_usernameLine setHidden:YES];
    [_passwordTextField setHidden:YES];
    [_passwordLine setHidden:YES];
    [_btnJoin setHidden:NO];
    [_btnLogin setHidden:NO];
    [_btnLoginDetail setHidden:YES];
    [_btnForgotPassword setHidden:YES];
    [_btnFacebook setHidden:NO];
    [_btnFacebookDetail setHidden:YES];
    [_btnJoinDetail setHidden:YES];
    [_scrlUserInformation setHidden:NO];
    [_scrlJoinDetail setHidden:YES];
    [_scrlFacebookDetail setHidden:YES];
    [intro showInView:self.ottaBackingView animateDuration:0.4f];
}

-(void) showLoginView
{
    [self.ottaBackingView setUserInteractionEnabled:NO];
    [_usernameTextField setHidden:NO];
    [_usernameLine setHidden:NO];
    [_passwordTextField setHidden:NO];
    [_passwordLine setHidden:NO];
    
    
    [_btnJoinDetail setHidden:YES];
    [_btnLoginDetail setHidden:NO];
    [_btnLogin setHidden:YES];
    [_emailTextField setHidden:YES];
    [_emailLine setHidden:YES];
    [_btnFacebook setHidden:YES];
    [_btnJoin setHidden:YES];
    [_btnBackPage setHidden:NO];
    [_btnForgotPassword setHidden:NO];
    [_btnFacebookDetail setHidden:YES];
    [_scrlJoinDetail setHidden:YES];
    [_scrlUserInformation setHidden:NO];
    [_btnJoinDetail setHidden:YES];
    
    if (![intro isHidden]) {
        [intro hideWithFadeOutDuration:0.4f];
    }
}

-(void) showJoinView
{
    [self.ottaBackingView setUserInteractionEnabled:NO];
    
    [_btnJoinDetail setHidden:NO];
    [_btnJoin setHidden:YES];
    [_btnLogin setHidden:YES];
    [_btnFacebook setHidden:YES];
    [_btnBackPage setHidden:NO];
    [_btnForgotPassword setHidden:NO];
    [_scrlJoinDetail setHidden:NO];
    [_btnFacebookDetail setHidden:YES];
    [_scrlUserInformation setHidden:YES];
    [_scrlFacebookDetail setHidden:YES];
    if (![intro isHidden]) {
        [intro hideWithFadeOutDuration:0.4f];
    }
}

-(void) showFacebookDetail
{
    [self.ottaBackingView setUserInteractionEnabled:NO];
    
    [_btnJoinDetail setHidden:NO];
    [_btnJoin setHidden:YES];
    [_btnLogin setHidden:YES];
    [_btnLoginDetail setHidden:YES];
    [_btnFacebook setHidden:YES];
    [_btnBackPage setHidden:NO];
    [_btnForgotPassword setHidden:YES];
    [_btnFacebookDetail setHidden:NO];
    [_scrlFacebookDetail setHidden:NO];
    [_scrlJoinDetail setHidden:YES];
    [_scrlUserInformation setHidden:YES];
    
    if (![intro isHidden]) {
        [intro hideWithFadeOutDuration:0.4f];
    }
}

#pragma mark - Event Button

-(IBAction)btnForgotPasswordTapped:(id)sender
{
    
}

-(IBAction)btnBackTapped:(id)sender
{
    [self showFirstIntroPage];
    
}

-(IBAction)btnLoginTapped:(id)sender
{
    //Is login screen
    if ([self.usernameTextField isHidden]) {
        [self showLoginView];
    } else {
        //TO DO: Validation required field, validation email format
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[OttaParseClientManager sharedManager] loginWithEmail:self.usernameTextField.text andPassword:self.passwordTextField.text withResult:^(BOOL joinSucceeded, PFUser *pUser, NSString *failureReason) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (joinSucceeded) {
                NSLog(@"Login succeeded");
                
                [self performSegueWithIdentifier:@"AskViewControllerSegue" sender:self];
                
            } else {
                NSLog(@"Login failed");
                [[OttaAlertManager sharedManager] showSimpleAlertOnView:self.view withContent:[@"Login Failed" toCurrentLanguage] complete:nil];
            }
        }];
    }
}

-(IBAction)btnJoinTapped:(id)sender
{
    //Is join Screen
    if ([self.emailTextField isHidden]) {
        [self showJoinView];
    } else {
        //TO DO: Validation required field, validation email format
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[OttaParseClientManager sharedManager] joinWithEmail:self.emailTextField.text andUsername:self.usernameTextField.text andPassword:self.passwordTextField.text withResult:^(BOOL joinSucceeded, PFUser *pUser, NSString *failureReason) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (joinSucceeded) {
                NSLog(@"Join succeeded");

                [self performSegueWithIdentifier:@"AskViewControllerSegue" sender:self];

            } else {
                NSLog(@"Join failed");
                [[OttaAlertManager sharedManager] showSimpleAlertOnView:self.view withContent:[@"Register Failed" toCurrentLanguage] complete:nil];
            }
        }];
    }
    
}

#pragma mark - Facebook
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

#pragma mark - Text Field
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
