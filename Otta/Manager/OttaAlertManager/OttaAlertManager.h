//
//  OttaAlertManager.h
//  Otta
//
//  Created by ThienHuyen on 11/15/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OttaAlertManager : UIViewController

@property (strong, nonatomic) UIView* parentView;

+ (id)sharedManager;
- (void)showSimpleAlertOnView:(UIView*)parentView withTitle:(NSString*)title andContent:(NSString*)content;

@end
