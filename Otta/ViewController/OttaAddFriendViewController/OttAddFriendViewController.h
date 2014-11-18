//
//  OttAddFriendViewController.h
//  Otta
//
//  Created by Thien Chau on 11/11/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TPKeyboardAvoidingScrollView;
@interface OttAddFriendViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (assign, nonatomic) BOOL doesAccessContact;

@property (weak, nonatomic) IBOutlet UITextField *findFriendTextField;
@property (weak, nonatomic) IBOutlet UIButton *btnCheck;
@property (weak, nonatomic) IBOutlet TPKeyboardAvoidingScrollView *scrlFindFriend;

- (IBAction)backButtonPressed:(id)sender;
- (IBAction)checkButtonPressed:(id)sender;
@end
