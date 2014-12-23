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
#import "SideMenuViewController.h"
#import "OttaParseClientManager.h"
#import "MBProgressHUD.h"
#import "Utility.h"

static NSString * const QuestionFeedCellId = @"QuestionFeedCellId";

@interface OttaQuestionFeedViewController () {
    NSMutableArray *feedItems;
    NSMutableArray *feedItems1;
    NSMutableArray *viewAllModeCellArray;
    OttaQuestion *selectedQuestion;
    int selectedOption;
    UIRefreshControl *refreshControl;
    OttaQuestionFeedCell *previousSelectionCell;
}
@end

@implementation OttaQuestionFeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    refreshControl = [[UIRefreshControl alloc]init];
    [_tableView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(loadDataWithoutLoadingIndicator) forControlEvents:UIControlEventValueChanged];
    
    _tableView.hidden = YES;
    [self loadData];
    /*
    ///////////////////////Q1
    OttaQuestion *question = [[OttaQuestion alloc] init];
    question.askerID = @"Jamie Moskowitz";
    question.questionText = @"Test long question, long question test, test long question test?";
    // Do any additional setup after loading the view.
    OttaAnswer* answer = [[OttaAnswer alloc] init];
    answer.answerText = @"Caesar Blah Caesar Blah Caesar  Blah Caesar Caesar Blah Caesar Blah Caesar  Blah Caesar";
    answer.answerImage = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];
    answer.imageURL = @"https://farm6.static.flickr.com/5616/15430646499_05b8c2ec7f_m.jpg";
    
    OttaAnswer* answer1 = [[OttaAnswer alloc] init];
    answer1.answerText = @"Thousand Islands";
    answer1.answerImage = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];
    answer1.imageURL = @"https://farm6.static.flickr.com/5552/15290350306_b17264e923_m.jpg";
    
    OttaAnswer* answer2 = [[OttaAnswer alloc] init];
    answer2.answerText = @"Strawberry Something";
    answer2.answerImage = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];
    answer2.imageURL = @"https://farm4.static.flickr.com/3936/15617350755_ecaab550f0_m.jpg";
    
    OttaAnswer* answer3 = [[OttaAnswer alloc] init];
    answer3.answerText = @"Japanese noddle with pork";
    answer3.answerImage = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];
    answer3.imageURL = @"https://farm4.static.flickr.com/3851/15290348416_23e10b0ecb_m.jpg";
   
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
    answer.imageURL = @"https://farm6.static.flickr.com/5616/15430646499_05b8c2ec7f_m.jpg";
    
    answer1 = [[OttaAnswer alloc] init];
    answer1.answerText = @"Thousand Islands";
    answer1.answerImage = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];
    answer1.imageURL = @"https://farm6.static.flickr.com/5552/15290350306_b17264e923_m.jpg";
    
    answer2 = [[OttaAnswer alloc] init];
    answer2.answerText = @"Strawberry Something";
    answer2.answerImage = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];
    answer2.imageURL = @"https://farm4.static.flickr.com/3936/15617350755_ecaab550f0_m.jpg";
    
    answer3 = [[OttaAnswer alloc] init];
    answer3.answerText = @"Japanese noddle with pork";
    answer3.answerImage = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];
    answer3.imageURL = @"https://farm4.static.flickr.com/3851/15290348416_23e10b0ecb_m.jpg";
    

    
    
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
     */
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
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
    
    if (sizingCell.selectedIndexPath) {
        return size.height + sizingCell.tableView.contentSize.height + questionSize.height;
    }else{
        return size.height + sizingCell.tableView.contentSize.height + questionSize.height - 20.0;
    }
    
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
    [cell.ownerNameLbl setText:item.askerName];
    [cell.timeLbl setText:[Utility timeAgo:item.expTime]];
    cell.answers = item.ottaAnswers;
}

#pragma mark  tableview delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:TRUE];
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

