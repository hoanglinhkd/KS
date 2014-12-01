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

typedef void(^OttaUsersBlock)(NSArray *users, NSError* error);

typedef void(^OttaGeneralResultBlock)(BOOL isSucceeded, NSError* error);

typedef void(^OttaArrayDataBlock)(NSArray *array, NSError* error);




+ (id)sharedManager;

- (void)loginWithNameOrEmail:(NSString*)email andPassword:(NSString *)password withResult:(OttaPLoginResultBlock)resultblock ;

- (void)joinWithEmail:(NSString*)email firstName:(NSString*)firstName phone:(NSString*)phone lastName:(NSString*)lastName  password:(NSString *)password withResult:(OttaJoinResultBlock)resultblock;

- (void)resetPasswordWithEmail:(NSString*)email withResult:(OttaResetPassResultBlock)resultblock;

- (void)findUsers:(NSString*) str withResult:(OttaUsersBlock) resultblock;


/**
 *  start follow from user1 to user2
 *
 *  @param user1
 *  @param user2
 *  @param resultBlock
 */
- (void)followUser:(PFUser*)user1 toUser:(PFUser*)user2 withBlock:(OttaGeneralResultBlock)resultBlock;

/**
 *  remove follow from user1 to user2
 *
 *  @param user1
 *  @param user2
 *  @param resultBlock
 */
- (void)removeFollowFromUser:(PFUser*)user1 toUser:(PFUser*)user2 withBlock:(OttaGeneralResultBlock)resultBlock;

/**
 *  block follow from user1 to user2
 *
 *  @param user1
 *  @param user2
 *  @param resultBlock
 */
- (void)blockFollowFromUser:(PFUser*)user1 toUser:(PFUser*)user2 withBlock:(OttaGeneralResultBlock)resultBlock;

/**
 *  Get All follower of user
 *
 *  @param user
 *  @param resultBlock
 */
- (void)getAllFollowToUser:(PFUser*)user withBlock:(OttaArrayDataBlock)resultBlock;

/**
 *  Get All followed by user
 *
 *  @param user
 *  @param resultBlock
 */
- (void)getAllFollowFromUser:(PFUser*)user withBlock:(OttaArrayDataBlock)resultBlock;

@end
