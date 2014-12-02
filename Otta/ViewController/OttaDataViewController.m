//
//  OttaDataViewController.m
//  Otta
//
//  Created by ThienHuyen on 11/30/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaDataViewController.h"
#import <Parse/Parse.h>
#import "OttaParseClientManager.h"

@interface OttaDataViewController ()

@end

@implementation OttaDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    PFQuery *query = [PFUser query];
//    PFUser *user1  = (PFUser *)[query getObjectWithId:@"bJqgxJi2Vs"];
    PFUser *user2  = (PFUser *)[query getObjectWithId:@"lgdLAVuveH"];
    
    
    
    
    [[OttaParseClientManager sharedManager] getAllFollowToUser:user2 withBlock:^(NSArray *array, NSError *error) {
        NSLog(@"fads");
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
