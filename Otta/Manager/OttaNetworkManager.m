//
//  OttaNetworkManager.m
//  Otta
//
//  Created by gam bogo on 12/18/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaNetworkManager.h"

@implementation OttaNetworkManager

+(BOOL)isOnline
{
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        NSLog(@"There IS NO internet connection");
        return NO;
    } else {
        return YES;
    }
}

+(BOOL)isOffline
{
    return ![OttaNetworkManager isOnline];
}

+(BOOL)isOfflineShowedAlertView
{
    if(![OttaNetworkManager isOnline]) {
        [[OttaAlertManager sharedManager] showSimpleAlertWithContent:[@"No network connection" toCurrentLanguage] complete:nil];
        return YES;
    }
    return NO;
}

@end
