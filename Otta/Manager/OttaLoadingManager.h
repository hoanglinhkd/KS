//
//  OttaLoadingManager.h
//  Otta
//
//  Created by Gambogo on 12/25/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SVProgressHUD.h"

@interface OttaLoadingManager : NSObject

+ (id)sharedManager;
-(void)show;
-(void)hide;
@end
