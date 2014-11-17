//
//  OttaUserManager.m
//  Otta
//
//  Created by ThienHuyen on 11/16/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaUserManager.h"


#define keyCurrentUser  @"keyCurrentUser"

@interface OttaUserManager()

@property (strong, nonatomic) PFUser* currentUser;

@end

@implementation OttaUserManager

+ (id)sharedManager {
    static OttaUserManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [[self alloc] init];
    });
    return sharedMyManager;
}

- (id)init {
    if (self = [super init]) {
        // init here
    }
    return self;
}

- (void)saveCurrentUser:(PFUser*)user {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:user forKey:keyCurrentUser];
    [prefs synchronize];
}

- (void)removeCurrentUser:(PFUser*)user {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:nil forKey:keyCurrentUser];
    [prefs synchronize];
}

- (BOOL)isLoggedin {
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if([prefs objectForKey:keyCurrentUser] != nil) {
        return YES;
    }
    return NO;
}

- (PFUser*)getCurrentUser {
    if (_currentUser == nil) {
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        _currentUser = [prefs objectForKey:keyCurrentUser];
    }
    return _currentUser;
}

@end
