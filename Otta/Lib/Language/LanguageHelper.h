//
//  LanguageHelper.h
//  GroundTruth_Platform_iOS
//
//  Created by Gambogo on 10/16/14.
//  Copyright (c) 2014 TMA. All rights reserved.
//

#import <Foundation/Foundation.h>

//Refer below URL for more language code
//http://www.ibabbleon.com/iOS-Language-Codes-ISO-639.html
#define LANGUAGE_CURRENT @"LANGUAGE_CURRENT"

#define GetLocalizedString(key, comment) [LanguageHelper get:(key) alter:(comment)]

@interface LanguageHelper : NSObject

/*
+(void) setLanguageCode:(NSString*)langCode;
+(NSString*) getLanguageCode;
*/

+(void) setDefaultLang;
+(void) setLanguage:(NSString *)l;
+(NSString*) getCurrentLanguageCode;
+(NSString *) get:(NSString *)key alter:(NSString *)alternate;

@end
