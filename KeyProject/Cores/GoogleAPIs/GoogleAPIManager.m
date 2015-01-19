//
//  GoogleAPIManager.m
//  Motel
//
//  Created by LinhNguyen on 9/3/14.
//  Copyright (c) 2014 Linh Nguyen. All rights reserved.
//

#import "GoogleAPIManager.h"
#import "GoogleNetworkClient.h"
#import "AutoCompleteDTO.h"
#import "CLConsts.h"

#define kGoogleAPIKey           @"AIzaSyD868jFC5txl3VuBAu8q_e5FaFL0Me3KQY"
#define kAPICompleteAddress     @"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=__YourInput__&types=geocode&language=VNM&key=__YourGoogleKey__"


@implementation GoogleAPIManager

+ (GoogleAPIManager*) sharedInstance{
    static dispatch_once_t onceToken = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (GoogleAPIManager*) init{
    self = [super init];
    if (self) {
        
    }
    return self;
}


- (void)getAutocompleteWithInputString:(NSString*)input{
    GoogleNetworkClient *client = [[GoogleNetworkClient alloc] init];
    
    NSString *apiString = kAPICompleteAddress;
    apiString = [apiString stringByReplacingOccurrencesOfString:@"__YourInput__" withString:input];
    apiString = [apiString stringByReplacingOccurrencesOfString:@"__YourGoogleKey__" withString:kGoogleAPIKey];
    
    [client getAutoCompleteAddressWithURLString:apiString onSuccessed:^(NSArray *object) {
        //success
        NSDictionary *dataJson = [object objectAtIndex:0];
        NSArray *arrData = [dataJson objectForKey:@"predictions"];
        NSMutableArray *arrTmp = [[NSMutableArray alloc] initWithCapacity:arrData.count];
        for (NSDictionary *dict in arrData) {
            AutoCompleteDTO *dto = [AutoCompleteDTO setDataFromDict:dict];
            [arrTmp addObject:dto];
        }
        
        if (arrTmp.count > 0) {
            NSDictionary *postDict = [[NSDictionary alloc] initWithObjectsAndKeys:arrTmp,@"data",nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:CL_NOTIF_AUTOCOMPLETE_ADDRESS object:nil userInfo:postDict];
        }
        
    } onFail:^(NSError *error) {
        //
    }];
    
}

@end
