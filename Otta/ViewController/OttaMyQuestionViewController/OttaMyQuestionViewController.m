//
//  OttaMyQuestionViewController.m
//  Otta
//
//  Created by Thien Chau on 11/30/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaMyQuestionViewController.h"
#import "UIViewController+ECSlidingViewController.h"

#import "OttaQuestion.h"
#import "OttaAnswer.h"

#import "OttaMyQuestionHeaderCell.h"
#import "OttaMyQuestionFooterCell.h"
#import "OttaMyQuestionTextCell.h"

static NSString * const OttaMyQuestionHeaderCellIdentifier  = @"OttaMyQuestionHeaderCell";
static NSString * const OttaMyQuestionTextCellIdentifier    = @"OttaMyQuestionTextCell";

@interface OttaMyQuestionViewController ()<UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *datas;
}

@end

@implementation OttaMyQuestionViewController
@synthesize myTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    myTableView.dataSource  = self;
    myTableView.delegate    = self;
    
    // Do any additional setup after loading the view.
    [self createDemoData];
    [myTableView reloadData];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
 @property (nonatomic,strong) NSString * questionID;
 @property (nonatomic,strong) NSMutableArray * ottaAnswers;
 @property (nonatomic,strong) NSString * askerID;
 @property (nonatomic,assign) int * expirationDate;
 @property (nonatomic,strong) NSString * questionText;
 */
/*
 @property (nonatomic,strong)UIImage * answerImage;
 @property (nonatomic,strong)NSString * answerText;
 @property (nonatomic,assign) BOOL answerHasContent;
 @property (nonatomic, assign) BOOL answerHasphoto;
 */
- (void)createDemoData{
    datas = [[NSMutableArray alloc] initWithCapacity:5];
    
    int i,j;
    for (i=0; i<3; i++) {
        OttaQuestion *myQs = [[OttaQuestion alloc] init];
        myQs.questionID = [NSString stringWithFormat:@"%d",i];
        myQs.ottaAnswers = [[NSMutableArray alloc] init];
        for (j=0; j<4; j++) {
            OttaAnswer *answer = [[OttaAnswer alloc] init];
            //answer.answerImage = [UIImage imageNamed:@"creme_brelee.jpg"];
            if (j==2) {
                answer.answerText  = [NSString stringWithFormat:@"this is an answer with very long content, may be it will look like this number %d",j];
            }else{
                answer.answerText  = [NSString stringWithFormat:@"answer number %d",j];
            }
            
            answer.answerHasContent = YES;
            answer.answerHasphoto   = NO;
            [myQs.ottaAnswers addObject:answer];
        }
        myQs.askerID = [NSString stringWithFormat:@"162817629"];
        myQs.expirationDate = 5;
        
        if (i==2) {
            myQs.questionText = @"Is it a short question?";
        }else{
            myQs.questionText = @"What food we should to eat tonight, Do you to eat more food without healthy, come to London, right now?";
        }
        
        [datas addObject:myQs];
    }
    
    for (i = 0; i<3; i++) {
        OttaQuestion *myQs = [[OttaQuestion alloc] init];
        myQs.questionID = [NSString stringWithFormat:@"%d",i];
        myQs.ottaAnswers = [[NSMutableArray alloc] init];
        for (j=0; j<4; j++) {
            OttaAnswer *answer = [[OttaAnswer alloc] init];
            answer.answerImage = [UIImage imageNamed:@"creme_brelee.jpg"];
            if (j==2) {
                answer.answerText  = [NSString stringWithFormat:@"this is an answer with very long content, may be it will look like this number %d",j];
            }else{
                answer.answerText  = [NSString stringWithFormat:@"answer number %d",j];
            }
            
            answer.answerHasContent = YES;
            answer.answerHasphoto   = YES;
            [myQs.ottaAnswers addObject:answer];
        }
        myQs.askerID = [NSString stringWithFormat:@"162817629"];
        myQs.expirationDate = 8;
        
        if (i==2) {
            myQs.questionText = @"Is it a short question?";
        }else{
            myQs.questionText = @"What food we should to eat tonight, Do you to eat more food without healthy, come to London, right now?";
        }
        
        [datas addObject:myQs];
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
#pragma mark - action
- (IBAction)pressMenuBtn:(id)sender {
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}
#pragma mark - UITableView Datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return datas.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return ((OttaQuestion*)datas[section]).ottaAnswers.count;
}
//----
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([self isExpiredQuestionAtSection:indexPath.section]) {
        
    }else{
        if ([self isPictureQuestionAtSection:indexPath.section]) {
            
        }else{
            return [self textCellAtIndexPath:indexPath];
        }
    }
    return [self textCellAtIndexPath:indexPath];
}
// For text cell
- (OttaMyQuestionTextCell *)textCellAtIndexPath:(NSIndexPath *)indexPath {
    OttaMyQuestionTextCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:OttaMyQuestionTextCellIdentifier forIndexPath:indexPath];
    [self configureTextCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureTextCell:(OttaMyQuestionTextCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    OttaQuestion *dto = datas[indexPath.section];
    
    OttaAnswer *answerDto = dto.ottaAnswers[indexPath.row];
    
    cell.lblOrderNumber.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    cell.lblText.text = answerDto.answerText;
}
// For Picture Cell
/*
- (OttaMyQuestionTextCell *)textCellAtIndexPath:(NSIndexPath *)indexPath {
    OttaMyQuestionTextCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:OttaMyQuestionTextCellIdentifier forIndexPath:indexPath];
    [self configureTextCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureTextCell:(OttaMyQuestionTextCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    OttaQuestion *dto = datas[indexPath.section];
    
    OttaAnswer *answerDto = dto.ottaAnswers[indexPath.row];
    
    cell.lblOrderNumber.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    cell.lblText.text = answerDto.answerText;
}
 */
//----
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([OttaMyQuestionHeaderCell class])
                                                      owner:self
                                                    options:nil];
    
    OttaMyQuestionHeaderCell* cell = [nibViews objectAtIndex:0];
    [self configureHeaderCell:cell atSection:section];
    return cell;
}
- (void)configureHeaderCell:(OttaMyQuestionHeaderCell *)cell atSection:(NSInteger)section {
    OttaQuestion *dto = datas[section];
    
    cell.lblTextHeader.text = dto.questionText;
    [cell.lblTextHeader sizeToFit];
    CGRect rect = cell.lblTextHeader.bounds;
    cell.frame = rect;
}
- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
   
    NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([OttaMyQuestionFooterCell class])
                                                      owner:self
                                                    options:nil];
    
    OttaMyQuestionFooterCell* cell = [nibViews objectAtIndex:0];
    [self configureFooterCell:cell atSection:section];
    return cell;
}