- (void)optionCell:(OttaQuestionFeedCell *)cell imageBtnTappedAtRow:(id)row {
    NSIndexPath* pathOfTheCell = [self.tableView indexPathForCell:cell];
    selectedQuestion = [feedItems objectAtIndex:pathOfTheCell.row];
    selectedOption = [(NSNumber*)row intValue];
    PFObject *answer = [selectedQuestion.ottaAnswers objectAtIndex:selectedOption];
    
    if (((PFFile*)answer[kImage]).url.length > 0) {
        [self performSegueWithIdentifier:@"segueMediaQuestionDetail" sender:cell];
    }

}
- (void)questionFeedCell:(OttaQuestionFeedCell*)parentCell optionCell:(OttaBasicQuestionCell *)cell withReferIndexPath:(NSIndexPath *)referIdx didSubmitRowAtIndexPath:(NSIndexPath *)childIdxPath withMaximumCount:(NSInteger)maxCount{
    
    if([OttaNetworkManager isOfflineShowedAlertView]) {
        return;
    }
    
    // For submit Cell
    OttaQuestion *item = feedItems[referIdx.row];
    PFObject *answer = [item.ottaAnswers objectAtIndex:childIdxPath.row];
    NSLog(@"submit cell %@",item.questionText);
    NSLog(@"anser %@",answer[kDescription]);
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[OttaParseClientManager sharedManager] voteFromUser:[PFUser currentUser] withQuestion:feedItems1[referIdx.row] withAnswer:answer withBlock:^(BOOL isSucceeded, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        if(isSucceeded) {
            NSLog(@"Submit answer success");
            //cell.orderLbl.backgroundColor = kDefaultColorBackGround;
            // Remove the other Rows
            [UIView animateWithDuration:1.0 animations:^{
                NSMutableArray *arrIndexPathForRemove = [[NSMutableArray alloc] init];
                for (NSInteger i = item.ottaAnswers.count-1; i >= 0; i--) {
                    if (i != childIdxPath.row) {
                        if (i < maxCount) {
                            NSIndexPath *tmpIdxPath = [NSIndexPath indexPathForRow:i inSection:0];
                            [arrIndexPathForRemove addObject:tmpIdxPath];
                        }
                        [item.ottaAnswers removeObjectAtIndex:i];
                    }
                }
                
                [parentCell.tableView deleteRowsAtIndexPaths:arrIndexPathForRemove withRowAnimation:UITableViewRowAnimationFade];
                
                [self performSelector:@selector(processReloadData:) withObject:parentCell afterDelay:0.2f];
                
            } completion:^(BOOL finished) {
                if (finished) {
                    parentCell.viewForSubmit.hidden = NO;
                    [parentCell.viewForSubmit setTitle:@"Done" forState:UIControlStateNormal];
                }
            }];
        
        } else {
            NSLog(@"Submit answer failed");
        }
    }];
}
- (void)questionFeedCell:(OttaQuestionFeedCell *)parentCell needToForceRemoveAtReferIndex:(NSIndexPath *)indexPath{
    [feedItems removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
}

- (void)questionFeedCell:(OttaQuestionFeedCell *)cell DidSelectedRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSArray *arrReload = [[NSArray alloc] initWithObjects:indexPath, nil];
    //[self.tableView reloadRowsAtIndexPaths:arrReload withRowAnimation:UITableViewRowAnimationFade];
    
    if(previousSelectionCell != cell) {
        [previousSelectionCell deselectCell];
    }
    previousSelectionCell = cell;
    
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
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
        dest.currentOption = selectedOption;
        dest.selectedCell = sender;
    }
}

#pragma mark - Actions
- (IBAction)pressBtnLogo:(id)sender{
    [[SideMenuViewController sharedInstance] selectRowAtIndex:[NSIndexPath indexPathForRow:0 inSection:0] forViewController:self];
}

- (void) loadData{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [self loadDataWithoutLoadingIndicator];
}

-(void) loadDataWithoutLoadingIndicator
{
    if([OttaNetworkManager isOfflineShowedAlertView]) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        return;
    }
    
    [[OttaParseClientManager sharedManager] getQuestionFeedFromUser:[PFUser currentUser] withBlock:^(NSArray *array, NSError *error) {
        
        if(array) {
            viewAllModeCellArray = [[NSMutableArray alloc] init];
            feedItems = [[NSMutableArray alloc] init];
            feedItems1 = [NSMutableArray arrayWithArray:array];
        }
        
        for (PFObject *object in array) {
            OttaQuestion *question = [[OttaQuestion alloc] init];
            PFUser *asker = object[kAsker];
            question.askerID = object.objectId;
            question.askerName = [NSString stringWithFormat:@"%@ %@",asker.firstName, asker.lastName];
            question.questionText = object[kQuestionText];
            question.expTime = object[kExpTime];
            question.ottaAnswers = [[NSMutableArray alloc] init];
            if(object[kAnswers]){
                [question.ottaAnswers addObjectsFromArray:object[kAnswers]];
            }
            
            [feedItems addObject:question];
            [_tableView reloadData];
            _tableView.hidden = NO;
        }
        
        //Stop animating for pull down refresh table
        [refreshControl endRefreshing];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

#pragma mark - Selectors
- (void)processReloadData:(OttaQuestionFeedCell*)cell{
    
    [UIView animateWithDuration:1.0 animations:^{
        [self.tableView reloadData];
    } completion:^(BOOL finished) {
        if (finished) {
            [cell startPerformSelectorForDelete];
        }
    }];
    
}

#pragma mark - Media Detail Delegate
-(void) didSelectOptionIndex:(int)index forCell:(OttaQuestionFeedCell*)currentCell
{
    if(previousSelectionCell != currentCell) {
        [previousSelectionCell deselectCell];
    }
    previousSelectionCell = currentCell;
    
}
@end
