//
//  OttaFriend.h
//  Otta
//
//  Created by Thien Chau on 11/17/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PFUser;

@interface OttaFriend : NSObject


@property (nonatomic,strong) NSString * name;
@property (nonatomic,strong) NSString * emailAdress;
@property (nonatomic,strong) NSString * phoneNumber;
@property (nonatomic,strong) PFUser *pfUser;
@property (nonatomic,assign) BOOL isFriend;
@property (nonatomic,assign) BOOL isSelected;

- (id) initWithName:(NSString*) _name friendStatus:(BOOL) status;
- (id) initWithName:(NSString*)_name selected:(BOOL)isSelect;
    
@end
