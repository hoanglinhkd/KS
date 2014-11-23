//
//  LanguageHelper.m
//  GroundTruth_Platform_iOS
//
//  Created by Gambogo on 10/16/14.
//  Copyright (c) 2014 TMA. All rights reserved.
//

#import "LanguageHelper.h"

@implementation LanguageHelper

static NSBundle *bundle = nil;

/*
 example calls:
 [Language setLanguage:@"it"];
 [Language setLanguage:@"de"];
 */

+(NSString*) getCurrentLanguageCode
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:LANGUAGE_CURRENT];
}

+(void) setLanguage:(NSString *)langCode {
    
    NSLog(@"preferredLang: %@", langCode);
    [[NSUserDefaults standardUserDefaults] setObject:langCode forKey:LANGUAGE_CURRENT];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:langCode ofType:@"lproj" ];
    bundle = [NSBundle bundleWithPath:path];
    
}

+(NSString *) get:(NSString *)key alter:(NSString *)alternate {
    NSString *languageValue = [bundle localizedStringForKey:key value:key table:nil];
    if(languageValue.length <= 0) {
        return key;
    }
    
    return languageValue;
}

@end
