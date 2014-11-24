//
//  OttaAlertManager.m
//  Otta
//
//  Created by Thien Chau on 11/15/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaAlertManager.h"
#import <QuartzCore/QuartzCore.h>
#import "AFPickerView.h"
#import "OttaAppDelegate.h"

@interface OttaAlertManager() <AFPickerViewDataSource, AFPickerViewDelegate>
{
    OttaAlertCompletion ottaAlertCompletion;
    OttaAlertCancel ottaAlertCancel;
    OttaFriendAlertCompletion ottaFriendAlertCompletion;
    
    AFPickerView *pickerTimeValue;
    AFPickerView *pickerTimeTitle;
    NSMutableArray *timeValueData;
    NSMutableArray *timeTitleData;
    OttaTimePickerCompletion timePickerCompletion;
    TimeSelection selectedTimeTitle;
    NSInteger selectedTimeValue;
}

@property (strong, nonatomic) IBOutlet UIView *simpleAlertView;
@property (weak, nonatomic) IBOutlet UILabel *lblSimpleContent;

@property (strong, nonatomic) IBOutlet UIView *yesNoAlertView;
@property (weak, nonatomic) IBOutlet UILabel *lblYesNoContent;

@property (strong, nonatomic) IBOutlet UIView *limitTimerAlertView;
@property (weak, nonatomic) IBOutlet UIImageView *imagePicker;

@property (strong, nonatomic) IBOutlet UIView *friendAlertView;
@property (weak, nonatomic) IBOutlet UILabel *lblFriendName;


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

- (void)showAleartWithView:(UIView*)view {
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
    [_yesNoAlertView removeFromSuperview];
    [_limitTimerAlertView removeFromSuperview];
    if ([self.view superview] != nil) {
        [self.view removeFromSuperview];
    }
}

#pragma mark - Simple Alert

- (void)showSimpleAlertOnView:(UIView*)parentView withContent:(NSString*)content complete:(OttaAlertCompletion)completionBlock {
    self.view.frame = parentView.bounds;
    [parentView addSubview:self.view];
    _lblSimpleContent.text = content;
    
    NSLog(@"Parent Frame: x = %f, y = %f, width = %f, height = %f",self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    
    ottaAlertCompletion = completionBlock;
    if ([_simpleAlertView superview] == nil) {
        [self showAleartWithView:_simpleAlertView];
    }
}

- (void)showSimpleAlertWithContent:(NSString*)content complete:(OttaAlertCompletion)completionBlock {
    
    OttaAppDelegate *appDelegate = (OttaAppDelegate*)[UIApplication sharedApplication].delegate;
    UIView *windowView = appDelegate.window;
    [self showSimpleAlertOnView:windowView withContent:content complete:completionBlock];
}

- (IBAction)simpleDonePressed:(id)sender {
    [self hideAlertAction:_simpleAlertView];
    
    if (ottaAlertCompletion != nil) {
        ottaAlertCompletion();
    }
}

#pragma mark - YesNo Alert

- (void)showYesNoAlertOnView:(UIView*)parentView withContent:(NSString*)content complete:(OttaAlertCompletion)completionBlock cancel:(OttaAlertCancel)cancelBlock {
    self.view.frame = parentView.bounds;
    [parentView addSubview:self.view];
    _lblYesNoContent.text = content;
    ottaAlertCompletion = completionBlock;
    ottaAlertCancel = cancelBlock;
    if ([_yesNoAlertView superview] == nil) {
        [self showAleartWithView:_yesNoAlertView];
    }
}

- (IBAction)yesButtonPressed:(id)sender {
    [self hideAlertAction:_simpleAlertView];
    
    if (ottaAlertCompletion != nil) {
        ottaAlertCompletion();
    }
}

- (IBAction)noButtonPressed:(id)sender {
    [self hideAlertAction:_simpleAlertView];
    
    if (ottaAlertCancel != nil) {
        ottaAlertCancel();
    }
}

#pragma mark - Timer Picker

- (void)showLimitTimerPickerOnView:(UIView*)parentView completionBlock:(OttaTimePickerCompletion) completionResult
{
    self.view.frame = parentView.bounds;
    [parentView addSubview:self.view];
    timePickerCompletion = completionResult;
    [self initTimePickerAtX:100.0 atY:30.0];
    [self showAleartWithView:_limitTimerAlertView];
}

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
    [timeTitleData addObject:[@"mins" toCurrentLanguage]];
    [timeTitleData addObject:[@"hrs" toCurrentLanguage]];
    [timeTitleData addObject:[@"days" toCurrentLanguage]];
    
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

-(IBAction)timeSelectionDonePressed:(id)sender
{
    [self hideAlertAction:_limitTimerAlertView];
    
    if (timePickerCompletion != nil) {
        timePickerCompletion(selectedTimeValue, selectedTimeTitle);
    }
}

#pragma mark - Timer Picker

- (void)showFriendAlertOnView:(UIView*)parentView withName:(NSString*)name complete:(OttaFriendAlertCompletion)completionBlock {
  
    self.view.frame = parentView.bounds;
    [parentView addSubview:self.view];
    _lblFriendName.text = name;
    ottaFriendAlertCompletion = completionBlock;
    if ([_friendAlertView superview] == nil) {
        [self showAleartWithView:_friendAlertView];
    }
}

- (IBAction)removeFriend:(id)sender {
    [self hideAlertAction:_friendAlertView];
    if (ottaFriendAlertCompletion != nil) {
        ottaFriendAlertCompletion(FriendActionRemove);
    }
}

- (IBAction)blockFriend:(id)sender {
    [self hideAlertAction:_friendAlertView];
    if (ottaFriendAlertCompletion != nil) {
        ottaFriendAlertCompletion(FriendActionBlock);
    }
}

- (IBAction)cancelFriend:(id)sender {
    [self hideAlertAction:_friendAlertView];
    if (ottaFriendAlertCompletion != nil) {
        ottaFriendAlertCompletion(FriendActionCancel);
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
