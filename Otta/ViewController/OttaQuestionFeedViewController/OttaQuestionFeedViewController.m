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
#define kViewAllMode            @"ViewAllModeKey"
#define kSelectedOption         @"SelectedOptionKey"
#define kSubmittedOption        @"SubmittedOptionKey"

@interface OttaQuestionFeedViewController () {
    NSMutableArray *feedItems;
    //NSMutableArray *feedItems1;
    
    PFObject *selectedQuestion;
    NSInteger selectedOption;
    UIRefreshControl *refreshControl;
    
}
@end

@implementation OttaQuestionFeedViewController
@synthesize currentSelectedCell;

static OttaQuestionFeedViewController *sharedInstance;

+ (OttaQuestionFeedViewController*)sharedInstance{
    return sharedInstance;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    sharedInstance = self;
    
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

    CGSize questionSize = [sizingCell.questionLbl systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    //at this time the questionlbl have 1 line and 
    int questionHeigth = (int)(questionSize.width/[[UIScreen mainScreen]bounds].size.width) *questionSize.height;
    
    CGSize tableSize = sizingCell.tableView.contentSize;
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    //NSLog(@"%d - %f  - %f",questionHeigth, size.height, tableSize.height);
    
    if (sizingCell.isViewAllMode) {
        return size.height + tableSize.height + questionHeigth;
    }else{
        return size.height + 30 + questionHeigth;
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
    
    if ([item objectForKey:kViewAllMode]){
        cell.isViewAllMode = YES;
        
        cell.submittedIndexPath = [item objectForKey:kSubmittedOption] ? [NSIndexPath indexPathForRow:[[item objectForKey:kSubmittedOption] integerValue] inSection:0] : nil;
        cell.selectedIndexPath  = [item objectForKey:kSelectedOption]  ? [NSIndexPath indexPathForRow:[[item objectForKey:kSelectedOption] integerValue] inSection:0] : nil;
        
    }else{
        cell.isViewAllMode = NO;
        
        // reset status for cell
        cell.selectedIndexPath = nil;
        cell.submittedIndexPath = nil;
    }
    
    [self setPerformSelectorForCell:cell withItem:item];
    [self setTitleForCell:cell item:item];
}

- (void)setPerformSelectorForCell:(OttaQuestionFeedCell*)cell withItem:(PFObject*)item{
    if (cell.submittedIndexPath) {
        [cell startPerformSelectorForDelete];
    }
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
    PFObject *item = feedItems[idxPath.row];
    [item setObject:@"YES" forKey:kViewAllMode];
    
    NSArray *reloadCellIndexs = [NSArray arrayWithObjects:idxPath, nil];
    [self.tableView reloadRowsAtIndexPaths:reloadCellIndexs withRowAnimation:UITableViewRowAnimationFade];
}
- (void)optionCell:(OttaQuestionFeedCell*)cell collapseBtnTapped:(NSIndexPath*)idxPath {
    PFObject *item = feedItems[idxPath.row];
    [item removeObjectForKey:kViewAllMode];
    
    //[dictViewAllMode removeObjectForKey:[NSString stringWithFormat:@"%ld",idxPath.row]];
    NSArray *reloadCellIndexs = [NSArray arrayWithObjects:idxPath, nil];
    [self.tableView reloadRowsAtIndexPaths:reloadCellIndexs withRowAnimation:UITableViewRowAnimationFade];
}

- (void)optionCell:(OttaQuestionFeedCell *)cell imageBtnTappedAtRow:(NSInteger)row {
    NSIndexPath* pathOfTheCell  = [self.tableView indexPathForCell:cell];
    selectedQuestion            = [feedItems objectAtIndex:pathOfTheCell.row];
    selectedOption              = row;
    PFObject *answer            = [selectedQuestion[kAnswers] objectAtIndex:selectedOption];
    
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
    
    [[OttaParseClientManager sharedManager] voteFromUser:[PFUser currentUser] withQuestion:feedItems[referIdx.row] withAnswer:answer withBlock:^(BOOL isSucceeded, NSError *error) {
        
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
                        PFObject *item = feedItems[referIdx.row];
                        [item setObject:[NSNumber numberWithInteger:childIdxPath.row] forKey:kSubmittedOption];
                        [self performSelector:@selector(processReloadData:) withObject:referIdx afterDelay:0.2f];
                    }
                }];
                
            } completion:^(BOOL finished) {
                if (finished) {
                    //parentCell.viewForSubmit.hidden = NO;
                    //[parentCell.viewForSubmit setTitle:@"Done" forState:UIControlStateNormal];
                }
            }];
        } else {
            NSLog(@"Submit answer failed");
        }
    }];
    
}
- (void)questionFeedCell:(OttaQuestionFeedCell *)parentCell needToForceRemoveAtReferIndex:(NSIndexPath *)indexPath{
    
    currentSelectedCell = nil;
    [((PFObject*)feedItems[indexPath.row]) removeObjectForKey:kSubmittedOption];
    [((PFObject*)feedItems[indexPath.row]) removeObjectForKey:kSelectedOption];
    [((PFObject*)feedItems[indexPath.row]) removeObjectForKey:kViewAllMode];
    
    [feedItems removeObjectAtIndex:indexPath.row];
    
    [self.tableView reloadData];
}

