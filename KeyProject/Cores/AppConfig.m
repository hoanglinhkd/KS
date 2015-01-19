//
//  AppConfig.m
//  Motel
//
//  Created by Linh.Nguyen on 8/17/14.
//  Copyright (c) 2014 Linh Nguyen. All rights reserved.
//

#import "AppConfig.h"

@implementation AppConfig
@synthesize isNeedBackAnimation;
@synthesize username, password;

+ (AppConfig *)sharedInstance
{
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static id _sharedObject = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    
    // returns the same object each time
    return _sharedObject;
}

- (id)init{
    self = [super init];
    if (self) {
        [self configDefault];
    }
    return self;
}

- (void)configDefault{
    isNeedBackAnimation = NO;
}
@end
