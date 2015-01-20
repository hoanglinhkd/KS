//
//  ColaDataManager.m
//  TestAFNetWorking
//
//  Created by Linh.Nguyen on 8/26/14.
//  Copyright (c) 2014 CSC. All rights reserved.
//

#import "ColaDataManager.h"
#import "NetworkConnection.h"
#import "MotelDTO.h"
#import "AFHTTPRequestOperation.h"
#import "AFURLRequestSerialization.h"

@implementation ColaDataManager
+ (ColaDataManager*) sharedInstance{
    static dispatch_once_t onceToken = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&onceToken, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (ColaDataManager*) init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

/*
static NSString * const BaseURLString = @"http://www.raywenderlich.com/demos/weather_sample/";
- (void)requestDemoData{
    
    // 1
    //NSString *string = [NSString stringWithFormat:@"%@weather.php?format=json", BaseURLString];
    NSString *string = [NSString stringWithFormat:CL_URL_LOCATION_DEMO];
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 2
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // For content type need to accept
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", nil];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        // 3
        NSDictionary *myDict = (NSDictionary *)responseObject;
        //self.title = @"JSON Retrieved";
        //[self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        // 4
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Weather"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
    }];
    
    // 5
    [operation start];
}
*/

- (void)requestDemoData{
    NetworkConnection *clientCnn = [[NetworkConnection alloc] init];
    [clientCnn requestAPI:CL_URL_LOCATION_DEMO onSuccessed:^(NSArray *object) {
        NSDictionary *dict = [object objectAtIndex:0];
        dict = [dict objectForKey:@"data"];
        //NSLog(@"%d",[[dict objectForKey:@"status"] intValue]);
        NSArray *data = [dict objectForKey:@"data"];
        
        MotelDTO *dto;
        NSMutableArray *arrObj = [[NSMutableArray alloc] initWithCapacity:data.count];
        for (NSDictionary *tmpDict in data) {
            dto = [MotelDTO setDictInfo:tmpDict];
            [arrObj addObject:dto];
        }
        
        // Notification Data for other views
        NSDictionary *dictNtf = [[NSDictionary alloc] initWithObjectsAndKeys:arrObj,@"data", nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:CL_NOTIF_DEMODATA object:nil userInfo:dictNtf];

    } onFail:^(NSError *error) {
        
    }];
}

- (void)autocompleteAddressWithKey:(NSString*)inputStr{
    
}

@end
