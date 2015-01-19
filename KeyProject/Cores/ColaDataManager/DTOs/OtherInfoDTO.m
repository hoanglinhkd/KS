//
//  OtherInfoDTO.m
//  TestAFNetWorking
//
//  Created by Linh.Nguyen on 8/30/14.
//  Copyright (c) 2014 CSC. All rights reserved.
//

#import "OtherInfoDTO.h"

@implementation OtherInfoDTO

/*
 "otherInfo": {
 "type": null,
 "time": "thá»�i gian thoáº£i mÃ¡i",
 "internet": false,
 "weather": false,
 "closed": false
 }
 */
+ (OtherInfoDTO*)setDictInfo:(NSDictionary*)dict{
    OtherInfoDTO *dto = [[OtherInfoDTO alloc] init];
    
    if ([[dict objectForKey:@"type"] class] != nil) {
        dto.type = [dict objectForKey:@"type"] ?: @"Unknown";
    }else{
        NSLog(@"null recognize");
    }
    if ([[dict objectForKey:@"time"] class] != nil) {
        dto.time = [dict objectForKey:@"time"] ?: @"Unknown";
    }else{
        NSLog(@"null recognize");
    }
    dto.internet = [[dict objectForKey:@"internet"] boolValue];
    dto.weather = [[dict objectForKey:@"weather"] boolValue];
    dto.closed = [[dict objectForKey:@"closed"] boolValue];
    return dto;
}

@end
