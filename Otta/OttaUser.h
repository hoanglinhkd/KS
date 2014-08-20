//
//  OttaUser.h
//  Otta
//
//  Created by Steven Ojo on 7/28/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OttaUser : NSObject
@property (nonatomic,strong)NSString * ottaUserID;
@property (nonatomic,strong)NSString * firstName;
@property (nonatomic,strong)NSString * lastName;
@property (nonatomic,strong)NSString * profilePhotoUrl;

@end
