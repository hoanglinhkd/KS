//
//  OttaMyQuestionData.h
//  Otta
//
//  Created by Linh.Nguyen on 12/4/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OttaAnswer.h"

enum MyQuestionDataType{
    MyQuestionDataTypeHeader = 1,
    MyQuestionDataTypeAnswer = 2,
    MyQuestionDataTypeFooterNormal = 3,
    MyQuestionDataTypeFooterSeeAll = 4,
    MyQuestionDataTypeAnswerPicture = 5,
    MyQuestionDataTypeDone = 6
};

@interface OttaMyQuestionData : NSObject

@property (nonatomic, assign) enum MyQuestionDataType dataType;

@property (nonatomic,strong) NSString * questionID;
@property (nonatomic,strong) NSString * askerID;
@property (nonatomic,assign) int expirationDate;
@property (nonatomic,strong) NSString * questionText;
@property (nonatomic,strong) OttaAnswer * answer;

@end
