//
//  OttaFriend.m
//  Otta
//
//  Created by Vo Cong Huy on 11/17/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaFriend.h"

@implementation OttaFriend
@synthesize name, isFriend;

- (id) initWithName:(NSString*) _name friendStatus:(BOOL*) status{
    self.name = _name;
    self.isFriend = status;
    return self;
}
@end
