//
//  MotelDTO.m
//  TestAFNetWorking
//
//  Created by Linh.Nguyen on 8/30/14.
//  Copyright (c) 2014 CSC. All rights reserved.
//

#import "MotelDTO.h"


@implementation MotelDTO
/*
 [
 {
 "location": {
 "address": "á»‰ : 117/128/7 nguyá»…n há»¯u cáº£nh , p22 ,quáº­n bÃ¬nh Tháº¡nh",
 "lat": 43.1938516,
 "lng": -71.5723953
 },
 "id": 2.5994787278457182e+28,
 "view": 0,
 "otherInfo": {
 "type": null,
 "time": "thá»�i gian thoáº£i mÃ¡i",
 "internet": false,
 "weather": false,
 "closed": false
 },
 "imageList": [],
 "title": "TÃŒM 1-2 NAM á»ž GHÃ‰P NHÃ€ NGUYÃŠN CÄ‚N",
 "price": 2300000,
 "area": 0,
 "locationDistinceList": {
 "locationDistinceList": []
 },
 "phoneNumberList": [
 "0985161245"
 ],
 "postingDate": 1392742800000
 }
 
 */
+ (MotelDTO*)setDictInfo:(NSDictionary*)dict{
    MotelDTO *dto = [[MotelDTO alloc] init];
    //1
    if ([dict objectForKey:@"location"] != nil) {
        dto.location = [LocationDtoInfo setDictInfo:[dict objectForKey:@"location"]];
    }
    
    //2
    dto.idIndex     = [[dict objectForKey:@"id"] integerValue];
    dto.view        = [[dict objectForKey:@"view"] integerValue];
    //3
    OtherInfoDTO *otherDto = [OtherInfoDTO setDictInfo:[dict objectForKey:@"otherInfo"]];
    dto.otherInfo   = otherDto;
    //4
    dto.imageList   = [dict objectForKey:@"imageList"];
    dto.title       = [dict objectForKey:@"title"];
    dto.price       = [[dict objectForKey:@"price"] doubleValue];
    dto.area        = [[dict objectForKey:@"area"] doubleValue];
    dto.phoneNumberList = [dict objectForKey:@"phoneNumberList"];
    dto.postingDate = [NSDate dateWithTimeIntervalSince1970:[[dict objectForKey:@"postingDate"] longValue]];
    
    return dto;
}

@end
