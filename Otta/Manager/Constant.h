//
//  Constant.h
//  Otta
//
//  Created by Gambogo on 11/15/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    TimeSelection_Minutes = 0,
    TimeSelection_Hours,
    TimeSelection_Days,
} TimeSelection;

@interface Constant : NSObject

+(BOOL) isValidEmail:(NSString *)checkString;

@end
