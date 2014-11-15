//
//  OttaAlertManager.h
//  Otta
//
//  Created by Thien Chau on 11/15/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

@interface OttaAlertManager : UIViewController

@property (strong, nonatomic) UIView* parentView;

typedef void(^OttaTimePickerCompletion)(NSInteger timeValue, TimeSelection timeSelectionValue);

typedef void(^OttaAlertCompletion)();
typedef void(^OttaAlertCancel)();

+ (id)sharedManager;

/**
 *  Show alert with Done button
 *
 *  @param parentView
 *  @param content
 *  @param completionBlock
 */
- (void)showSimpleAlertOnView:(UIView*)parentView withContent:(NSString*)content complete:(OttaAlertCompletion)completionBlock;

/**
 *  Show yes-no alert with a content
 *
 *  @param parentView
 *  @param content
 *  @param completionBlock
 *  @param cancelBlock
 */
- (void)showYesNoAlertOnView:(UIView*)parentView withContent:(NSString*)content complete:(OttaAlertCompletion)completionBlock cancel:(OttaAlertCancel)cancelBlock;

/**
 *  Show picker deadline time in Ask question screen
 *
 *  @param parentView
 *  @param completionResult
 */
- (void)showLimitTimerPickerOnView:(UIView*)parentView completionBlock:(OttaTimePickerCompletion) completionResult;

@end
