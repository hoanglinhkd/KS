//
//  OttaLoginDetailViewController.h
//  Otta
//
//  Created by Gambogo on 11/23/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OttaViewController.h"

@interface OttaLoginDetailViewController : UIViewController

@property (nonatomic,strong) OttaViewController *loginView;

@property (nonatomic,strong)IBOutlet UITextField * usernameTextField;
@property (nonatomic,strong)IBOutlet UITextField * passwordTextField;


@end
