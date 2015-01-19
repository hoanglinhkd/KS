//
//  MenuViewController.m
//  Motel
//
//  Created by Linh.Nguyen on 8/16/14.
//  Copyright (c) 2014 Linh Nguyen. All rights reserved.
//

#import "MenuViewController.h"
#import "MTMasterNavigationController.h"
#import "INTMacros.h"
#import "HomeViewController.h"
//#import "SavedViewController.h"
#import "Const.h"
//#import "FindAroundViewController.h"
#import "AppDelegate.h"
#import "FirstLeverViewController.h"


#define kLeftWidth 220;

@interface MenuViewController ()<UITableViewDataSource, UITableViewDelegate>{
    NSArray *arrFuncTitle;
    NSArray *arrFuncClass;
    
    NSArray *arrExtraFuncTitle;
    NSArray *arrExtraFuncClass;
    
    MTMasterNavigationController *ncMaster;
    BOOL isExpand;
    
    // Main menu
    //HomeViewController *mainHomeVC;
    //SavedViewController *savePageVC;
    
}

@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        isExpand = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationShowHideMenu:) name:MT_NEEDSHOWMENU object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notificationShowHideMenu:) name:MT_NEEDHIDEMENU object:nil];
    
    
    
    [self initData];
    [self setupTableView];
    [self initMasterView];
    
    //Gesture
    [self addSwipeGesture];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initData{
    arrFuncTitle = [[NSArray alloc] initWithObjects:@"Home", @"Saved Motel", @"Deals", nil];
   
    arrFuncClass = [[NSArray alloc] initWithObjects:
                    [HomeViewController class],
                    [HomeViewController class],
                    [HomeViewController class], nil];
}
- (void)setupTableView{
    
}
#pragma mark - UITableView Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return arrFuncTitle.count;
    }else if (section==1){
        return arrExtraFuncTitle.count;
    }
    return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = [arrFuncTitle objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - For MasterView
- (void)initMasterView{
    ncMaster = [[MTMasterNavigationController alloc] init];
    ncMaster.view.frame = RECT_WITH_X(self.view.bounds, 0);
    ncMaster.view.backgroundColor = [UIColor blackColor];
    [self.view addSubview:ncMaster.view];
    [self addChildViewController:ncMaster];
    
    BaseViewController *rootView = [[BaseViewController alloc] init];
    rootView.view.frame = self.view.bounds;
    [ncMaster pushViewController:rootView animated:NO];
    
    HomeViewController *homeVC = [[HomeViewController alloc] initWithNibName:NSStringFromClass([HomeViewController class]) bundle:nil];
    homeVC.title = @"Home";
    [ncMaster pushViewController:homeVC animated:NO];
    
    // save nc master to app delegate
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    delegate.navController = ncMaster;
}

#pragma mark - UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Class arrayClass = NSClassFromString (name);
    //id anInstance = [[arrayClass alloc] init];
    
    if (arrFuncClass.count <= indexPath.row)
        return;
    Class cls = [arrFuncClass objectAtIndex:indexPath.row];
    if (!cls)
        return;
    id instance = nil;
    @try {
        // Try to create from nib first
        instance = [[cls alloc] initWithNibName:NSStringFromClass(cls) bundle:nil];
    }
    @catch (NSException *exception) {
        //DLog(@"%@", exception);
        // Try to create normally
        instance = [[cls alloc] init];
    }
    @finally {
        
    }
    UIViewController *vc = (UIViewController *)instance;
    if (!vc)
        return;
    
    vc.title = [arrFuncTitle objectAtIndex:indexPath.row];
    [ncMaster popViewControllerAnimated:NO];
    [ncMaster pushViewController:instance animated:NO];
    [self swipeGesture:nil];
}


/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        if (mainHomeVC==nil) {
            mainHomeVC = [[HomeViewController alloc] initWithNibName:NSStringFromClass([HomeViewController class]) bundle:nil];
            [ncMaster popViewControllerAnimated:NO];
            [ncMaster pushViewController:mainHomeVC animated:YES];
        }else{
             [ncMaster popViewControllerAnimated:NO];
            [ncMaster pushViewController:mainHomeVC animated:YES];
        }
    }else if (indexPath.row==1){
        if (savePageVC==nil) {
            savePageVC = [[SavedViewController alloc] initWithNibName:NSStringFromClass([SavedViewController class]) bundle:nil];
            [ncMaster popViewControllerAnimated:NO];
            [ncMaster pushViewController:savePageVC animated:YES];
        }else{
            [ncMaster popViewControllerAnimated:NO];
            [ncMaster pushViewController:savePageVC animated:YES];
        }
    }
    
    [self swipeGesture:nil];
}
*/
#pragma mark - Process For menu
- (void)addSwipeGesture{
    
    UISwipeGestureRecognizer *gesTure = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeGesture:)];
    gesTure.direction = UISwipeGestureRecognizerDirectionLeft;
    [ncMaster.view addGestureRecognizer:gesTure];
}

- (void)swipeGesture:(UISwipeGestureRecognizer*)gesture{
    if (isExpand) {
        [[NSNotificationCenter defaultCenter] postNotificationName:MT_DIDSWIPELEFT object:nil];
        // animation move Navigation Controller to X = 0;
        ncMaster.view.transform = CGAffineTransformIdentity;
        
        [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
            ncMaster.view.frame = self.view.bounds;
            ncMaster.view.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            isExpand = NO;
        }];
    }
}


#pragma mark - Selector
- (void)notificationShowHideMenu:(id)sender{
    if (isExpand) {
        // animation move Navigation Controller to X = 0;
        ncMaster.view.transform = CGAffineTransformIdentity;
        
        [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
            ncMaster.view.frame = self.view.bounds;
            ncMaster.view.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }else{
        ncMaster.view.transform = CGAffineTransformIdentity;
        
        [UIView animateWithDuration:0.3f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
            ncMaster.view.frame = RECT_WITH_X(self.view.bounds, 220);
            ncMaster.view.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            
        }];
    }
    isExpand = !isExpand;
}
@end




























