//
//  OttaUlti.m
//  Otta
//
//  Created by ThienHuyen on 12/17/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaUlti.h"

@implementation OttaUlti

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

@end
