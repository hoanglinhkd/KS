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

//Login Detail Page
@property (nonatomic,strong)IBOutlet UITextField * usernameTextField;
@property (nonatomic,strong)IBOutlet UIView *usernameLine;
@property (nonatomic,strong)IBOutlet UITextField * passwordTextField;
@property (nonatomic,strong)IBOutlet UIView *passwordLine;
@property (nonatomic,strong)IBOutlet UITextField * emailTextField;
@property (nonatomic,strong)IBOutlet UIView *emailLine;

@property (nonatomic,strong)IBOutlet UIButton *btnLogin;
@property (nonatomic,strong)IBOutlet UIButton *btnLoginDetail;
@property (nonatomic,strong)IBOutlet UIButton *btnJoin;
@property (nonatomic,strong)IBOutlet UIButton *btnFacebook;
@property (nonatomic,strong)IBOutlet UIButton *btnBackPage;
@property (nonatomic,strong)IBOutlet UIButton *btnForgotPassword;
@property (nonatomic,strong)IBOutlet UIScrollView *scrlUserInformation;

//Join Detail Page
@property (nonatomic,strong)IBOutlet UITextField * firstNameJoinDetail;
@property (nonatomic,strong)IBOutlet UITextField * lastNameJoinDetail;
@property (nonatomic,strong)IBOutlet UITextField * emailJoinDetail;
@property (nonatomic,strong)IBOutlet UITextField * passwordJoinDetail;
@property (nonatomic,strong)IBOutlet UITextField * phoneJoinDetail;
@property (nonatomic,strong)IBOutlet UITextField * confirmPassJoinDetail;
@property (nonatomic,strong)IBOutlet UIButton * btnJoinDetail;
@property (nonatomic,strong)IBOutlet UIScrollView *scrlJoinDetail;

//FaceBook Detail Page
@property (nonatomic,strong)IBOutlet UITextField * phoneFacebookDetail;
@property (nonatomic,strong)IBOutlet UITextField * emailFacebookDetail;
@property (nonatomic,strong)IBOutlet UIScrollView *scrlFacebookDetail;
@property (nonatomic,strong)IBOutlet UIButton *btnFacebookDetail;

-(IBAction)facebookLogin:(id)sender;

@end
