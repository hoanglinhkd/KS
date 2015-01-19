//
//  GoogleAPIManager.h
//  Motel
//
//  Created by LinhNguyen on 9/3/14.
//  Copyright (c) 2014 Linh Nguyen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoogleAPIManager : NSObject

+ (GoogleAPIManager*) sharedInstance;

- (void)getAutocompleteWithInputString:(NSString*)input;

@end
