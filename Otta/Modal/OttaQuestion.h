//
//  OttaQuestion.h
//  Otta
//
//  Created by Steven Ojo on 8/20/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OttaQuestion : NSObject

@property (nonatomic, strong) NSString* questionID;
@property (nonatomic, strong) NSMutableArray* ottaAnswers;
@property (nonatomic, strong) NSMutableArray* responders;
@property (nonatomic, strong) NSString* askerID;
@property (nonatomic, strong) NSString* askerName;
@property (nonatomic, assign) int expirationDate;
@property (nonatomic, retain) NSDate* expTime;
@property (nonatomic, strong) NSString* questionText;
@property (nonatomic, assign) BOOL isPublic;

@property (nonatomic, assign) BOOL isSeeAll;

@end
