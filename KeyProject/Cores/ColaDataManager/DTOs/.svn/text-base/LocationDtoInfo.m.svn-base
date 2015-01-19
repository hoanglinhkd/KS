//
//  LocationDtoInfo.m
//  TestAFNetWorking
//
//  Created by Linh.Nguyen on 8/30/14.
//  Copyright (c) 2014 CSC. All rights reserved.
//

#import "LocationDtoInfo.h"
#import "CLConsts.h"

@implementation LocationDtoInfo


/*"address": "á»‰ : 117/128/7 nguyá»…n há»¯u cáº£nh , p22 ,quáº­n bÃ¬nh Tháº¡nh",
 "lat": 43.1938516,
 "lng": -71.5723953
*/
+ (LocationDtoInfo*)setDictInfo:(NSDictionary*)info{
    LocationDtoInfo *dto = [[LocationDtoInfo alloc] init];
    
    //NSLog(@"%@",[info objectForKey:@"address"]);
    if ([[info objectForKey:@"address"] isKindOfClass:[NSNull class]]) {
        dto.address    =   CL_UnKnown;
    }else{
        dto.address    =   [info objectForKey:@"address"];
    }
    dto.lat        =   [[info objectForKey:@"lat"] doubleValue];
    dto.lng        =   [[info objectForKey:@"lng"] doubleValue];
    
    return dto;
}

@end
