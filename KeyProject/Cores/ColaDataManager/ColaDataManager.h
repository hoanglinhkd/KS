//
//  ColaDataManager.h
//  TestAFNetWorking
//
//  Created by Linh.Nguyen on 8/26/14.
//  Copyright (c) 2014 CSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CLConsts.h"

@interface ColaDataManager : NSObject

+ (ColaDataManager*) sharedInstance;

- (void)requestDemoData;

// Google API service
- (void)autocompleteAddressWithKey:(NSString*)inputStr;

@end
