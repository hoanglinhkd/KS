//
//  NSString+Common.m
//  GroundTruth_Platfrom_SmartPhone_iOS
//
//  Created by Gambogo on 11/13/14.
//  Copyright (c) 2014 TMA. All rights reserved.
//

#import "NSString+Language.h"

@implementation NSString (Language)

-(NSString*) toCurrentLanguage
{
    return GetLocalizedString(self, nil);
}

-(void) toLogConsole
{
    NSLog(@"%@", self);
}

@end
