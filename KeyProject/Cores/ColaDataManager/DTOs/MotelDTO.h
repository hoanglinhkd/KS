//
//  MotelDTO.h
//  TestAFNetWorking
//
//  Created by Linh.Nguyen on 8/30/14.
//  Copyright (c) 2014 CSC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LocationDtoInfo.h"
#import "OtherInfoDTO.h"

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
@interface MotelDTO : NSObject

@property (nonatomic, strong)LocationDtoInfo *location;
@property (nonatomic, assign)NSInteger idIndex;
@property (nonatomic, assign)NSInteger view;
@property (nonatomic, strong)OtherInfoDTO *otherInfo;
@property (nonatomic, copy)NSArray *imageList;
@property (nonatomic, copy)NSString *title;
@property (nonatomic, assign)double price;
@property (nonatomic, assign)double area;
@property (nonatomic, copy)NSArray *phoneNumberList;
@property (nonatomic, copy)NSDate *postingDate;

+ (MotelDTO*)setDictInfo:(NSDictionary*)dict;

@end
