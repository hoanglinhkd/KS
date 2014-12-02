//
//  OttaViewController.h
//  Otta
//
//  Created by Steven Ojo on 7/27/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <EAIntroView.h>
#import "OttaParseClientManager.h"
#import "OttaAlertManager.h"

@interface OttaViewController : UIViewController

@property (nonatomic,strong) IBOutlet UIView * ottaBackingView;
@property (nonatomic,strong)IBOutlet UIButton *btnBackPage;
@property (weak, nonatomic) IBOutlet UIView *viewAction;

-(IBAction)facebookLogin:(id)sender;

@end
