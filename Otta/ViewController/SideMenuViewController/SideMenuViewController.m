//
//  SideMenuViewController.m
//  Otta
//
//  Created by Steven Ojo on 7/27/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "SideMenuViewController.h"
#import <Parse/Parse.h>
#import "MBProgressHUD.h"
#import "UIViewController+ECSlidingViewController.h"
#import "MEDynamicTransition.h"
#import "METransitions.h"
#import "OttaAppDelegate.h"

@interface SideMenuViewController ()
{
    OttaMenuCell *lastCellSelected;
    NSInteger selectedSideIndex;
}
@property (nonatomic, strong) METransitions *transitions;
@property (nonatomic, strong) UIPanGestureRecognizer *dynamicTransitionPanGesture;
@end

static SideMenuViewController *shareInstance;
@implementation SideMenuViewController

+ (SideMenuViewController*)sharedInstance{
    return shareInstance;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // For share instance
    shareInstance = self;
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"OttaSideMenuBackground.png"]];
    self.menuTableView.backgroundColor = [UIColor clearColor];
    
    selectedSideIndex = 0;
    
    [self setTransition];
}

-(void)highlightAboutButton
{
    if (lastCellSelected) {
        [lastCellSelected.lblText setFont:[UIFont fontWithName:@"OpenSans-Light" size:18.00f]];
    }
    [_btnAbout.titleLabel setFont:[UIFont fontWithName:@"OpenSans-Bold" size:18.00f]];
    
    selectedSideIndex = -1;
    [_menuTableView reloadData];
}

