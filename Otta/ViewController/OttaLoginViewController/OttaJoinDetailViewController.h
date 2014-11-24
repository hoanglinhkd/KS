//
//  OttaJoinDetailViewController.h
//  Otta
//
//  Created by Gambogo on 11/23/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OttaViewController.h"

@interface OttaJoinDetailViewController : UIViewController

@property (nonatomic,strong) OttaViewController *loginView;

@property (nonatomic,strong)IBOutlet UITextField * firstNameJoinDetail;
@property (nonatomic,strong)IBOutlet UITextField * lastNameJoinDetail;
@property (nonatomic,strong)IBOutlet UITextField * emailJoinDetail;
@property (nonatomic,strong)IBOutlet UITextField * passwordJoinDetail;
@property (nonatomic,strong)IBOutlet UITextField * phoneJoinDetail;
@property (nonatomic,strong)IBOutlet UITextField * confirmPassJoinDetail;


@end
