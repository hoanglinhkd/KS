//
//  Const.h
//  Motel
//
//  Created by Linh.Nguyen on 7/27/14.
//  Copyright (c) 2014 CSC. All rights reserved.
//

#ifndef Motel_Const_h
#define Motel_Const_h

typedef struct Vector{
    CGPoint begin;
    CGFloat beginTime;
    CGPoint end;
    CGFloat endTime;
    CGPoint lastEnd;
    BOOL isMovingUp;
}LNVector;

typedef enum{
    GroupListMoveOptionNone = 0,
    GroupListMoveOptionLeftToRight = 1,
    GroupListMoveOptionRightToLeft = 2
}GroupListMoveOption;


#define kHeighOfSubContent (253/568.0f)*[UIScreen mainScreen].bounds.size.height
#define MainScreenBounds [UIScreen mainScreen].bounds

#define MT_NEEDSHOWMENU @"MT_NEED_SHOWMENU"
#define MT_NEEDHIDEMENU @"MT_NEED_HIDEMENU"
#define MT_DIDSWIPELEFT @"MT_DID_SWIPELEFT"


#define kOriginYSearchView 180;

#define kBgColorBaseView [UIColor colorWithRed:230*1.0f/255 green:233*1.0f/255 blue:208*1.0f/255 alpha:1.0f];
#define kBgColorNibView  [UIColor colorWithRed:0*1.0f/255 green:122*1.0f/255 blue:255*1.0f/255 alpha:1.0f];


/*
 Define Functions
 */
typedef void(^onSuccessReturn)(NSArray* object);
typedef void(^onFailedReturn)(NSError* error);


#endif
