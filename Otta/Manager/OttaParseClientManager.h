//
//  OttaParseClientManager.h
//  Otta
//
//  Created by Gambogo on 11/11/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "OttaQuestion.h"


#define kObjectId       @"objectId"
#define kCreatedAt      @"createdAt"

#define kFirstName      @"firstName"
#define kLastName       @"lastName"
#define kPhone          @"phone"
#define kEmail          @"email"


// OttaFollow table
#define kOttaFollow     @"OttaFollow"
#define kFrom           @"from"
#define kTo             @"to"
#define kIsBlocked      @"isBlocked"


// OttaAnswer table
#define kOttaAnswer     @"OttaAnswer"
#define kImage          @"image"
#define kDescription    @"description"


// OttaQuestion table
#define kOttaQuestion   @"OttaQuestion"
#define kAsker          @"asker"
#define kExpTime        @"expTime"
#define kQuestionText   @"questionText"
#define kAnswers        @"answers"
#define kIsPublic       @"isPublic"
#define kResponders     @"responders"
#define kAnswerers      @"answerers"

// Vote table
#define kOttaVote       @"OttaVote"
#define kVoteComment    @"voteComment"
#define kResponder      @"responder"
#define kAnswer         @"answer"

@interface OttaParseClientManager : NSObject

typedef void(^OttaPLoginResultBlock)(BOOL loginSucceeded, PFUser* ottaUser, NSError* error);

typedef void(^OttaJoinResultBlock)(BOOL joinSucceeded, PFUser* ottaUser, NSError* error);

typedef void(^OttaResetPassResultBlock)(BOOL isSucceeded, NSError* error);

typedef void(^OttaUsersBlock)(NSArray *users, NSError* error);

typedef void(^OttaGeneralResultBlock)(BOOL isSucceeded, NSError* error);

typedef void(^OttaArrayDataBlock)(NSArray *array, NSError* error);

typedef void(^OttaCountBlock)(int count, NSError* error);




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
 *  Remove follow
 *
 *  @param follow
 *  @param resultBlock
 */
- (void)removeFollow:(PFObject*)follow withBlock:(OttaGeneralResultBlock)resultBlock;

/**
 *  Block/UnBlock an follow
 *
 *  @param follow
 *  @param isBlock
 *  @param resultBlock
 */
- (void)setBlockFollow:(PFObject*)follow withValue:(BOOL)isBlock withBlock:(OttaGeneralResultBlock)resultBlock;

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

/**
 *  count follower by user
 *
 *  @param user
 *  @param resultBlock
 */
- (void)countUsersFollowToUser:(PFUser*)user withBlock:(OttaCountBlock)resultBlock;

/**
 *  count followed by user
 *
 *  @param user
 *  @param resultBlock
 */
- (void)countUsersFollowFromUser:(PFUser*)user withBlock:(OttaCountBlock)resultBlock;



/**
 *  Add new Questions
 *
 *  @param ottaQuestion
 *  @param resultBlock
 */
- (void)addQuestion:(OttaQuestion*)ottaQuestion withBlock:(OttaGeneralResultBlock)resultBlock;

/**
 *  Get My Question
 *
 *  @param user        pass current User
 *  @param resultBlock
 */
- (void)getMyQuestionFromUser:(PFUser*)user withBlock:(OttaArrayDataBlock)resultBlock;

/**
 *  <#Description#>
 *
 *  @param user        <#user description#>
 *  @param resultBlock <#resultBlock description#>
 */
- (void)getQuestionFeedFromUser:(PFUser*)user withBlock:(OttaArrayDataBlock)resultBlock;
/**
 *  Vote an Answer
 *
 *  @param user        <#user description#>
 *  @param answer      <#answer description#>
 *  @param resultBlock <#resultBlock description#>
 */
- (void)voteFromUser:(PFUser*)user withQuestion:(PFObject*)question withAnswer:(PFObject*)answer withBlock:(OttaGeneralResultBlock)resultBlock;
@end
