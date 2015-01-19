//
//  FirstLeverViewController.h
//  Motel
//
//  Created by Linh.Nguyen on 8/16/14.
//  Copyright (c) 2014 Linh Nguyen. All rights reserved.
//

#import "BaseViewController.h"

@protocol FirstLeverViewControllerDelegate <NSObject>

- (void)firstLeverVCNeedShowMenu;
- (void)firstLeverVCNeedHideMenu;

@end

@interface FirstLeverViewController : BaseViewController

@property (nonatomic, assign)id<FirstLeverViewControllerDelegate>delegate;

@end
