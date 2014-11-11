//
//  OttaSessionManager.h
//  Otta
//
//  Created by Steven Ojo on 7/27/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "OttaUser.h"

@interface OttaSessionManager : NSObject

typedef void(^OttaLoginResultBlock)(BOOL loginSucceeded, OttaUser *ottaUser, NSString * failureReason);

+(id)sharedManager;
-(void)loginWithFacebook;

@end
