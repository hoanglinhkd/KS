//
//  FirstLeverViewController.m
//  Motel
//
//  Created by Linh.Nguyen on 8/16/14.
//  Copyright (c) 2014 Linh Nguyen. All rights reserved.
//

#import "FirstLeverViewController.h"
#import "Const.h"

@interface FirstLeverViewController (){
    UIImageView *imgViewAction;
    NSArray *arrImg;
    NSMutableArray *revertArrImg;
    BOOL isExpand;
    UITapGestureRecognizer *tapGesture;
}

@end

@implementation FirstLeverViewController
@synthesize delegate;

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
    [self setupMenuButton];
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notifDidSwipeLeft) name:MT_DIDSWIPELEFT object:nil];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:MT_DIDSWIPELEFT];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setupMenuButton{
    // init state for image
    imgViewAction = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    imgViewAction.image = [UIImage imageNamed:@"menu_state1"];
    // image view menu icon
    arrImg = [NSArray arrayWithObjects:   [UIImage imageNamed:@"menu_state1"],
              [UIImage imageNamed:@"menu_state2"],
              [UIImage imageNamed:@"menu_state3"],
              [UIImage imageNamed:@"menu_state4"],
              [UIImage imageNamed:@"menu_state5"],
              [UIImage imageNamed:@"menu_state6"],
              [UIImage imageNamed:@"menu_state7"],
              [UIImage imageNamed:@"menu_state8"],
              [UIImage imageNamed:@"menu_state9"],
              [UIImage imageNamed:@"menu_state10"],
              [UIImage imageNamed:@"menu_state11"],
              [UIImage imageNamed:@"menu_state12"],
              [UIImage imageNamed:@"menu_state13"],
              [UIImage imageNamed:@"menu_state14"],
              [UIImage imageNamed:@"menu_state15"],
              [UIImage imageNamed:@"menu_state16"],
              [UIImage imageNamed:@"menu_state17"],
              [UIImage imageNamed:@"menu_state19"],
              [UIImage imageNamed:@"menu_state18"],
              [UIImage imageNamed:@"menu_state19"],
              [UIImage imageNamed:@"menu_state19"],
              nil];
    revertArrImg = [[NSMutableArray alloc] init];
    for (NSInteger i = arrImg.count-1; i>=0; i--) {
        [revertArrImg addObject:arrImg[i]];
    }
    
    imgViewAction.animationImages = arrImg;
    imgViewAction.animationDuration = 0.5;
    imgViewAction.contentMode = UIViewContentModeScaleAspectFill;
    imgViewAction.animationRepeatCount = 1;
    
    UIBarButtonItem *barBtn = [[UIBarButtonItem alloc] initWithCustomView:imgViewAction];
    self.navigationItem.leftBarButtonItem = barBtn;
    
    
    // Add Gesture for animation
    tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [imgViewAction addGestureRecognizer:tapGesture];
}

- (void)tapGesture:(UITapGestureRecognizer*)tap{
    if (isExpand) {
        imgViewAction.animationImages = revertArrImg;
        [imgViewAction setImage:[UIImage imageNamed:@"menu_state1"]];
        [imgViewAction startAnimating];
        //[self moveTablecomeBack];
        if (delegate && [delegate respondsToSelector:@selector(firstLeverVCNeedHideMenu)]) {
        
        }
        // Need to hide menu
        [[NSNotificationCenter defaultCenter] postNotificationName:MT_NEEDHIDEMENU object:nil];
        
    }else{
        imgViewAction.animationImages = arrImg;
        [imgViewAction setImage:[UIImage imageNamed:@"menu_state17"]];
        [imgViewAction startAnimating];
        //[self moveTableLeft];
        if (delegate && [delegate respondsToSelector:@selector(firstLeverVCNeedShowMenu)]) {
            
        }
        // Need to show menu
        [[NSNotificationCenter defaultCenter] postNotificationName:MT_NEEDSHOWMENU object:nil];
    }
    isExpand = !isExpand;
}

- (void)notifDidSwipeLeft{
    isExpand = NO;
    imgViewAction.animationImages = revertArrImg;
    [imgViewAction setImage:[UIImage imageNamed:@"menu_state1"]];
    [imgViewAction startAnimating];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
