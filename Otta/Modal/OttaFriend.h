//
//  OttaFriend.h
//  Otta
//
//  Created by Vo Cong Huy on 11/17/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OttaFriend : NSObject

@property (nonatomic,strong)NSString * name;
@property (nonatomic,assign)BOOL* isFriend;
- (id) initWithName:(NSString*) _name friendStatus:(BOOL*) status;
@end
