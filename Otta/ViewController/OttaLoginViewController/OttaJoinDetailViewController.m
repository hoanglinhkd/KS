//
//  OttaJoinDetailViewController.m
//  Otta
//
//  Created by Gambogo on 11/23/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaJoinDetailViewController.h"
#import "OttaAlertManager.h"

#import "OttaParseClientManager.h"
#import "OttaAppDelegate.h"

@implementation OttaJoinDetailViewController
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

-(IBAction)btnJoinTapped:(id)sender
{
    
    //Validation
    if (![self validateJoin])
        return;
    
    if([OttaNetworkManager isOfflineShowedAlertView]) {
        return;
    }
    
    [[OttaLoadingManager sharedManager] show];
    
    [[OttaParseClientManager sharedManager] joinWithEmail:_emailJoinDetail.text firstName:_firstNameJoinDetail.text phone:_phoneJoinDetail.text lastName:_lastNameJoinDetail.text  password:_passwordJoinDetail.text withResult:^(BOOL joinSucceeded, PFUser* pUser, NSError* error) {
        
        if (joinSucceeded) {
            NSLog(@"Join succeeded");
            
            [_loginView performSegueWithIdentifier:@"FindFriendSegue" sender:self];
        } else {
            NSLog(@"Join failed");
            NSString* str = error.domain;
            
            if (error.code == 202) {
                str = [[[error userInfo] objectForKey:@"error"] stringByReplacingOccurrencesOfString:@"username" withString:@"email"];
            }
            
            [[OttaAlertManager sharedManager] showSimpleAlertOnView:windowView withContent:str complete:nil];
        }
        
        [[OttaLoadingManager sharedManager] hide];
    }];
    
}


-(void)initViews
{
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

- (BOOL)validateJoin {
    
    if (![self NSStringIsValidEmail:self.emailJoinDetail.text]) {
        [[OttaAlertManager sharedManager] showSimpleAlertOnView:windowView withContent:[@"Invalid Email" toCurrentLanguage] complete:nil];
        return FALSE;
    }
    
    //Validate required field
    if ([@"" isEqualToString: self.firstNameJoinDetail.text] || [@"" isEqualToString:self.passwordJoinDetail.text] || [@"" isEqualToString:self.confirmPassJoinDetail.text]
        || [@"" isEqualToString:self.emailJoinDetail.text]) {
        [[OttaAlertManager sharedManager] showSimpleAlertOnView:windowView withContent:[@"Email, Name and Password are required fields." toCurrentLanguage] complete:nil];
        return FALSE;
    }
    
    if (![self.confirmPassJoinDetail.text isEqualToString:self.passwordJoinDetail.text]) {
        [[OttaAlertManager sharedManager] showSimpleAlertOnView:windowView withContent:[@"Your passwords don't match." toCurrentLanguage] complete:nil];
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
