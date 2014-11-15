//
//  OttaAlertManager.m
//  Otta
//
//  Created by ThienHuyen on 11/15/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaAlertManager.h"
#import <QuartzCore/QuartzCore.h>

@interface OttaAlertManager()

@property (strong, nonatomic) IBOutlet UIView *simpleAlertView;
@property (weak, nonatomic) IBOutlet UIButton *btnSimpleDone;

- (IBAction)simpleDonePressed:(id)sender;

@end

@implementation OttaAlertManager


+ (id)sharedManager {
    static OttaAlertManager *sharedMyManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMyManager = [OttaAlertManager initAlert];
    });
    return sharedMyManager;
}

+ (OttaAlertManager*) initAlert {
    return [[OttaAlertManager alloc] initWithNibName:@"OttaAlertManager" bundle:nil];
}

- (void)showSimpleAlertOnView:(UIView*)parentView withTitle:(NSString*)title andContent:(NSString*)content {
    if ([_simpleAlertView superview] == nil) {
        [parentView addSubview:self.view];
        [self showAleartWithView:_simpleAlertView];
    }
}

- (void)showAleartWithView:(UIView*)view {
    //UIImage *buttonImage = [[UIImage imageNamed:@"btn_alert_done"]
    //resizableImageWithCapInsets:UIEdgeInsetsMake(0, 16, 0, 16)];
    
    //    UIImage *buttonImage = [UIImage imageNamed:@"btn_alert_done"];
    //
    //    [_btnDone setImage:buttonImage forState:UIControlStateNormal];
    //    [_imgContent setImage:buttonImage];
    
    view.center = self.view.center;
    [self.view addSubview:view];
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [view.layer addAnimation:popAnimation forKey:nil];
}

- (void)hideAlertAction {
    CAKeyframeAnimation *hideAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    hideAnimation.duration = 0.4;
    hideAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0f, 1.0f, 1.0f)],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.00f, 0.00f, 0.00f)]];
    hideAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f];
    hideAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    hideAnimation.delegate = self;
    [self.simpleAlertView.layer addAnimation:hideAnimation forKey:nil];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.simpleAlertView removeFromSuperview];
    if ([self.view superview] != nil) {
        [self.view removeFromSuperview];
    }
}

- (IBAction)simpleDonePressed:(id)sender {
    [self hideAlertAction];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
