//
//  OttaAlertManager.h
//  Otta
//
//  Created by Thien Chau on 11/15/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constant.h"

typedef enum {
    FriendActionBlock = 0,
    FriendActionRemove,
    FriendActionCancel,
} FriendAction;

@interface OttaAlertManager : UIViewController

@property (strong, nonatomic) UIView* parentView;

typedef void(^OttaTimePickerCompletion)(NSInteger timeValue, TimeSelection timeSelectionValue);

typedef void(^OttaAlertCompletion)();
typedef void(^OttaAlertCancel)();

typedef void(^OttaFriendAlertCompletion)(FriendAction action);

typedef void(^OttaEmailAlertCompletion)(NSString* email);

+ (id)sharedManager;

/**
 *  Show alert with Done button on root window
 *
 *  @param content
 *  @param completionBlock
 */
- (void)showSimpleAlertWithContent:(NSString*)content complete:(OttaAlertCompletion)completionBlock;

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

/**
 *  Show friend action picker
 *
 *  @param parentView
 *  @param name
 *  @param completionBlock 
 */
- (void)showFriendAlertOnView:(UIView*)parentView withName:(NSString*)name complete:(OttaFriendAlertCompletion)completionBlock;

/**
 *  Show Alert for entering email
 *
 *  @param parentView
 *  @param completionBlock
 *  @param cancelBlock
 */
- (void)showEmailAlertOnView:(UIView*)parentView  complete:(OttaEmailAlertCompletion)completionBlock cancel:(OttaAlertCancel)cancelBlock;
@end
