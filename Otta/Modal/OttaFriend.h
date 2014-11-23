//
//  OttaFriend.h
//  Otta
//
//  Created by Thien Chau on 11/17/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OttaFriend : NSObject

@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSMutableArray * emailList;
@property (nonatomic,strong) NSMutableArray * phoneList;
@property (nonatomic,assign) BOOL isFriend;
@property (nonatomic,assign) BOOL isSelected;

- (id) initWithName:(NSString*) _name friendStatus:(BOOL) status;

@end
