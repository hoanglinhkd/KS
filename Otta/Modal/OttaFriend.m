//
//  OttaFriend.m
//  Otta
//
//  Created by Thien Chau on 11/17/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaFriend.h"

@implementation OttaFriend
@synthesize name, isFriend;

- (id) initWithName:(NSString*)_name friendStatus:(BOOL)status {
    self.name = _name;
    self.isFriend = status;
    return self;
}

- (id) initWithName:(NSString*)_name selected:(BOOL)isSelect {
    self.name = _name;
    self.isSelected = isSelect;
    return self;
}

@end
