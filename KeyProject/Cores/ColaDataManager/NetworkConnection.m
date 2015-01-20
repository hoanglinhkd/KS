//
//  NetworkConnection.m
//  TestAFNetWorking
//
//  Created by LinhNguyen on 8/26/14.
//  Copyright (c) 2014 CSC. All rights reserved.
//

#import "NetworkConnection.h"
#import "AFHTTPRequestOperation.h"
#import "AFURLRequestSerialization.h"

@interface NetworkConnection()<NSXMLParserDelegate>{
    NSMutableDictionary *xmlDictData;
    
    onSuccessReturn _onSuccessCallBack;
    onFailedReturn _onFailCallBack;
}
@property(strong) NSDictionary *whatEverThingDict;

@end

@implementation NetworkConnection

- (void)requestAPI:(NSString*)urlString
       onSuccessed:(onSuccessReturn)onSuccess
            onFail:(onFailedReturn)onFail{
    // assign callback function
    _onSuccessCallBack = onSuccess;
    _onFailCallBack = onFail;
    
    [self requestAPI:urlString];
}
- (void)requestAPI:(NSString*)urlString{
    
    NSString* escapedUrlString =[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:escapedUrlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    // Set parametters
    
    // Make sure to set the responseSerializer correctly --> for Json
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    // For content type need to accept
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json", nil];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.whatEverThingDict = (NSDictionary *)responseObject;
        
        if (self.whatEverThingDict) {
            NSArray *arr = [NSArray arrayWithObject:self.whatEverThingDict];
            _onSuccessCallBack(arr);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"error code %ld---> %@",error.code, error.description);
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error Retrieving Data"
                                                            message:[error localizedDescription]
                                                           delegate:nil
                                                  cancelButtonTitle:@"Ok"
                                                  otherButtonTitles:nil];
        [alertView show];
        
    }];
    
    [operation start];
}


@end
