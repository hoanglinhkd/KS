//
//  OttaLoginContainerViewController.m
//  Otta
//
//  Created by Gambogo on 11/23/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaLoginContainerViewController.h"
#import "OttaJoinDetailViewController.h"
#import "OttaLoginDetailViewController.h"
#import "OttaFacebookDetailViewController.h"

@interface OttaLoginContainerViewController()
@property (strong, nonatomic) NSString *currentSegueIdentifier;
@property (assign, nonatomic) BOOL transitionInProgress;

@property (nonatomic, strong) OttaJoinDetailViewController *joinDetailVC;
@property (nonatomic, strong) OttaLoginContainerViewController *loginDetailVC;
@property (nonatomic, strong) OttaFacebookDetailViewController *facebookDetailVC;

@end

@implementation OttaLoginContainerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.transitionInProgress = NO;
    self.currentSegueIdentifier = @"JoinDetailSegue";
    self.currentPageShowing = PageShowing_None;
    [self performSegueWithIdentifier:self.currentSegueIdentifier sender:nil];
}

-(void) openLoginViewDetail
{
    self.currentSegueIdentifier = @"LoginDetailSegue";
    [self performSegueWithIdentifier:self.currentSegueIdentifier sender:nil];
}

-(void) openJoinViewDetail
{
    self.currentSegueIdentifier = @"JoinDetailSegue";
    [self performSegueWithIdentifier:self.currentSegueIdentifier sender:nil];
}

-(void) openFacebookViewDetail
{
    self.currentSegueIdentifier = @"FacebookDetailSegue";
    [self performSegueWithIdentifier:self.currentSegueIdentifier sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"JoinDetailSegue"])
    {
        if(self.joinDetailVC == nil) {
            self.joinDetailVC = segue.destinationViewController;
            [self addChildViewController:segue.destinationViewController];
            [self.view addSubview:((UIViewController *)segue.destinationViewController).view];
            [segue.destinationViewController didMoveToParentViewController:self];
            _currentPageShowing = PageShowing_JoinPage;
        } else {
            if(_currentPageShowing != PageShowing_JoinPage) {
                [self swapFromViewController:[self.childViewControllers objectAtIndex:0] toViewController:self.joinDetailVC];
            }
            _currentPageShowing = PageShowing_JoinPage;
        }
    }
    else if ([segue.identifier isEqualToString:@"LoginDetailSegue"])
    {
        self.loginDetailVC = segue.destinationViewController;
        if(_currentPageShowing != PageShowing_LoginPage) {
            [self swapFromViewController:[self.childViewControllers objectAtIndex:0] toViewController:self.loginDetailVC];
        }
        _currentPageShowing = PageShowing_LoginPage;
    }
    else if ([segue.identifier isEqualToString:@"FacebookDetailSegue"])
    {
        self.facebookDetailVC = segue.destinationViewController;
        if(_currentPageShowing != PageShowing_FacebookPage) {
            [self swapFromViewController:[self.childViewControllers objectAtIndex:0] toViewController:self.facebookDetailVC];
        }
        _currentPageShowing = PageShowing_FacebookPage;
    }
}


- (void)swapFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    toViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [fromViewController willMoveToParentViewController:nil];
    [self addChildViewController:toViewController];
    
    
    [self transitionFromViewController:fromViewController toViewController:toViewController duration:0.2 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        [fromViewController removeFromParentViewController];
        [toViewController didMoveToParentViewController:self];
        self.transitionInProgress = NO;
    }];
}

@end
