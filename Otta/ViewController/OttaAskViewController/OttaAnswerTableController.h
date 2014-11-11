//
//  OttaAnswerTableController.h
//  Otta
//
//  Created by Steven Ojo on 8/21/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OttaAnswer.h"
#import "CZPhotoPickerController.h"

@interface OttaAnswerTableController : NSObject

@property (nonatomic, strong) NSMutableArray * ottaAnswers;
@property (nonatomic, weak) UIViewController * mainViewController; 
@property (nonatomic,strong)CZPhotoPickerController * photoPicker;

@end
