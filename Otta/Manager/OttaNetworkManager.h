//
//  OttaNetworkManager.h
//  Otta
//
//  Created by gam bogo on 12/18/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OttaAlertManager.h"
#import "Reachability.h"

@interface OttaNetworkManager : NSObject

+(BOOL)isOnline;
+(BOOL)isOffline;

/*! 
 Show dialog "No network connection" and return FALSE
 */
+(BOOL)isOfflineShowedAlertView;

@end
