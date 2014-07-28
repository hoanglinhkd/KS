//
//  OttaSessionManager.m
//  Otta
//
//  Created by Steven Ojo on 7/27/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaSessionManager.h"

@implementation OttaSessionManager
+(id)sharedManager{
    
    static OttaSessionManager *sharedManager = nil;
    
    @synchronized(self) {
        if (sharedManager == nil)
        {
            sharedManager = [[self alloc] init];
            
            
            
            
            
            
        }
    }
    
    
    return sharedManager;
}
@end
