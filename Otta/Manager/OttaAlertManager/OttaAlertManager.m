//
//  OttaAlertManager.m
//  Otta
//
//  Created by ThienHuyen on 11/15/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaAlertManager.h"
#import <QuartzCore/QuartzCore.h>
#import "AFPickerView.h"

@interface OttaAlertManager() <AFPickerViewDataSource, AFPickerViewDelegate>
{
    AFPickerView *pickerTimeValue;
    AFPickerView *pickerTimeTitle;
    NSMutableArray *timeValueData;
    NSMutableArray *timeTitleData;
    OttaTimePickerCompletion timePickerCompletion;
    TimeSelection selectedTimeTitle;
    NSInteger selectedTimeValue;
}

@property (strong, nonatomic) IBOutlet UIView *simpleAlertView;
@property (strong, nonatomic) IBOutlet UIView *limitTimerAlertView;
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

- (void)showLimitTimerPickerOnView:(UIView*)parentView completionBlock:(OttaTimePickerCompletion) completionResult
{
    timePickerCompletion = completionResult;
    [parentView addSubview:self.view];
    [self initTimePickerAtX:100.0 atY:18.0];
    [self showAleartWithView:_limitTimerAlertView];
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

- (void)hideAlertAction:(UIView*) currentView {
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
    [currentView.layer addAnimation:hideAnimation forKey:nil];
    
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.simpleAlertView removeFromSuperview];
    if ([self.view superview] != nil) {
        [self.view removeFromSuperview];
    }
}

#pragma mark - Button Interaction

- (IBAction)simpleDonePressed:(id)sender {
    [self hideAlertAction:_simpleAlertView];
}

-(IBAction)timeSelectionDonePressed:(id)sender
{
    [self hideAlertAction:_limitTimerAlertView];
    
    if (timePickerCompletion != nil) {
        timePickerCompletion(selectedTimeValue, selectedTimeTitle);
    }
}

#pragma mark - Timer Picker

-(void) initTimePickerAtX:(CGFloat)xPosition atY:(CGFloat)yPosition;
{
 
    selectedTimeTitle = TimeSelection_Minutes;
    selectedTimeValue = 1;
    
    //Check first init data or not
    if (timeTitleData.count > 0) {
        [pickerTimeTitle reloadData];
        [pickerTimeValue reloadData];
        return;
    }
    
    timeValueData = [NSMutableArray array];
    for (int i = 1; i < 99; i++) {
        [timeValueData addObject:[NSString stringWithFormat:@"%d", i]];
    }
    
    timeTitleData = [NSMutableArray array];
    [timeTitleData addObject:@"mins"];
    [timeTitleData addObject:@"hrs"];
    [timeTitleData addObject:@"days"];
    
    pickerTimeTitle = [[AFPickerView alloc] initWithFrame:CGRectMake(xPosition + 55.0, yPosition, 50.0f, 117.0f)];
    pickerTimeTitle.dataSource = self;
    pickerTimeTitle.delegate = self;
    pickerTimeTitle.rowFont = [UIFont boldSystemFontOfSize:19.0];
    pickerTimeTitle.rowIndent = 3.0;
    [pickerTimeTitle reloadData];
    [self.limitTimerAlertView addSubview:pickerTimeTitle];
    
    pickerTimeValue = [[AFPickerView alloc] initWithFrame:CGRectMake(xPosition, yPosition, 50.0f, 117.0f)];
    pickerTimeValue.dataSource = self;
    pickerTimeValue.delegate = self;
    pickerTimeValue.rowIndent = 3.0;
    [pickerTimeValue reloadData];
    [self.limitTimerAlertView addSubview:pickerTimeValue];
    
}

- (NSInteger)numberOfRowsInPickerView:(AFPickerView *)pickerView
{
    if (pickerView == pickerTimeTitle)
        return [timeTitleData count];
    
    return [timeValueData count];
}

- (NSString *)pickerView:(AFPickerView *)pickerView titleForRow:(NSInteger)row
{
    if (pickerView == pickerTimeTitle) {
        return [timeTitleData objectAtIndex:row];
    } else {
        return [timeValueData objectAtIndex:row];
    }
}


- (void)pickerView:(AFPickerView *)pickerView didSelectRow:(NSInteger)row
{
    if (pickerView == pickerTimeTitle) {
        selectedTimeTitle = row;
    } else {
        selectedTimeValue = row + 1;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