- (void)questionFeedCell:(OttaQuestionFeedCell *)cell DidSelectedRowAtIndexPath:(NSIndexPath *)indexPath withSelectedIndex:(NSIndexPath *)childIdxPath{
    
     NSMutableArray *arrReload = [[NSMutableArray alloc] init];
    // Refresh other cell
    if(currentSelectedCell.row != indexPath.row && currentSelectedCell != nil) {
        [((PFObject*)feedItems[currentSelectedCell.row]) removeObjectForKey:kSelectedOption];
        
        NSIndexPath *oldIndexPathSelected = [NSIndexPath indexPathForRow:currentSelectedCell.row inSection:0];
        [arrReload addObject:oldIndexPathSelected];
    }
    currentSelectedCell = [NSIndexPath indexPathForRow:indexPath.row inSection:0];
    
    
    // Cache to load selected indexpath
    if (childIdxPath==nil) {
        [((PFObject*)feedItems[indexPath.row]) removeObjectForKey:kSelectedOption];
    }else{
        [((PFObject*)feedItems[indexPath.row]) setObject:[NSNumber numberWithInteger:childIdxPath.row] forKey:kSelectedOption];
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
            [feedItems removeAllObjects];
            feedItems = [NSMutableArray arrayWithArray:array];
            for (PFObject *obj in feedItems) {
                [obj removeObjectForKey:kViewAllMode];
                [obj removeObjectForKey:kSelectedOption];
                [obj removeObjectForKey:kSubmittedOption];
            }
        }
        
        [_tableView reloadData];
        _tableView.hidden = NO;
        
        //Stop animating for pull down refresh table
        [refreshControl endRefreshing];
        [[OttaLoadingManager sharedManager] hide];
    }];
}

#pragma mark - Selectors
- (void)processReloadData:(NSIndexPath*)idxPathNeedToDelete{
    [UIView animateWithDuration:0.0 animations:^{
        NSArray *arrReload = [[NSArray alloc] initWithObjects:currentSelectedCell, nil];
        [self.tableView reloadRowsAtIndexPaths:arrReload withRowAnimation:UITableViewRowAnimationFade];
    } completion:^(BOOL finished) {
        if (finished) {
            /*
            OttaQuestionFeedCell* cell = (OttaQuestionFeedCell*)[self.tableView cellForRowAtIndexPath:idxPathNeedToDelete];
            [arrCacheCellForPerformSelector addObject:cell];
            [cell startPerformSelectorForDelete:idxPathNeedToDelete];
             */
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
