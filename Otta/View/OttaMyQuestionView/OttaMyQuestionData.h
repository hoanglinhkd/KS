//
//  OttaMyQuestionData.h
//  Otta
//
//  Created by Linh.Nguyen on 12/4/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OttaAnswer.h"

#define kCollapse @"Collapse"
#define kSeeAll   @"See all..."

enum MyQuestionDataType{
    MyQuestionDataTypeHeader = 1,
    MyQuestionDataTypeAnswer = 2,
    MyQuestionDataTypeFooterNormal = 3,
    MyQuestionDataTypeFooterSeeAll = 4,
    MyQuestionDataTypeFooterCollapse = 5,
    MyQuestionDataTypeAnswerPicture = 6,
    MyQuestionDataTypeDone = 7,
    MyQuestionDataTypeVote = 8
};

@interface OttaMyQuestionData : NSObject

@property (nonatomic, assign) enum MyQuestionDataType dataType;

@property (nonatomic,strong) NSString * questionID;
@property (nonatomic,strong) NSString * askerID;
@property (nonatomic,assign) int expirationDate;
@property (nonatomic,retain) NSDate *expTime;
@property (nonatomic,strong) NSString * questionText;
@property (nonatomic,strong) PFObject * answer;

@property (nonatomic,assign) int referIndex;
@property (nonatomic,assign) NSInteger currentTableIndex;

@property (nonatomic, strong) NSArray *voteUsers;
@property (nonatomic, assign) BOOL isShowedVote;

@property (nonatomic, assign) BOOL isShowedOptionDone;
@property (nonatomic, assign) BOOL disableSelecting;
@property (nonatomic,assign)  int numberAnswer;




@end
