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

static NSString * const QuestionFeedCellId = @"QuestionFeedCellId";

@interface OttaQuestionFeedViewController () {
    NSMutableArray *feedItems;
    NSMutableArray *feedItems1;
    
    PFObject *selectedQuestion;
    int selectedOption;
    UIRefreshControl *refreshControl;
    NSIndexPath *currentSelectedCell;
    
    NSMutableDictionary *dictViewAllMode;
    NSMutableDictionary *dictSelectedMode;
    NSMutableDictionary *dictSubmitedMode;
    
}
@end

@implementation OttaQuestionFeedViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    dictViewAllMode      = [[NSMutableDictionary alloc] init];
    dictSelectedMode     = [[NSMutableDictionary alloc] init];
    dictSubmitedMode     = [[NSMutableDictionary alloc] init];
    
    refreshControl = [[UIRefreshControl alloc]init];
    [_tableView addSubview:refreshControl];
    [refreshControl addTarget:self action:@selector(loadDataWithoutLoadingIndicator) forControlEvents:UIControlEventValueChanged];
    
    _tableView.hidden = YES;
    [self loadData];
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

- (CGFloat)calculateHeightForConfiguredSizingCell:(OttaQuestionFeedCell *)sizingCell{
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];

    //CGSize questionSize = [sizingCell.questionLbl systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    CGSize tableSize = sizingCell.tableView.contentSize;
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    NSLog(@"%f - %f  - %f",sizingCell.questionLbl.bounds.size.height, size.height, tableSize.height);
    
    if (sizingCell.isViewAllMode) {
        return size.height + tableSize.height;
    }else{
        return size.height + 30;
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
    PFObject *item = feedItems[indexPath.row];
    
    if ([dictViewAllMode objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]]){
        if (indexPath.row == ((NSIndexPath*)[dictViewAllMode objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]]).row) {
            cell.isViewAllMode = YES;
            
            // for selected cell
            if ([dictSelectedMode objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]]) {
                NSIndexPath *selectedRow = [dictSelectedMode objectForKey:[NSString stringWithFormat:@"%ld", indexPath.row]];
                cell.selectedIndexPath = selectedRow;
                
                //check if submited
                if ([dictSubmitedMode objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]]) {
                    NSIndexPath *childIdxSubmited = [dictSubmitedMode objectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]];
                    cell.submittedIndexPath = childIdxSubmited;
                }
            }else{
                cell.selectedIndexPath = nil;
            }
        }
    }else{
        cell.isViewAllMode = NO;
        
        // reset status for cell
        cell.selectedIndexPath = nil;
    }
    
    [self setTitleForCell:cell item:item];
}

- (void)setTitleForCell:(OttaQuestionFeedCell *)cell item:(PFObject *)item {
    PFUser *asker = item[kAsker];
    NSString *title = item[kQuestionText] ?: NSLocalizedString(@"[No Title]", nil);
    [cell.questionLbl setText:title];
    [cell.ownerNameLbl setText:[NSString stringWithFormat:@"%@ %@",asker.firstName, asker.lastName]];
    [cell.timeLbl setText:[OttaUlti timeAgo:item[kExpTime]]];
    cell.delegate = self;
    cell.answers = [NSMutableArray arrayWithArray:item[kAnswers]];
}

#pragma mark  Tableview Delegate
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
#pragma mark - OttaQuestionFeedCell Delegate
- (void)optionCell:(OttaQuestionFeedCell*)cell viewMoreBtnTapped:(NSIndexPath*)idxPath{
    
    [dictViewAllMode setValue:idxPath forKey:[NSString stringWithFormat:@"%ld",idxPath.row]];
    
    NSArray *reloadCellIndexs = [NSArray arrayWithObjects:idxPath, nil];
    [self.tableView reloadRowsAtIndexPaths:reloadCellIndexs withRowAnimation:UITableViewRowAnimationFade];
}
- (void)optionCell:(OttaQuestionFeedCell*)cell collapseBtnTapped:(NSIndexPath*)idxPath {
    [dictViewAllMode removeObjectForKey:[NSString stringWithFormat:@"%ld",idxPath.row]];
    
    NSArray *reloadCellIndexs = [NSArray arrayWithObjects:idxPath, nil];
    [self.tableView reloadRowsAtIndexPaths:reloadCellIndexs withRowAnimation:UITableViewRowAnimationFade];
}

