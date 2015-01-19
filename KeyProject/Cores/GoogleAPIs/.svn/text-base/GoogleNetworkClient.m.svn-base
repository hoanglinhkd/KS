//
//  GoogleNetworkClient.m
//  Motel
//
//  Created by LinhNguyen on 9/3/14.
//  Copyright (c) 2014 Linh Nguyen. All rights reserved.
//

#import "GoogleNetworkClient.h"
#import "AFHTTPRequestOperation.h"
#import <Foundation/Foundation.h>
#import <UIKit/UIAlertView.h>


@interface GoogleNetworkClient(){
    
}

@end

@implementation GoogleNetworkClient

- (void)getAutoCompleteAddressWithURLString:(NSString*)url
                                onSuccessed:(onSuccessReturn)success
                                     onFail:(onFailedReturn)fail{
    _onSuccessCallBack  = success;
    _onFailCallBack     = fail;
    
    [self requestAPI:url];
}

- (void)requestAPI:(NSString*)urlString{
    NSString* escapedUrlString =[urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:escapedUrlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    // Set parametters
    
    // Make sure to set the responseSerializer correctly
    operation.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        dictData = (NSDictionary *)responseObject;
        
        if (dictData) {
            NSArray *arr = [NSArray arrayWithObject:dictData];
            _onSuccessCallBack(arr);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
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
