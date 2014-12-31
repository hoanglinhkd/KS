//
//  OttaUlti.h
//  Otta
//
//  Created by ThienHuyen on 12/17/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OttaUlti : NSObject

+ (BOOL) isValidEmail:(NSString *)checkString;
+ (UIImage*)resizeImage:(UIImage*)image;
+ (NSString *) timeAgo:(NSDate *)origDate;
@end
