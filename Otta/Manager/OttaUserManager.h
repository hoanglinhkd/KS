//
//  OttaUserManager.h
//  Otta
//
//  Created by ThienHuyen on 11/16/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>

@interface OttaUserManager : NSObject

+ (id)sharedManager;

- (void)saveCurrentUser:(PFUser*)user;
- (void)removeCurrentUser:(PFUser*)user;
- (PFUser*)getCurrentUser;
- (BOOL)isLoggedin;

@end
