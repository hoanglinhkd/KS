//
//  OttaViewController.h
//  Otta
//
//  Created by Steven Ojo on 7/27/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <EAIntroView.h>
#import "OttaSessionManager.h"
#import "OttaParseClientManager.h"

#import "OttaAlertManager.h"

@interface OttaViewController : UIViewController
{
    EAIntroView *intro;
}

@property (nonatomic,strong) IBOutlet UIView * ottaBackingView;
@property (nonatomic,strong)IBOutlet UITextField * usernameTextField;
@property (nonatomic,strong)IBOutlet UIView *usernameLine;
@property (nonatomic,strong)IBOutlet UITextField * passwordTextField;
@property (nonatomic,strong)IBOutlet UIView *passwordLine;
@property (nonatomic,strong)IBOutlet UITextField * emailTextField;
@property (nonatomic,strong)IBOutlet UIView *emailLine;

@property (nonatomic,strong)IBOutlet UIButton *btnLogin;
@property (nonatomic,strong)IBOutlet UIButton *btnJoin;
@property (nonatomic,strong)IBOutlet UIButton *btnFacebook;
@property (nonatomic,strong)IBOutlet UIButton *btnBackPage;
@property (nonatomic,strong)IBOutlet UIButton *btnForgotPassword;
@property (nonatomic,strong)IBOutlet UIScrollView *scrlUserInformation;


-(IBAction)facebookLogin:(id)sender;

@end
