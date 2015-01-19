//
//  AutoCompleteDTO.m
//  Motel
//
//  Created by LinhNguyen on 9/3/14.
//  Copyright (c) 2014 Linh Nguyen. All rights reserved.
//

#import "AutoCompleteDTO.h"
#import "CLConsts.h"
/*
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
*/
@implementation AutoCompleteDTO
@synthesize description, idString, matched_substrings, place_id, reference, terms, types;

+ (AutoCompleteDTO*)setDataFromDict:(NSDictionary*)dict{
    AutoCompleteDTO *autoCmp = [[AutoCompleteDTO alloc] init];
    
    autoCmp.description =   [dict objectForKey:@"description"];
    autoCmp.idString    =   [dict objectForKey:@"id"];
    
    NSArray *arrMatched =   [dict objectForKey:@"matched_substrings"];
    NSMutableArray *arrTmp        =   [[NSMutableArray alloc] initWithCapacity:arrMatched.count];
    for (NSDictionary *dictTmp in arrMatched) {
        MatchedInfoDTO *matchDTO = [MatchedInfoDTO setDataFromDict:dictTmp];
        [arrTmp addObject:matchDTO];
    }
    autoCmp.matched_substrings = arrTmp;
    
    autoCmp.place_id    =   [dict objectForKey:@"place_id"];
    autoCmp.reference   =   [dict objectForKey:@"reference"];
    
    NSArray *arrTerm    =   [dict objectForKey:@"terms"];
    NSMutableArray *arrTmp2 = [[NSMutableArray alloc] initWithCapacity:arrTerm.count];
    for (NSDictionary *dictTerm in arrTerm) {
        TermInfoDTO *termDTO = [TermInfoDTO setDataFromDict:dictTerm];
        [arrTmp2 addObject:termDTO];
    }
    autoCmp.terms   =   arrTmp2;
    
    autoCmp.types   =   [dict objectForKey:@"types"];
    
    return autoCmp;
}
@end

@implementation MatchedInfoDTO

+ (MatchedInfoDTO*)setDataFromDict:(NSDictionary*)dict{
    MatchedInfoDTO *matchedInfo = [[MatchedInfoDTO alloc] init];
    
    matchedInfo.length = [[dict objectForKey:@"length"] integerValue] ?: 0;
    matchedInfo.offset = [[dict objectForKey:@"offset"] integerValue] ?: 0;
    return matchedInfo;
}
@end

@implementation TermInfoDTO

+ (TermInfoDTO*)setDataFromDict:(NSDictionary*)dict{
    TermInfoDTO *matchedInfo = [[TermInfoDTO alloc] init];
    
    matchedInfo.offset = [[dict objectForKey:@"offset"] integerValue] ?: 0;
    matchedInfo.value = [dict objectForKey:@"value"] ?: CL_UnKnown;
    return matchedInfo;
}

@end

