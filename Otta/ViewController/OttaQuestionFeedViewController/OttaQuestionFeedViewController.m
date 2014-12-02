//
//  OttaQuestionFeedViewController.m
//  Otta
//
//  Created by Gambogo on 11/18/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaQuestionFeedViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "OttaAnswer.h"
#import "OttaQuestion.h"
#import "OttaMediaQuestionDetailViewController.h"


static NSString * const QuestionFeedCellId = @"QuestionFeedCellId";

@interface OttaQuestionFeedViewController () {
    NSMutableArray *feedItems;
    NSMutableArray *viewAllModeCellArray;
    OttaQuestion *selectedQuestion;
}
@end

@implementation OttaQuestionFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    viewAllModeCellArray = [[NSMutableArray alloc] init];
    feedItems = [[NSMutableArray alloc] init];
    
    ///////////////////////Q1
    OttaQuestion *question = [[OttaQuestion alloc] init];
    question.askerID = @"Jamie Moskowitz";
    question.questionText = @"Test long question, long question test, test long question test?";
    // Do any additional setup after loading the view.
    OttaAnswer* answer = [[OttaAnswer alloc] init];
    answer.answerText = @"Caesar Blah Caesar Blah Caesar  Blah Caesar Caesar Blah Caesar Blah Caesar  Blah Caesar";
    answer.answerImage = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];
    answer.imageURL = @"https://farm6.static.flickr.com/5557/15191895482_e495291616_m.jpg";
    
    OttaAnswer* answer1 = [[OttaAnswer alloc] init];
    answer1.answerText = @"Thousand Islands";
    answer1.answerImage = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];

    
    OttaAnswer* answer2 = [[OttaAnswer alloc] init];
    answer2.answerText = @"Strawberry Something";
    answer2.answerImage = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];
    
    OttaAnswer* answer3 = [[OttaAnswer alloc] init];
    answer3.answerText = @"Japanese noddle with pork";
    answer3.answerImage = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];

//    OttaAnswer* answer4 = [[OttaAnswer alloc] init];
//    answer4.answerText = @"Japanese noddle with pork";
//    answer4.answerImage = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];
    
//    OttaAnswer* answer5 = [[OttaAnswer alloc] init];
//    answer5.answerText = @"Japanese noddle with pork";
//    answer5.answerImage = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];
//    
//    OttaAnswer* answer6 = [[OttaAnswer alloc] init];
//    answer6.answerText = @"Japanese noddle with pork";
//    answer6.answerImage = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];
//    
//    OttaAnswer* answer7 = [[OttaAnswer alloc] init];
//    answer7.answerText = @"Japanese noddle with pork";
//    answer7.answerImage = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];
    
    NSArray *answers = [NSArray arrayWithObjects:answer,answer1,answer2,answer3, nil];
    question.ottaAnswers = [NSMutableArray arrayWithArray:answers];
    
    [feedItems addObject:question];
    
    //////////Q2//////////
    question = [[OttaQuestion alloc] init];
    
    question.askerID = @"Jamie Moskowitz";
    question.questionText = @"At Urth Cafe! Order which salad?";
    
    answer1 = [[OttaAnswer alloc] init];
    answer1.answerText = @"Thousand Islands";
    //answer1.answerImage = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];
    
    answer2 = [[OttaAnswer alloc] init];
    answer2.answerText = @"Strawberry Something Strawberry Something Strawberry Something";
    //answer2.answerImage = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];
    
    answer3 = [[OttaAnswer alloc] init];
    answer3.answerText = @"Caesar Blah";
    //answer3.answerImage = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];
    
    answers = [NSArray arrayWithObjects:answer1,answer2,answer3, nil];
    question.ottaAnswers = [NSMutableArray arrayWithArray:answers];
    
    [feedItems addObject:question];
    
    
    
    //////////Q3/////////////
    question = [[OttaQuestion alloc] init];
    
    question.askerID = @"Jamie Moskowitz";
    question.questionText = @"At Urth Cafe! Order which salad?";
    
    answer1 = [[OttaAnswer alloc] init];
    answer1.answerText = @"Thousand Islands";
    //answer1.answerImage = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];
    
    answer2 = [[OttaAnswer alloc] init];
    answer2.answerText = @"Strawberry Something Strawberry Something Strawberry Something";

    
    answer3 = [[OttaAnswer alloc] init];
    answer3.answerText = @"Caesar Blah";

    
