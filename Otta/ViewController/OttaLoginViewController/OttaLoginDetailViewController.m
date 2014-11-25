//
//  OttaLoginDetailViewController.m
//  Otta
//
//  Created by Gambogo on 11/23/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaLoginDetailViewController.h"
#import "OttaAlertManager.h"
#import "MBProgressHUD.h"
#import "OttaParseClientManager.h"
#import "OttaAppDelegate.h"

@implementation OttaLoginDetailViewController
{
    UIView *windowView;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    OttaAppDelegate *appDelegate = (OttaAppDelegate*)[UIApplication sharedApplication].delegate;
    windowView = appDelegate.window;
    
    [self initViews];
}

-(void) initViews
{
    //Login Page
    if ([_usernameTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor whiteColor];
        _usernameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[@"Email" toCurrentLanguage] attributes:@{NSForegroundColorAttributeName: color, NSFontAttributeName : [UIFont fontWithName:@"OpenSans-Light" size:20.0]}];
    }
    
    if ([_passwordTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor whiteColor];
        _passwordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:[@"Password" toCurrentLanguage] attributes:@{NSForegroundColorAttributeName: color, NSFontAttributeName : [UIFont fontWithName:@"OpenSans-Light" size:20.0]}];
    }
}

-(IBAction)btnLoginTapped:(id)sender
{
    //Validate required field
    if (![self validateLogin]) {
        return;
    }
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[OttaParseClientManager sharedManager] loginWithNameOrEmail:self.usernameTextField.text andPassword:self.passwordTextField.text withResult:^(BOOL joinSucceeded, PFUser *pUser, NSError* error) {
        
        if (joinSucceeded) {
            NSLog(@"Login succeeded");
            
            [_loginView performSegueWithIdentifier:@"homeSegue" sender:self];
        } else {
            
            NSLog(@"Login failed");
            [[OttaAlertManager sharedManager] showSimpleAlertOnView:windowView withContent:[@"Login Failed" toCurrentLanguage] complete:nil];
        }
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}

- (BOOL)validateLogin {
    //Validate required field
    if ([@"" isEqualToString: self.usernameTextField.text] || [@"" isEqualToString:self.passwordTextField.text]) {
        [[OttaAlertManager sharedManager] showSimpleAlertOnView:windowView withContent:[@"Email and Password are required fields." toCurrentLanguage] complete:nil];
        return FALSE;
    }
    //ToDo: Validation Email
    if (![self NSStringIsValidEmail:self.usernameTextField.text]) {
        [[OttaAlertManager sharedManager] showSimpleAlertOnView:windowView withContent:[@"Invalid Email" toCurrentLanguage] complete:nil];
        return FALSE;
    }
    
    return TRUE;
}

//TODO: Will move this function to NSString+utils

-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

- (IBAction)btnForgotPassTapped:(id)sender {
    NSLog(@"Forgot pass");
    [[OttaAlertManager sharedManager] showEmailAlertOnView:windowView complete:^(NSString *email) {
        __block NSString* mess = @"Invalid email!";
        if ([Constant isValidEmail:email]) {
            [MBProgressHUD showHUDAddedTo:windowView animated:YES];
            [[OttaParseClientManager sharedManager] resetPasswordWithEmail:email withResult:^(BOOL isSucceeded, NSError *error) {
                [MBProgressHUD hideHUDForView:windowView animated:YES];
                
                if (isSucceeded) {
                    mess = [@"Password reset successful. Please check your email!" toCurrentLanguage];
                } else {
                    if (error.code == 205) {
                        mess = [error.userInfo objectForKey:@"error"];
                    } else {
                        mess = [@"password reset failed!" toCurrentLanguage];
                    }
                }
                [[OttaAlertManager sharedManager] showSimpleAlertOnView:windowView withContent:mess complete:^{
                }];
            }];
        } else {
            [self performSelector:@selector(showError:) withObject:mess afterDelay:1];
        }
    } cancel:^{
        
    }];
}

- (void)showError:(NSString*)mess {
    [[OttaAlertManager sharedManager] showSimpleAlertOnView:windowView withContent:mess complete:^{
    }];
}

@end
