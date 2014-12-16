//
//  OttaParseClientManager.m
//  Otta
//
//  Created by Gambogo on 11/11/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaParseClientManager.h"
#import "Constant.h"
#import "NSDate-Utilities.h"
#import "OttaAnswer.h"


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
  
    PFQuery *userQuery = [PFUser query];
    
    [userQuery whereKey:kEmail equalTo:email];
    
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
    PFObject *follow = [PFObject objectWithClassName:kOttaFollow];
    [follow setObject:user1 forKey:kFrom];
    [follow setObject:user2 forKey:kTo];
    [follow setValue:@NO forKey:kIsBlocked];
    [follow saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        resultBlock(succeeded, error);
    }];
}

- (void)removeFollow:(PFObject*)follow withBlock:(OttaGeneralResultBlock)resultBlock {
    [follow deleteInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        resultBlock(succeeded, error);
    }];
}

- (void)setBlockFollow:(PFObject*)follow withValue:(BOOL)isBlock withBlock:(OttaGeneralResultBlock)resultBlock {
    
    [follow setValue:@(isBlock) forKey:kIsBlocked];
    
    [follow saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        resultBlock(succeeded, error);
    }];
}

- (void)getAllFollowToUser:(PFUser*)user withBlock:(OttaArrayDataBlock)resultBlock {
    // set up the query on the Follow table
    PFQuery *query = [PFQuery queryWithClassName:kOttaFollow];
    [query whereKey:kTo equalTo:user];
    [query includeKey:kFrom];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            // o is an entry in the Follow table
            // to get the user, we get the object with the from key
            //PFUser *otherUser = [o objectForKey@"from"];
        
        resultBlock(objects, error);
    }];
}

- (void)getAllFollowFromUser:(PFUser*)user withBlock:(OttaArrayDataBlock)resultBlock {
    // set up the query on the Follow table
    PFQuery *query = [PFQuery queryWithClassName:kOttaFollow];
    [query whereKey:kFrom equalTo:user];
    [query includeKey:kTo];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        // o is an entry in the Follow table
        // to get the user, we get the object with the from key
        //PFUser *otherUser = [o objectForKey@"to"];
        
        resultBlock(objects, error);
    }];
}

- (void)countUsersFollowToUser:(PFUser*)user withBlock:(OttaCountBlock)resultBlock{
    PFQuery *query = [PFQuery queryWithClassName:kOttaFollow];
    [query whereKey:kTo equalTo:user];
    [query countObjectsInBackgroundWithBlock:^(int count, NSError *error) {
        resultBlock(count, error);
    }];
}

- (void)countUsersFollowFromUser:(PFUser*)user withBlock:(OttaCountBlock)resultBlock{
    PFQuery *query = [PFQuery queryWithClassName:kOttaFollow];
    [query whereKey:kFrom equalTo:user];
    [query countObjectsInBackgroundWithBlock:^(int count, NSError *error) {
        resultBlock(count, error);
    }];
}

- (void)addQuestion:(OttaQuestion*)ottaQuestion withBlock:(OttaGeneralResultBlock)resultBlock {
    
    NSMutableArray* optionArray = [NSMutableArray new];
    
    for (OttaAnswer *answer in ottaQuestion.ottaAnswers) {
        
        PFObject *option = [PFObject objectWithClassName:kOttaAnswer];
        NSData *imageData = UIImagePNGRepresentation(answer.answerImage);
        if(imageData) {
            PFFile *imageFile = [PFFile fileWithName:[NSString stringWithFormat:@"%f.png",[[NSDate date] timeIntervalSince1970]] data:imageData];
            [option setObject:imageFile forKey:kImage];
        }
        
        [option setObject:(answer.answerText.length <= 0 ? @"" : answer.answerText) forKey:kDescription];
        [optionArray addObject:option];
    }
    
    PFObject *question = [PFObject objectWithClassName:kOttaQuestion];
    
    [question setObject:[PFUser currentUser] forKey:kAsker];
    [question setObject:ottaQuestion.expTime forKey:kExpTime];
    [question setObject:ottaQuestion.questionText forKey:kQuestionText];
    [question setObject:optionArray forKey:kAnswers];
    
    [question setValue:@(ottaQuestion.isPublic) forKey:kIsPublic];
    
    
    PFRelation *relation = [question relationForKey:kResponders];
    for (PFUser *friend in ottaQuestion.responders) {
        [relation addObject:friend];
    }
    
    [question saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        resultBlock(succeeded, error);
    }];
}

- (void)getMyQuestionFromUser:(PFUser*)user withBlock:(OttaArrayDataBlock)resultBlock {
    PFQuery *query = [PFQuery queryWithClassName:kOttaQuestion];
    [query whereKey:kAsker equalTo:user];
    [query includeKey:kAnswers];
    [query orderByDescending:@"createdAt"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        resultBlock(objects, error);
    }];
}

- (void)getQuestionFeedFromUser:(PFUser*)user withBlock:(OttaArrayDataBlock)resultBlock {
    // Get public question first
    PFQuery *followQuery = [PFQuery queryWithClassName:kOttaFollow];
    [followQuery whereKey:kFrom equalTo:user];
    [followQuery findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        
        NSMutableArray* askers = [NSMutableArray new];
        for (PFObject* follow in objects) {
            [askers addObject:follow[kTo]];
        }
        
        PFQuery *query = [PFQuery queryWithClassName:kOttaQuestion];
        [query whereKey:kIsPublic equalTo:@YES];
        [query whereKey:kAsker containedIn:askers];
        [query whereKey:kExpTime greaterThan:[NSDate date]];
        [query includeKey:kAsker];
        [query includeKey:kAnswers];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            resultBlock(objects, error);
        }];
    }];
}

- (void)voteFromUser:(PFUser*)user withAnswer:(PFObject*)answer withBlock:(OttaGeneralResultBlock)resultBlock {
    // create an entry in the OttaVote table
    PFObject *vote = [PFObject objectWithClassName:kOttaVote];
    [vote setObject:user forKey:kResponder];
    [vote setObject:answer forKey:kAnswer];
    [vote setObject:@"" forKey:kVoteComment];
    [vote saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        resultBlock(succeeded, error);
    }];
}

@end