- (void)configureFooterCell:(OttaMyQuestionFooterCell *)cell atSection:(NSInteger)section {
    OttaQuestion *dto = datas[section];

    cell.lblTime.text = [NSString stringWithFormat:@"%d min",dto.expirationDate];
    cell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.myTableView.frame), CGRectGetHeight(cell.bounds));
}

#pragma mark - UITableview Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // do something
}
//-------
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return [self heightForHeaderCellInSection:section];
}
- (CGFloat)heightForHeaderCellInSection:(NSInteger)section{
    static OttaMyQuestionHeaderCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray* nibViews = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([OttaMyQuestionHeaderCell class])
                                                          owner:self
                                                        options:nil];
        sizingCell = [nibViews objectAtIndex:0];
    });
    
    [self configureHeaderCell:sizingCell atSection:section];
    return [self calculateHeightForConfiguredHeaderSizingCell:sizingCell];
}
- (CGFloat)calculateHeightForConfiguredHeaderSizingCell:(OttaMyQuestionHeaderCell *)sizingCell {
    return sizingCell.bounds.size.height; // Add 1.0f for the cell separator height
}
//-------
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 32;
}
//-------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self heightForTextCellAtIndexPath:indexPath];
}
- (CGFloat)heightForTextCellAtIndexPath:(NSIndexPath *)indexPath {
    static OttaMyQuestionTextCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.myTableView dequeueReusableCellWithIdentifier:OttaMyQuestionTextCellIdentifier];
    });
    
    [self configureTextCell:sizingCell atIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:sizingCell];
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    
    sizingCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.myTableView.frame), CGRectGetHeight(sizingCell.bounds));
    
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height+1; // Add 1.0f for the cell separator height
}
//-------

#pragma mark - Utils
- (BOOL)isPictureQuestionAtSection:(NSInteger)section{
    OttaQuestion *dto = datas[section];
    for (OttaAnswer *as in dto.ottaAnswers) {
        if (as.answerHasphoto == YES) {
            return YES;
        }
    }
    return NO;
}
- (BOOL)isExpiredQuestionAtSection:(NSInteger)section{
    OttaQuestion *dto = datas[section];
    return dto.expirationDate > 0 ? NO : YES;
}
@end
