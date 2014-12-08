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
#import "OttaQuestion.h"
#import "OttaAnswer.h"

@interface OttaDataViewController ()

@end

@implementation OttaDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)addTmpQuestion {
    PFQuery *query = [PFUser query];
    PFUser *user1  = (PFUser *)[query getObjectWithId:@"JMEoDSbGsd"];
    PFUser *user2  = (PFUser *)[query getObjectWithId:@"GUOL5Zpm0M"];

    OttaAnswer* answer1 = [[OttaAnswer alloc] init];
    answer1.answerText = @"Answer 11111111";
    answer1.answerImage = [UIImage imageNamed:@"icon_time.png"];
    OttaAnswer* answer2 = [[OttaAnswer alloc] init];
    answer2.answerText = @"Answer 2222222";
    answer2.answerImage = [UIImage imageNamed:@"addPhotoOtta.png"];
    
    OttaQuestion* question = [[OttaQuestion alloc] init];
    question.questionText = @"Which is beautyful?";
    question.ottaAnswers = [NSMutableArray arrayWithObjects:answer1,answer2, nil];
    question.expTime = [NSDate date];
    question.isPublic = YES;
    question.responders = [NSMutableArray arrayWithObjects:user1,user2, nil];
    
    [[OttaParseClientManager sharedManager] addQuestion:question withBlock:^(BOOL isSucceeded, NSError *error) {
        NSLog(@"dsa");
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
