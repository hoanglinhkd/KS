//
//  OttaParseClientManager.m
//  Otta
//
//  Created by Gambogo on 11/11/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaParseClientManager.h"
#import "Constant.h"
#import "OttaQuestion.h"
#import "OttaAnswer.h"

#define kFirstName  @"firstName"
#define kLastName   @"lastName"
#define kPhone      @"phone"

@implementation OttaParseClientManager

+ (id)sharedManager {
    static OttaParseClientManager *sharedMyManager = nil;
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

- (void)loginWithNameOrEmail:(NSString*)nameOrEmail andPassword:(NSString *)password withResult:(OttaPLoginResultBlock)resultblock {

    [PFUser logInWithUsernameInBackground:nameOrEmail password:password
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            // Do stuff after successful login.
                                            resultblock(YES, user, error);
                                        } else {
                                            // The login failed. Check error to see why.
                                            resultblock(NO, user, error);
                                        }
                                    }];
}



- (void)joinWithEmail:(NSString*)email firstName:(NSString*)firstName phone:(NSString*)phone lastName:(NSString*)lastName  password:(NSString *)password withResult:(OttaJoinResultBlock)resultblock
{
    PFUser *pUser = [PFUser user];
    pUser.username = email;
    pUser.email = email;
    pUser.password = password;
    [pUser setObject:firstName forKey:kFirstName];
    [pUser setObject:lastName forKey:kLastName];
    [pUser setObject:phone forKey:kPhone];
    
    //Sign up
    [pUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        if (!error) {
            resultblock(YES, pUser, error);
        } else {
            resultblock(NO, pUser, error);
        }
    }];
}

- (void)resetPasswordWithEmail:(NSString*)email withResult:(OttaResetPassResultBlock)resultblock {
    [PFUser requestPasswordResetForEmailInBackground:email block:^(BOOL succeeded, NSError *error) {
        resultblock(succeeded, error);
    }];
}


- (void)findUserWithEmail:(NSString*)email withResult: (void (^)(PFUser *)) UserResultBlock{
    NSLog(@"findUserWithEmail");
  
    PFQuery *userQuery = [PFUser query];
    
    [userQuery whereKey:@"email" equalTo:email];
    
    [userQuery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (object) {
            PFUser *user = (PFUser *)object;
            UserResultBlock(user);
        } else {
            UserResultBlock(nil);
        }
    }];
}

- (void)findUsers:(NSString*) str withResult:(OttaUsersBlock) resultblock;{
    NSLog(@"findUsers");
    PFQuery *userFNQuery = [PFUser query];
    PFQuery *userLNQuery = [PFUser query];
    PFQuery *userFNCapitalQuery = [PFUser query];
    PFQuery *userLNCapitalQuery = [PFUser query];
    if ([str containsString:@" "]){
        NSArray *arrSearch = [str componentsSeparatedByString:@" "];
        NSString *fn = [arrSearch objectAtIndex:0];
        NSString *ln = [arrSearch objectAtIndex:1];
        [userFNQuery whereKey:kFirstName containsString:fn];
        [userLNQuery whereKey:kLastName containsString:ln];
        [userFNCapitalQuery whereKey:kFirstName containsString:[fn capitalizedString]];
        [userLNCapitalQuery whereKey:kLastName containsString:[ln capitalizedString]];
    }
    else {
        
        [userFNQuery whereKey:kFirstName containsString:str];
        [userLNQuery whereKey:kLastName containsString:str];
        [userFNCapitalQuery whereKey:kFirstName containsString:[str capitalizedString]];
        [userLNCapitalQuery whereKey:kLastName containsString:[str capitalizedString]];
        
    }
    PFQuery *query = [PFQuery orQueryWithSubqueries:@[userFNQuery,userLNQuery,userFNCapitalQuery,userLNCapitalQuery]];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        resultblock(objects, error);
    }];
}


- (void)followUser:(PFUser*)user1 toUser:(PFUser*)user2 withBlock:(OttaGeneralResultBlock)resultBlock {
    // create an entry in the Follow table
    PFObject *follow = [PFObject objectWithClassName:@"OttaFollow"];
    [follow setObject:user1 forKey:@"from"];
    [follow setObject:user2 forKey:@"to"];
    [follow setValue:@NO forKey:@"isBlocked"];
    [follow saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        resultBlock(succeeded, error);
    }];
}

- (void)removeFollowFromUser:(PFUser*)user1 toUser:(PFUser*)user2 withBlock:(OttaGeneralResultBlock)resultBlock {
    PFQuery *query = [PFQuery queryWithClassName:@"OttaFollow"];
    [query whereKey:@"from" equalTo:user1];
    [query whereKey:@"to" equalTo:user2];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        PFObject *follow = (PFObject*)objects[0];
        BOOL isSucceed = [follow delete];
        resultBlock(isSucceed, error);
    }];
}