-(void) dehighlightAboutButton
{
    [_btnAbout.titleLabel setFont:[UIFont fontWithName:@"OpenSans-Light" size:18.00f]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)btnAboutTapped:(id)sender
{
    [self highlightAboutButton];
    [self logOutAction];
}

-(void)logOutAction {
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [PFUser logOut];
    [self performSegueWithIdentifier:@"segueLogin" sender:self];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (IBAction)unwindToSideMenu:(UIStoryboardSegue *)unwindSegue
{
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 62.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"OttaMenuCellID";
    
    
    OttaMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:
                          cellIdentifier];
    
    if (cell == nil) {
        cell = [[OttaMenuCell alloc]initWithStyle:
                UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if(selectedSideIndex == indexPath.row) {
        [cell.lblText setFont:[UIFont fontWithName:@"OpenSans-Bold" size:18.00f]];
    } else {
        [cell.lblText setFont:[UIFont fontWithName:@"OpenSans-Light" size:18.00f]];
    }
    
    switch (indexPath.row) {
        case 0:
        {
            cell.imgIcon.image = [UIImage imageNamed:@"menu_question.png"];
            cell.lblText.text = [@"Ask a question" toCurrentLanguage];
        }
            break;
        case 1:
        {
            cell.imgIcon.image = [UIImage imageNamed:@"menu_home.png"];
            cell.lblText.text = [@"Question feed" toCurrentLanguage];
        }
            break;
        case 2:
        {
            cell.imgIcon.image = [UIImage imageNamed:@"menu_mail.png"];
            cell.lblText.text = [@"My questions" toCurrentLanguage];
        }
            break;
        case 3:
        {
            cell.imgIcon.image = [UIImage imageNamed:@"menu_heart.png"];
            cell.lblText.text = [@"Friends" toCurrentLanguage];
        }
            break;
        case 4:
        {
            cell.imgIcon.image = [UIImage imageNamed:@"menu_weel.png"];
            cell.lblText.text = [@"Settings" toCurrentLanguage];
        }
            break;
        case 5:
        {
            cell.imgIcon.image = [UIImage imageNamed:@"menu_otta.png"];
            cell.lblText.text = [@"About" toCurrentLanguage];
        }
            break;
            
        default:
            break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    OttaAppDelegate *appDelegate = (OttaAppDelegate*)[UIApplication sharedApplication].delegate;
    UIView *windowView = appDelegate.window;
    [MBProgressHUD showHUDAddedTo:windowView animated:YES];
    
    //Fix pending too long when press on side bar
    //showing loading indicator while loading data
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if (indexPath.row == selectedSideIndex) {
            [self.slidingViewController resetTopViewAnimated:YES];
            return;
        }
        
        [self dehighlightAboutButton];
        selectedSideIndex = indexPath.row;
        [tableView reloadData];
        switch (indexPath.row) {
            case 0:
                [self performSegueWithIdentifier:@"segueAskQuestion" sender:nil];
                break;
            case 1:
                [self performSegueWithIdentifier:@"segueQuestionFeed" sender:nil];
                break;
            case 2:
                [self performSegueWithIdentifier:@"segueMyQuestion" sender:nil];
                break;
            case 3:
                [self performSegueWithIdentifier:@"segueFriends" sender:nil];
                break;
            case 4:
                [self performSegueWithIdentifier:@"segueSetting" sender:nil];
                break;
            case 5:
                [self performSegueWithIdentifier:@"segueAbout" sender:nil];
                break;
                
            default:
                [self performSegueWithIdentifier:@"segueAskQuestion" sender:nil];
                break;
        }
        [MBProgressHUD hideAllHUDsForView:windowView animated:YES];
        
    });
    
}

#pragma mark - Properties

- (METransitions *)transitions {
    if (_transitions) return _transitions;
    
    _transitions = [[METransitions alloc] init];
    
    return _transitions;
}

- (UIPanGestureRecognizer *)dynamicTransitionPanGesture {
    if (_dynamicTransitionPanGesture) return _dynamicTransitionPanGesture;
    
    _dynamicTransitionPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.transitions.dynamicTransition action:@selector(handlePanGesture:)];
    
    return _dynamicTransitionPanGesture;
}

- (void)setTransition {
    self.transitions.dynamicTransition.slidingViewController = self.slidingViewController;
    
//    METransitionNameDefault;  0
//    ETransitionNameFold;      1
//    METransitionNameZoom;     2
//    METransitionNameDynamic;  3
    
    NSDictionary *transitionData = self.transitions.all[3];
    id<ECSlidingViewControllerDelegate> transition = transitionData[@"transition"];
    if (transition == (id)[NSNull null]) {
        self.slidingViewController.delegate = nil;
    } else {
        self.slidingViewController.delegate = transition;
    }
    
    NSString *transitionName = transitionData[@"name"];
    if ([transitionName isEqualToString:METransitionNameDynamic]) {
        self.slidingViewController.topViewAnchoredGesture = ECSlidingViewControllerAnchoredGestureTapping | ECSlidingViewControllerAnchoredGestureCustom;
        self.slidingViewController.customAnchoredGestures = @[self.dynamicTransitionPanGesture];
        [self.navigationController.view removeGestureRecognizer:self.slidingViewController.panGesture];
        [self.navigationController.view addGestureRecognizer:self.dynamicTransitionPanGesture];
    } else {
        self.slidingViewController.topViewAnchoredGesture = ECSlidingViewControllerAnchoredGestureTapping | ECSlidingViewControllerAnchoredGesturePanning;
        self.slidingViewController.customAnchoredGestures = @[];
        [self.navigationController.view removeGestureRecognizer:self.dynamicTransitionPanGesture];
        [self.navigationController.view addGestureRecognizer:self.slidingViewController.panGesture];
    }
}
- (void)selectRowAtIndex:(NSIndexPath*)indexPath forViewController:(UIViewController*)vc{
    if (indexPath.row == selectedSideIndex) {
        [self.slidingViewController resetTopViewAnimated:YES];
        return;
    }
    
    [self dehighlightAboutButton];
    selectedSideIndex = indexPath.row;
    [self.menuTableView reloadData];
    /*
    switch (indexPath.row) {
        case 0:
            [vc performSegueWithIdentifier:@"segueAskQuestion" sender:nil];
            break;
        case 1:
            [vc performSegueWithIdentifier:@"segueQuestionFeed" sender:nil];
            break;
        case 2:
            [vc performSegueWithIdentifier:@"segueMyQuestion" sender:nil];
            break;
        case 3:
            [vc performSegueWithIdentifier:@"segueFriends" sender:nil];
            break;
        case 4:
            [vc performSegueWithIdentifier:@"segueSetting" sender:nil];
            break;
        case 5:
            [vc performSegueWithIdentifier:@"segueAbout" sender:nil];
            break;
            
        default:
            [self performSegueWithIdentifier:@"segueAskQuestion" sender:nil];
            break;
    }
     */
}
@end
