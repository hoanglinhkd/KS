//
//  OttaAnswer.h
//  Otta
//
//  Created by Steven Ojo on 8/20/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OttaAnswer : NSObject

@property (nonatomic,strong)UIImage * answerImage;
@property (nonatomic,strong)NSString * answerCaptionImage;
@property (nonatomic,strong)NSString * imageURL;
@property (nonatomic,strong)NSString * answerText;
@property (nonatomic,assign) BOOL answerHasContent;
@property (nonatomic, assign) BOOL answerHasphoto;
@property (nonatomic, assign) int numberAnswer;

@end