- (void)blockFollowFromUser:(PFUser*)user1 toUser:(PFUser*)user2 withBlock:(OttaGeneralResultBlock)resultBlock {
    PFQuery *query = [PFQuery queryWithClassName:@"OttaFollow"];
    [query whereKey:@"from" equalTo:user1];
    [query whereKey:@"to" equalTo:user2];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        PFObject *follow = (PFObject*)objects[0];
        [follow setValue:@YES forKey:@"isBlocked"];
        BOOL isSucceed = [follow save];
        resultBlock(isSucceed, error);
    }];
}

- (void)getAllFollowToUser:(PFUser*)user withBlock:(OttaArrayDataBlock)resultBlock {
    // set up the query on the Follow table
    PFQuery *query = [PFQuery queryWithClassName:@"OttaFollow"];
    [query whereKey:@"to" equalTo:user];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            // o is an entry in the Follow table
            // to get the user, we get the object with the from key
            //PFUser *otherUser = [o objectForKey@"from"];
        
        resultBlock(objects, error);
    }];
}

- (void)getAllUsersFollowToUser:(PFUser*)user withBlock:(OttaArrayDataBlock)resultBlock {
    NSMutableArray *userIDs = [[NSMutableArray alloc] init];
    // set up the query on the Follow table
    [self getAllFollowToUser:user withBlock:^(NSArray *array, NSError *error) {
        for (PFUser *objUser in array) {
            PFUser *cur = [objUser objectForKey:@"from"];
            [userIDs addObject:cur.objectId];
        }
        PFQuery *query = [PFUser query];
        [query whereKey:@"objectId" containedIn:userIDs];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            resultBlock(objects, error);
        }];
    }];
}

- (void)getAllFollowFromUser:(PFUser*)user withBlock:(OttaArrayDataBlock)resultBlock {
    // set up the query on the Follow table
    PFQuery *query = [PFQuery queryWithClassName:@"OttaFollow"];
    [query whereKey:@"from" equalTo:user];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        // o is an entry in the Follow table
        // to get the user, we get the object with the from key
        //PFUser *otherUser = [o objectForKey@"to"];
        
        resultBlock(objects, error);
    }];
}

- (void)getAllUsersFollowFromUser:(PFUser*)user withBlock:(OttaArrayDataBlock)resultBlock {
    NSMutableArray *userIDs = [[NSMutableArray alloc] init];
    // set up the query on the Follow table
    [self getAllFollowFromUser:user withBlock:^(NSArray *array, NSError *error) {
        for (PFUser *objUser in array) {
            PFUser *cur = [objUser objectForKey:@"to"];
            [userIDs addObject:cur.objectId];
        }
        PFQuery *query = [PFUser query];
        [query whereKey:@"objectId" containedIn:userIDs];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            resultBlock(objects, error);
        }];
    }];
}

- (void)countUsersFollowToUser:(PFUser*)user withBlock:(OttaCountBlock)resultBlock{
    PFQuery *query = [PFQuery queryWithClassName:@"OttaFollow"];
    [query whereKey:@"to" equalTo:user];
    [query countObjectsInBackgroundWithBlock:^(int count, NSError *error) {
        resultBlock(count, error);
    }];
}

- (void)countUsersFollowFromUser:(PFUser*)user withBlock:(OttaCountBlock)resultBlock{
    PFQuery *query = [PFQuery queryWithClassName:@"OttaFollow"];
    [query whereKey:@"from" equalTo:user];
    [query countObjectsInBackgroundWithBlock:^(int count, NSError *error) {
        resultBlock(count, error);
    }];
}

- (void)addQuestion:(OttaQuestion*)ottaQuestion withBlock:(OttaGeneralResultBlock)resultBlock {
    
    NSMutableArray* optionArray = [NSMutableArray new];
    
    for (OttaAnswer *answer in ottaQuestion.ottaAnswers) {
        PFObject *option = [PFObject objectWithClassName:@"OttaAnswer"];
        [option setObject:answer.answerImage forKey:@"image"];
        [option setObject:answer.answerText forKey:@"description"];
        [optionArray addObject:option];
    }
    
    PFObject *question = [PFObject objectWithClassName:@"OttaQuestion"];
    
    // store the weapons for the user
    
    [question setObject:[PFUser currentUser] forKey:@"asker"];
    [question setObject:ottaQuestion.expTime forKey:@"expTime"];
    [question setObject:ottaQuestion.questionText forKey:@"questionText"];
    [question setObject:optionArray forKey:@"answers"];
    
    [question setValue:@(ottaQuestion.isPublic) forKey:@"isPublic"];
}

@end
