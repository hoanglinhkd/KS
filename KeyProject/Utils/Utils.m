//
//  Utils.m
//  Motel
//
//  Created by LinhNguyen on 9/3/14.
//  Copyright (c) 2014 Linh Nguyen. All rights reserved.
//

#import "Utils.h"

static NSNumberFormatter *mPriceFormater;
@implementation Utils

+ (void)initialize{
    [self createFormater];
}

+ (void)createFormater{
    mPriceFormater = [[NSNumberFormatter alloc] init];
    //[mValFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    //[mPriceFormater setPositiveFormat:@"#,##0.00"];
    [mPriceFormater setPositiveFormat:@"#,##0"];
    [mPriceFormater setZeroSymbol:@"-"];
    
}

+ (NSString*)getFormatPrice:(double)val{
    return [mPriceFormater stringFromNumber:[NSNumber numberWithLong:val]];
}

/*
+ (void)formatCornerRadius:(id)view{
    UIView* viewtmp = view;
    viewtmp.layer.cornerRadius = 5.0f;
}

+ (void)formatButtonDefault:(UIButton*)btn{
    btn.backgroundColor = [UIColor blueColor];
    btn.layer.cornerRadius = 5.0f;
}
 */
@end