- (void)optionCell:(OttaQuestionFeedCell *)cell imageBtnTappedAtRow:(id)row {
    NSIndexPath* pathOfTheCell = [self.tableView indexPathForCell:cell];
    selectedQuestion = [feedItems objectAtIndex:pathOfTheCell.row];
    selectedOption = [(NSNumber*)row intValue];
    PFObject *answer = [selectedQuestion[kAnswers] objectAtIndex:selectedOption];
    
    if (((PFFile*)answer[kImage]).url.length > 0) {
        [self performSegueWithIdentifier:@"segueMediaQuestionDetail" sender:cell];
    }
    
}
- (void)questionFeedCell:(OttaQuestionFeedCell*)parentCell optionCell:(OttaBasicQuestionCell *)cell withReferIndexPath:(NSIndexPath *)referIdx didSubmitRowAtIndexPath:(NSIndexPath *)childIdxPath withMaximumCount:(NSInteger)maxCount{
    
    if([OttaNetworkManager isOfflineShowedAlertView]) {
        return;
    }
    // For submit Cell
    PFObject *question = feedItems[referIdx.row];
    NSMutableArray *arrAnswers = [NSMutableArray arrayWithArray:question[kAnswers]];
    PFObject *answer = [arrAnswers objectAtIndex:childIdxPath.row];
    [[OttaLoadingManager sharedManager] show];
    
    [[OttaParseClientManager sharedManager] voteFromUser:[PFUser currentUser] withQuestion:feedItems1[referIdx.row] withAnswer:answer withBlock:^(BOOL isSucceeded, NSError *error) {
        
        [[OttaLoadingManager sharedManager] hide];
        if(isSucceeded) {
            NSLog(@"Submit answer success");
            //cell.orderLbl.backgroundColor = kDefaultColorBackGround;
            // Remove the other Rows
            [UIView animateWithDuration:1.0 animations:^{
                NSMutableArray *arrIndexPathForRemove = [[NSMutableArray alloc] init];
                for (NSInteger i = arrAnswers.count-1; i >= 0; i--) {
                    
                    if (i != childIdxPath.row) {
                        if (i < maxCount) {
                            NSIndexPath *tmpIdxPath = [NSIndexPath indexPathForRow:i inSection:0];
                            [arrIndexPathForRemove addObject:tmpIdxPath];
                        }
                        [parentCell.answers removeObjectAtIndex:i];
                    }
                }
                [UIView animateWithDuration:0.0 animations:^{
                    [parentCell.tableView deleteRowsAtIndexPaths:arrIndexPathForRemove withRowAnimation:UITableViewRowAnimationFade];
                } completion:^(BOOL finished) {
                    if (finished) {
                        [dictSubmitedMode setValue:childIdxPath forKey:[NSString stringWithFormat:@"%ld",referIdx.row]];
                        [self performSelector:@selector(processReloadData:) withObject:parentCell afterDelay:0.2f];
                    }
                }];
                
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
    /*
    dictSubmitedMode    = [[NSMutableDictionary alloc] init];
    dictViewAllMode     = [[NSMutableDictionary alloc] init];
    dictSelectedMode    = [[NSMutableDictionary alloc] init];
    
    currentSelectedCell = nil;
    
    parentCell.isViewAllMode = NO;
    parentCell.selectedIndexPath = nil;
    parentCell.submittedIndexPath = nil;
    
    [feedItems removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
     */
    OttaQuestionFeedCell *cell = (OttaQuestionFeedCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    cell = nil;
    [self loadData];
}

- (void)questionFeedCell:(OttaQuestionFeedCell *)cell DidSelectedRowAtIndexPath:(NSIndexPath *)indexPath withSelectedIndex:(NSIndexPath *)childIdxPath{
    
     NSMutableArray *arrReload = [[NSMutableArray alloc] init];
    // Refresh other cell
    
    if(currentSelectedCell.row != indexPath.row && currentSelectedCell != nil) {
        [dictSelectedMode removeObjectForKey:[NSString stringWithFormat:@"%ld",currentSelectedCell.row]];
        
        NSIndexPath *oldIndexPathSelected = [NSIndexPath indexPathForRow:currentSelectedCell.row inSection:0];
        [arrReload addObject:oldIndexPathSelected];
    }
    currentSelectedCell = indexPath;
    
    
    // Cache to load selected indexpath
    if (childIdxPath==nil) {
        [dictSelectedMode removeObjectForKey:[NSString stringWithFormat:@"%ld",indexPath.row]];
    }else{
        [dictSelectedMode setValue:childIdxPath forKey:[NSString stringWithFormat:@"%ld",indexPath.row]];
    }
    
    [arrReload addObject:indexPath];
    [self.tableView reloadRowsAtIndexPaths:arrReload withRowAnimation:UITableViewRowAnimationFade];
    /*
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
     */
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
    [[OttaLoadingManager sharedManager] show];
    [self loadDataWithoutLoadingIndicator];
}

-(void) loadDataWithoutLoadingIndicator
{
    if([OttaNetworkManager isOfflineShowedAlertView]) {
        [[OttaLoadingManager sharedManager] hide];
        return;
    }
    
    [[OttaParseClientManager sharedManager] getQuestionFeedFromUser:[PFUser currentUser] withBlock:^(NSArray *array, NSError *error) {
        
        if(array) {
            feedItems = [NSMutableArray arrayWithArray:array];
            feedItems1 = [NSMutableArray arrayWithArray:array];
            
            dictViewAllMode     = [[NSMutableDictionary alloc] init];
            dictSelectedMode    = [[NSMutableDictionary alloc] init];
            dictSubmitedMode    = [[NSMutableDictionary alloc] init];
        }
        
        [_tableView reloadData];
        _tableView.hidden = NO;
        
        //Stop animating for pull down refresh table
        [refreshControl endRefreshing];
        [[OttaLoadingManager sharedManager] hide];
    }];
}

#pragma mark - Selectors
- (void)processReloadData:(OttaQuestionFeedCell*)cell{
    [UIView animateWithDuration:0.0 animations:^{
        NSArray *arrReload = [[NSArray alloc] initWithObjects:currentSelectedCell, nil];
        [self.tableView reloadRowsAtIndexPaths:arrReload withRowAnimation:UITableViewRowAnimationFade];
    } completion:^(BOOL finished) {
        if (finished) {
            [cell startPerformSelectorForDelete];
        }
    }];
}

#pragma mark - Media Detail Delegate
-(void) didSelectOptionIndex:(int)index forCell:(OttaQuestionFeedCell*)currentCell
{
    /*
    if(currentSelectedCell != currentCell) {
        [currentSelectedCell deselectCell];
    }
    currentSelectedCell = currentCell;
     */
}
@end
