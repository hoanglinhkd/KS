//
//  OttaLoadingManager.m
//  Otta
//
//  Created by Gambogo on 12/25/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaLoadingManager.h"

@implementation OttaLoadingManager

+ (id)sharedManager {
    static OttaLoadingManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeGradient];
        [SVProgressHUD setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6f]];
        [SVProgressHUD setForegroundColor:[UIColor orangeColor]];
        [SVProgressHUD setRingThickness:4.0f];
    }
    return self;
}

-(void)show
{
    [SVProgressHUD show];
}

-(void)hide
{
    [SVProgressHUD dismiss];
}
@end
