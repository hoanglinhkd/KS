//
//  MTMasterNavigationController.m
//  Motel
//
//  Created by Linh.Nguyen on 8/16/14.
//  Copyright (c) 2014 Linh Nguyen. All rights reserved.
//

#import "MTMasterNavigationController.h"

@interface MTMasterNavigationController (){
    
}

@end

@implementation MTMasterNavigationController
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
    [self setupUI];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupUI{
    self.view.layer.shadowColor = [[UIColor blackColor] CGColor];
    self.view.layer.shadowOpacity = 0.5;
    self.view.layer.shadowRadius = 5;
    self.view.layer.shadowOffset = CGSizeMake(-2, 0);
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [super pushViewController:viewController animated:animated];
    //[self pushViewController:viewController animated:animated];
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
