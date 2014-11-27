//
//  OttaFacebookDetailViewController.h
//  Otta
//
//  Created by Gambogo on 11/23/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OttaViewController.h"

@interface OttaFacebookDetailViewController : UIViewController

@property (nonatomic,strong)IBOutlet UITextField * phoneFacebookDetail;
@property (nonatomic,strong)IBOutlet UITextField * emailFacebookDetail;
@property (nonatomic,strong)IBOutlet UIScrollView *scrlFacebookDetail;
@property (nonatomic,strong)IBOutlet UIButton *btnFacebookDetail;
@property (nonatomic,strong)IBOutlet OttaViewController *loginView;

@end
