//
//  OttAddFriendViewController.m
//  Otta
//
//  Created by ThienHuyen on 11/11/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttAddFriendViewController.h"

@implementation OttAddFriendViewController

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)checkButtonPressed:(id)sender {
    _doesAccessContact = !_doesAccessContact;
    if (_doesAccessContact) {
        [_btnCheck setBackgroundImage:[UIImage imageNamed:@"icon_check2.png"] forState:UIControlStateNormal];
    } else {
        [_btnCheck setBackgroundImage:[UIImage imageNamed:@"icon_uncheck.png"] forState:UIControlStateNormal];
    }
}

- (IBAction)startButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"id_segue" sender:nil];
}

@end