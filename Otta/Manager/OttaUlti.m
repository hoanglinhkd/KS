//
//  OttaUlti.m
//  Otta
//
//  Created by ThienHuyen on 12/17/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaUlti.h"

@implementation OttaUlti

+ (BOOL) isValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO;
    
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

+ (UIImage*)resizeImage:(UIImage*)image {
    
    int maxSize = 1024;
    CGFloat oldWidth = image.size.width;
    CGFloat oldHeight = image.size.height;
    CGFloat newHeight, newWidth;
    
    if (oldHeight > oldWidth) {
        if (oldHeight > maxSize) {
            newHeight = maxSize;
            newWidth = newHeight * oldWidth / oldHeight;
        } else {
            return image;
        }
    } else {
        if (oldWidth > maxSize) {
            newWidth = maxSize;
            newHeight = newWidth * oldHeight / oldWidth;
        } else {
            return image;
        }
    }
    
    CGSize newSize = CGSizeMake(newWidth, newHeight);
    
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (NSString *) timeAgo:(NSDate *)origDate{
    NSDate *timeNow = [[NSDate alloc] init];
    double ti = [timeNow timeIntervalSinceDate:origDate];
    ti = ti*-1;
    if (ti < 60) {
        return [NSString stringWithFormat:@"1 min"];
    } else if (ti < 3600) {
        int diff = round(ti / 60);
        if (diff == 60) return [NSString stringWithFormat:@"1 hour"];
        return [NSString stringWithFormat:@"%d minutes", diff];
    } else if (ti < 86400) {
        int diff = round(ti / 60 / 60);
        if (diff ==24) return [NSString stringWithFormat:@"1 day"];
        if (diff ==1) return [NSString stringWithFormat:@"1 hour"];
        return[NSString stringWithFormat:@"%d hours", diff];
    } else if (ti < 604800) {
        int diff = round(ti / 60 / 60 / 24);
        if (diff ==7) return [NSString stringWithFormat:@"1 week"];
        return[NSString stringWithFormat:@"%d days", diff];
    } else if (ti <= 2419200){
        int diff = ceil(ti / 60 / 60 / 24 / 7);
        if (diff ==1) return [NSString stringWithFormat:@"1 week"];
        return[NSString stringWithFormat:@"%d weeks", diff];
    } else if (ti > 2419200){
        int diff = ceil(ti / 60 / 60 / 24 / 30);
        if (diff ==1) return [NSString stringWithFormat:@"1 month"];
        return[NSString stringWithFormat:@"%d months", diff];
    }
    return @"";
}

@end
