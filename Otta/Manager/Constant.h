//
//  Constant.h
//  Otta
//
//  Created by Gambogo on 11/15/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FacebookPermissions @[@"publish_actions", @"user_friends", @"public_profile", @"user_about_me", @"user_relationships", @"user_birthday", @"user_location"]

#define cusGreencolor [UIColor colorWithRed:0.486275 green:0.741176 blue:0.192157 alpha:1]



typedef enum {
    TimeSelection_Minutes = 0,
    TimeSelection_Hours,
    TimeSelection_Days,
    TimeSelection_Weeks,
    TimeSelection_Months,
} TimeSelection;

@interface Constant : NSObject

@end
