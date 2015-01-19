//
//  AutoCompleteDTO.h
//  Motel
//
//  Created by LinhNguyen on 9/3/14.
//  Copyright (c) 2014 Linh Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
"predictions" : [
                 {
                     "description" : "Cách Mạng Tháng 8, Ho Chi Minh City, Ho Chi Minh, Vietnam",
                     "id" : "575da72b69653da4f630e04662671eaa96e91fde",
                     "matched_substrings" : [
                                             {
                                                 "length" : 15,
                                                 "offset" : 0
                                             }
                                             ],
                     "place_id" : "Ej1Dw6FjaCBN4bqhbmcgVGjDoW5nIDgsIEhvIENoaSBNaW5oIENpdHksIEhvIENoaSBNaW5oLCBWaWV0bmFt",
                     "reference" : "ClRBAAAA4_megrGtdjaDzQgBppa8TYWdRQ7AeJ9UkoMO5zFqWF-VIsa5mo--toTjVelIt4_ijIYEH7S12bscEjZVIotU9Za18aBFsVbti8ccO-G0P0sSEMcXYT5-1tJvviqbJ4AydBYaFHV1BPL-GZ_V8ATu9PY20-f2McB-",
                     "terms" : [
                                {
                                    "offset" : 0,
                                    "value" : "Cách Mạng Tháng 8"
                                },
                                {
                                    "offset" : 19,
                                    "value" : "Ho Chi Minh City"
                                },
                                {
                                    "offset" : 37,
                                    "value" : "Ho Chi Minh"
                                },
                                {
                                    "offset" : 50,
                                    "value" : "Vietnam"
                                }
                                ],
                     "types" : [ "route", "geocode" ]
                 },
*/
@interface MatchedInfoDTO : NSObject

@property (nonatomic, assign)NSInteger length;
@property (nonatomic, assign)NSInteger offset;
+ (MatchedInfoDTO*)setDataFromDict:(NSDictionary*)dict;
@end

@interface TermInfoDTO : NSObject

@property (nonatomic, assign)NSInteger offset;
@property (nonatomic, copy)NSString* value;
+ (TermInfoDTO*)setDataFromDict:(NSDictionary*)dict;
@end
@interface AutoCompleteDTO : NSObject

@property (nonatomic, copy)NSString* description;
@property (nonatomic, copy)NSString* idString;
@property (nonatomic, copy)NSArray* matched_substrings;
@property (nonatomic, copy)NSString* place_id;
@property (nonatomic, copy)NSString* reference;
@property (nonatomic, copy)NSArray* terms;
@property (nonatomic, copy)NSArray* types;

+ (AutoCompleteDTO*)setDataFromDict:(NSDictionary*)dict;

@end
