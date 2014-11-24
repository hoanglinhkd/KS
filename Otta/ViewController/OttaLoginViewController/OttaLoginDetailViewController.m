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

@implementation OttaLoginDetailViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
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
            
            [self performSegueWithIdentifier:@"homeSegue" sender:self];
        } else {
            
            NSLog(@"Login failed");
            [[OttaAlertManager sharedManager] showSimpleAlertOnView:self.view withContent:[@"Login Failed" toCurrentLanguage] complete:nil];
        }
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
    
}

- (BOOL)validateLogin {
    //Validate required field
    if ([@"" isEqualToString: self.usernameTextField.text] || [@"" isEqualToString:self.passwordTextField.text]) {
        [[OttaAlertManager sharedManager] showSimpleAlertOnView:self.view withContent:[@"Email and Password are required fields." toCurrentLanguage] complete:nil];
        return FALSE;
    }
    //ToDo: Validation Email
    if (![self NSStringIsValidEmail:self.usernameTextField.text]) {
        [[OttaAlertManager sharedManager] showSimpleAlertOnView:self.view withContent:[@"Invalid Email" toCurrentLanguage] complete:nil];
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

@end
