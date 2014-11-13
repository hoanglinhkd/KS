//
//  OttaParseClientManager.h
//  Otta
//
//  Created by Gambogo on 11/11/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "OttaUser.h"

@interface OttaParseClientManager : NSObject

typedef void(^OttaPLoginResultBlock)(BOOL loginSucceeded, PFUser *ottaUser, NSString * failureReason);

typedef void(^OttaJoinResultBlock)(BOOL joinSucceeded, PFUser *ottaUser, NSString * failureReason);

+ (id)sharedManager;

- (void)loginWithEmail:(NSString*)email andPassword:(NSString *)password withResult:(OttaPLoginResultBlock)resultblock ;

- (void) joinWithEmail:(NSString*)email andUsername:(NSString *)userName andPassword:(NSString *)password withResult:(OttaJoinResultBlock)resultblock;

@end
