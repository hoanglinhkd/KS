//
//  OttaParseClientManager.m
//  Otta
//
//  Created by Gambogo on 11/11/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaParseClientManager.h"
#import "Constant.h"

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

@end
