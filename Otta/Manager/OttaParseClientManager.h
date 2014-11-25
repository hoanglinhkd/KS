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

typedef void(^OttaPLoginResultBlock)(BOOL loginSucceeded, PFUser* ottaUser, NSError* error);

typedef void(^OttaJoinResultBlock)(BOOL joinSucceeded, PFUser* ottaUser, NSError* error);

typedef void(^OttaResetPassResultBlock)(BOOL isSucceeded, NSError* error);

+ (id)sharedManager;

- (void)loginWithNameOrEmail:(NSString*)email andPassword:(NSString *)password withResult:(OttaPLoginResultBlock)resultblock ;

- (void)joinWithEmail:(NSString*)email firstName:(NSString*)firstName phone:(NSString*)phone lastName:(NSString*)lastName  password:(NSString *)password withResult:(OttaJoinResultBlock)resultblock;

- (void)resetPasswordWithEmail:(NSString*)email withResult:(OttaResetPassResultBlock)resultblock;
@end