//    answer5 = [[OttaAnswer alloc] init];
//    answer5.answerText = @"Caesar Blah";
    
    answers = [NSArray arrayWithObjects:answer1,answer2,answer3, nil];
    question.ottaAnswers = [NSMutableArray arrayWithArray:answers];
    
    [feedItems addObject:question];
    
    ////////////////Q4
    question = [[OttaQuestion alloc] init];
    
    question.askerID = @"Jamie Moskowitz";
    question.questionText = @"At Urth Cafe! Order which salad At Urth Cafe! Order which salad?";
    
    OttaAnswer *answer6 = [[OttaAnswer alloc] init];
    answer6.answerText = @"Caesar Blah Caesar Blah Caesar Blah";
    
    answers = [NSArray arrayWithObjects:answer1,answer2,answer3,answer6, nil];
    question.ottaAnswers = [NSMutableArray arrayWithArray:answers];
    [feedItems addObject:question];
    ////////////////Q5
    question = [[OttaQuestion alloc] init];
    
    question.questionText = @"At Urth Cafe! Order which salad At Urth Cafe! Order which salad?";
    
    answers = [NSArray arrayWithObjects:answer1, nil];
    question.ottaAnswers = [NSMutableArray arrayWithArray:answers];
    [feedItems addObject:question];
    
    ////////////////Q6
    question = [[OttaQuestion alloc] init];
    
    question.askerID = @"Jamie Moskowitz";
    question.questionText = @"At Urth Cafe! Order which salad At Urth Cafe! Order which salad?";
    
    answers = [NSArray arrayWithObjects:answer1,answer2,answer3, nil];
    question.ottaAnswers = [NSMutableArray arrayWithArray:answers];
    [feedItems addObject:question];
    
    ////////////////Q7
    question = [[OttaQuestion alloc] init];
    
    question.askerID = @"Jamie Moskowitz";
    question.questionText = @"At Urth Cafe! Order which salad At Urth Cafe! Order which salad?";
    
    answer3 = [[OttaAnswer alloc] init];
    answer3.answerText = @"Caesar Blah Caesar Blah Caesar Blah";
    
    
    answers = [NSArray arrayWithObjects:answer1,answer2,answer3, nil];
    question.ottaAnswers = [NSMutableArray arrayWithArray:answers];
    [feedItems addObject:question];
    
    ///////////////////////Q8
    question = [[OttaQuestion alloc] init];
    
    question.askerID = @"Jamie Moskowitz";
    question.questionText = @"Test Short question?";
    // Do any additional setup after loading the view.
    answer = [[OttaAnswer alloc] init];
    answer.answerText = @"Caesar Blah Caesar Blah Caesar  Blah Caesar Caesar Blah Caesar Blah Caesar  Blah Caesar";
    answer.answerImage = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];
    answer.imageURL = @"https://farm6.static.flickr.com/5557/15191895482_e495291616_m.jpg";
    
    answer1 = [[OttaAnswer alloc] init];
    answer1.answerText = @"Thousand Islands";
    answer1.answerImage = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];

    
    answer2 = [[OttaAnswer alloc] init];
    answer2.answerText = @"Strawberry Something";
    answer2.answerImage = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];
    
    answer3 = [[OttaAnswer alloc] init];
    answer3.answerText = @"Japanese noddle with pork";
    answer3.answerImage = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];
    

    
    
    answers = [NSArray arrayWithObjects:answer,answer1,answer2,answer3, nil];
    question.ottaAnswers = [NSMutableArray arrayWithArray:answers];
    
    [feedItems addObject:question];
    ////////////////////Q9
    
    question = [[OttaQuestion alloc] init];
    
    question.askerID = @"Jamie Moskowitz";
    question.questionText = @"Test 3 Answer?";
    
    answers = [NSArray arrayWithObjects:answer,answer1,answer2, nil];
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

    
    CGSize questionSize = [sizingCell.questionLbl systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height + sizingCell.tableView.contentSize.height + questionSize.height;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [feedItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self basicCellAtIndexPath:indexPath];
}

- (OttaQuestionFeedCell *)basicCellAtIndexPath:(NSIndexPath *)indexPath {
    OttaQuestionFeedCell *cell = [self.tableView dequeueReusableCellWithIdentifier:QuestionFeedCellId forIndexPath:indexPath];
    cell.delegate = self;
    
    [self configureBasicCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureBasicCell:(OttaQuestionFeedCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    OttaQuestion *item = feedItems[indexPath.row];
    
    if ([viewAllModeCellArray containsObject:[NSNumber numberWithInteger:indexPath.row]])
        cell.isViewAllMode = true;
    else {
        cell.isViewAllMode = false;
    }
    
    [self setTitleForCell:cell item:item];
    
}

- (void)setTitleForCell:(OttaQuestionFeedCell *)cell item:(OttaQuestion *)item {
    NSString *title = item.questionText?: NSLocalizedString(@"[No Title]", nil);
    [cell.questionLbl setText:title];
    [cell.ownerNameLbl setText:@"Brandon Baer"];
    cell.answers = item.ottaAnswers;
}

#pragma mark  tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
    selectedQuestion = [feedItems objectAtIndex:indexPath.row];
    
    if (((OttaAnswer*)[selectedQuestion.ottaAnswers objectAtIndex:0]).imageURL) {
        [self performSegueWithIdentifier:@"segueMediaQuestionDetail" sender:self];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - OttaQuestionFeedCellDelegate

- (void)optionCell:(OttaQuestionFeedCell*)cell viewMoreBtnTapped:(id)row {
    
    [viewAllModeCellArray addObject:row];
}
- (void)optionCell:(OttaQuestionFeedCell*)cell collapseBtnTapped:(id)row {
    [viewAllModeCellArray removeObject:row];
}

- (IBAction)menuButtonPressed:(id)sender {
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}

#pragma mark - prepareForSegue



- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString: @"segueMediaQuestionDetail"]) {
        OttaMediaQuestionDetailViewController *dest = (OttaMediaQuestionDetailViewController *)[segue destinationViewController];
        //the sender is what you pass into the previous method
        dest.question = selectedQuestion;
    }
}



@end
