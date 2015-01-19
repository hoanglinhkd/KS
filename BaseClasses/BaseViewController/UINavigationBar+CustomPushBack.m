//
//  UINavigationBar+CustomPushBack.m
//  Motel
//
//  Created by Linh.Nguyen on 8/23/14.
//  Copyright (c) 2014 Linh Nguyen. All rights reserved.
//

#import "UINavigationBar+CustomPushBack.h"
#import "AppDelegate.h"
#import "AppConfig.h"

@implementation UINavigationBar (CustomPushBack)

- (UINavigationItem *)popNavigationItemAnimated:(BOOL)animated;
{
    BOOL animation = [AppConfig sharedInstance].isNeedBackAnimation;
    
    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    [delegate.navController popViewControllerAnimated:animation];
    
    return nil;
}

@end
