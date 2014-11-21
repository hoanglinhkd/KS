//
//  OttaQuestionFeedViewController.m
//  Otta
//
//  Created by Dong Duong on 11/18/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaQuestionFeedViewController.h"
#import "OttaQuestionFeedCell.h"
#import "OttaAnswer.h"
#import "OttaQuestion.h"

static NSString * const QuestionFeedCellId = @"QuestionFeedCellId";

@interface OttaQuestionFeedViewController () {
    NSMutableArray *feedItems;
}
@end

@implementation OttaQuestionFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    feedItems = [[NSMutableArray alloc] init];
    
    OttaQuestion *question = [[OttaQuestion alloc] init];
    question.questionText = @"Test long question, long question test, test long question test long question test long question test long question?";
    // Do any additional setup after loading the view.
    OttaAnswer* answer = [[OttaAnswer alloc] init];
    answer.answerText = @"Caesar Blah Caesar Blah Caesar  Blah Caesar Caesar Blah Caesar Blah Caesar  Blah Caesar";
    answer.answerImage = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];
    
    OttaAnswer* answer1 = [[OttaAnswer alloc] init];
    answer1.answerText = @"Thousand Islands";
    answer1.answerImage = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];
    
    OttaAnswer* answer2 = [[OttaAnswer alloc] init];
    answer2.answerText = @"Strawberry Something";
    answer2.answerImage = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];
    
    OttaAnswer* answer3 = [[OttaAnswer alloc] init];
    answer3.answerText = @"Japanese noddle with pork";
    answer3.answerImage = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];
    
    
    NSArray *answers = [NSArray arrayWithObjects:answer,answer1,answer2,answer3, nil];
    question.ottaAnswers = [NSMutableArray arrayWithArray:answers];
    
    [feedItems addObject:question];
    
    question = [[OttaQuestion alloc] init];
    
    question.questionText = @"At Urth Cafe! Order which salad?";
    
    answer1 = [[OttaAnswer alloc] init];
    answer1.answerText = @"Thousand Islands";
    //answer1.answerImage = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];
    
    answer2 = [[OttaAnswer alloc] init];
    answer2.answerText = @"Strawberry Something";
    //answer2.answerImage = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];
    
    answer3 = [[OttaAnswer alloc] init];
    answer3.answerText = @"Caesar Blah";
    //answer3.answerImage = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];
    
    answers = [NSArray arrayWithObjects:answer1,answer2,answer3, nil];
    question.ottaAnswers = [NSMutableArray arrayWithArray:answers];
    
    [feedItems addObject:question];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Table datasource delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self heightForBasicCellAtIndexPath:indexPath];
}

- (CGFloat)heightForBasicCellAtIndexPath:(NSIndexPath *)indexPath {
    static OttaQuestionFeedCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.tableView dequeueReusableCellWithIdentifier:QuestionFeedCellId];
    });
    
    [self configureBasicCell:sizingCell atIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:sizingCell];
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(OttaQuestionFeedCell *)sizingCell {
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + sizingCell.tableView.contentSize.height + sizingCell.questionLbl.frame.size.height + 10;
    
    CGRect rectOfCellInTableView = [sizingCell.tableView rectForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    CGRect rectOfCellInSuperview = [sizingCell.tableView convertRect:rectOfCellInTableView toView:[sizingCell.tableView superview]];
    
    NSLog(@"Y of Cell is: %f", rectOfCellInSuperview.origin.y);
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [feedItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self basicCellAtIndexPath:indexPath];
}

- (OttaQuestionFeedCell *)basicCellAtIndexPath:(NSIndexPath *)indexPath {
    OttaQuestionFeedCell *cell = [self.tableView dequeueReusableCellWithIdentifier:QuestionFeedCellId forIndexPath:indexPath];
    [self configureBasicCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureBasicCell:(OttaQuestionFeedCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    OttaQuestion *item = feedItems[indexPath.row];
    [self setTitleForCell:cell item:item];
    
}

- (void)setTitleForCell:(OttaQuestionFeedCell *)cell item:(OttaQuestion *)item {
    NSString *title = item.questionText?: NSLocalizedString(@"[No Title]", nil);
    [cell.questionLbl setText:title];
    [cell.ownerNameLbl setText:@"Brandon Baer"];
    cell.answers = item.ottaAnswers;
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
