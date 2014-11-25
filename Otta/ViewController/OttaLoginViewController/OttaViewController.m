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
#import "OttaLoginContainerViewController.h"

@interface OttaViewController ()<EAIntroDelegate> {
    BOOL isJoinScreen;
    PageShowing currentPageShowing;
    EAIntroView *intro;
}

@property (strong, nonatomic) OttaAlertManager* otta;
@property (nonatomic, weak) OttaLoginContainerViewController *containerViewController;
@property (nonatomic, weak) IBOutlet UIView *containerView;
@end

@implementation OttaViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"OttaSideMenuBackground.png"]];
    
    [self initIntroViews];
    [self showFirstIntroPage];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self checkLoggedin];
}

- (void)checkLoggedin {
    if([PFUser currentUser]) {
        [self performSegueWithIdentifier:@"homeSegue" sender:self];
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
    
    intro = [[EAIntroView alloc] initWithFrame:_ottaBackingView.bounds andPages:@[page1,page2,page3, page4]];
    intro.swipeToExit = NO;
    intro.skipButton.hidden = YES;
    intro.pageControl.pageIndicatorTintColor = [UIColor colorWithRed:(151/255.0) green:(113/255.0) blue:(39/255.0) alpha:1.0];
    intro.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:(249/255.0) green:(175/255.0) blue:(27/255.0) alpha:1.0];
    
    [intro setDelegate:self];
    [intro showInView:_ottaBackingView animateDuration:0.6];
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
    currentPageShowing = PageShowing_IntroPage;
    [_btnBackPage setHidden:YES];
    [_viewAction setHidden:NO];
    [_containerView setHidden:YES];
    
    [_ottaBackingView setUserInteractionEnabled:YES];
    [intro showInView:_ottaBackingView animateDuration:0.4f];
}

-(void) showLoginView
{
    currentPageShowing = PageShowing_LoginPage;
    [_btnBackPage setHidden:NO];
    [_viewAction setHidden:YES];
    
    [_ottaBackingView setUserInteractionEnabled:NO];
    [_containerView setHidden:NO];
    [_containerViewController openLoginViewDetail];
    
    if (![intro isHidden]) {
        [intro hideWithFadeOutDuration:0.4f];
    }
}

-(void) showJoinView
{
    currentPageShowing = PageShowing_JoinPage;
    [_btnBackPage setHidden:NO];
    [_viewAction setHidden:YES];
    [_ottaBackingView setUserInteractionEnabled:NO];
    [_containerView setHidden:NO];
    [_containerViewController openJoinViewDetail];
    
    if (![intro isHidden]) {
        [intro hideWithFadeOutDuration:0.4f];
    }
}

-(void) showFacebookDetail
{
    currentPageShowing = PageShowing_FacebookPage;
    [_btnBackPage setHidden:NO];
    [_viewAction setHidden:YES];
    [_ottaBackingView setUserInteractionEnabled:NO];
    [_containerView setHidden:NO];
    [_containerViewController openFacebookViewDetail];
    
    if (![intro isHidden]) {
        [intro hideWithFadeOutDuration:0.4f];
    }
}

#pragma mark - Event Button

-(IBAction)btnBackTapped:(id)sender
{
    [self showFirstIntroPage];
}

-(IBAction)btnLoginTapped:(id)sender
{
    [self showLoginView];
}

-(IBAction)btnJoinTapped:(id)sender
{
    [self showJoinView];
}

#pragma mark - Facebook
-(IBAction)facebookLogin:(id)sender
{
    //[[OttaSessionManager sharedManager]loginWithFacebook];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSArray *permissionsArray = @[@"user_friends", @"public_profile", @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"];
    // Login PFUser using Facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
                // resultblock(NO);
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
                //resultblock(NO);
                
            }
        } else if (user.isNew) {
            
            [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
                
                if (!error) {
                    NSString *facebookID = [result objectForKey:@"id"];
                    NSString *firstName = [result objectForKey:@"first_name"];
                    NSString *lastName = [result objectForKey:@"last_name"];
                    
                    [user setObject:facebookID forKey:@"facebookId"];
                    [user setObject:firstName forKey:@"firstName"];
                    [user setObject:lastName forKey:@"lastName"];
                    [user saveInBackground];
                }
            }];
            
            NSLog(@"User with facebook signed up and logged in!");
            [self performSegueWithIdentifier:@"FindFriendSegue" sender:self];
            
        } else {
            
            NSLog(@"User with facebook logged in!");
            [self performSegueWithIdentifier:@"homeSegue" sender:self];
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

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"EmbedLoginContainer"]) {
        self.containerViewController = segue.destinationViewController;
        self.containerViewController.loginView = self;
    }
}

#pragma mark - Validate



@end
