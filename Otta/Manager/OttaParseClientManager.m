//
//  OttaParseClientManager.m
//  Otta
//
//  Created by Gambogo on 11/11/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaParseClientManager.h"

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

- (void)loginWithEmail:(NSString*)email andPassword:(NSString *)password withResult:(OttaPLoginResultBlock)resultblock {
    __block BOOL loginSucceeded;
    __block NSString *errorString;

    PFQuery *userQuery = [PFUser query];
    
    [userQuery whereKey:@"email" equalTo:email];
    
    //Query user by email
    [userQuery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
        if (object) {
            PFUser *user = (PFUser *)object;
            
            //Authenticate
            [PFUser logInWithUsernameInBackground:user.username password:password
                                            block:^(PFUser *user, NSError *error) {
                                                if (user) {
                                                    // Do stuff after successful login.
                                                    loginSucceeded = true;
                                                    resultblock(loginSucceeded, user, errorString);
                                                } else {
                                                    // The login failed. Check error to see why.
                                                    loginSucceeded = false;
                                                    errorString = [[error userInfo] objectForKey:@"error"];
                                                    
                                                    resultblock(loginSucceeded, user, errorString);
                                                }
                                            }];
            
        } else {
            loginSucceeded = false;
            errorString = @"Does not exits the email, Please register";
            
            resultblock(loginSucceeded, nil, errorString);
        }
    }];

}



- (void)joinWithEmail:(NSString*)email andUsername:(NSString *)userName andPassword:(NSString *)password withResult:(OttaJoinResultBlock)resultblock
{
    __block BOOL joinSucceeded;
    __block NSString *errorString;
    
    PFQuery *userQuery = [PFUser query];
    
    [userQuery whereKey:@"email" equalTo:email];
    
    //Query user by email
    [userQuery getFirstObjectInBackgroundWithBlock:^(PFObject *object, NSError *error) {
                //if existing user
        if (object) {
            PFUser *user = (PFUser *)object;
            joinSucceeded = FALSE;
            errorString = @"The email has registered!";
            resultblock(joinSucceeded, user, errorString);
            //Create User
        } else {
            PFUser *pUser = [PFUser user];
            pUser[@"userid"] = userName;
            pUser.email = email;
            pUser.username = userName;
            pUser.password = password;
            
            //Sign up
            [pUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
                if (!error) {
                    joinSucceeded = TRUE;
                    
                    resultblock(joinSucceeded, pUser, errorString);
                } else {
                    joinSucceeded = FALSE;
                    errorString = [[error userInfo] objectForKey:@"error"];
                    
                    resultblock(joinSucceeded, pUser, errorString);
                }
            }];
        }
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
