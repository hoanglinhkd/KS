//
//  OttAddFriendViewController.h
//  Otta
//
//  Created by ThienHuyen on 11/11/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OttAddFriendViewController : UIViewController

@property (assign, nonatomic) BOOL doesAccessContact;

@property (weak, nonatomic) IBOutlet UIButton *btnCheck;

- (IBAction)backButtonPressed:(id)sender;
- (IBAction)checkButtonPressed:(id)sender;
@end
