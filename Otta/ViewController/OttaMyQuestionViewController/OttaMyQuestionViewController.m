//
//  OttaMyQuestionViewController.m
//  Otta
//
//  Created by Linh.Nguyen on 11/30/14.
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
    
    NSMutableArray *dataForShow;
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
    [self processDataForShow];
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
        myQs.isSeeAll = YES;
        if (i==2) {
            myQs.questionText = @"Is it a short question?";
        }else{
            myQs.questionText = @"What food we should to eat tonight, Do you to eat more food without healthy, come to London, right now?";
        }
        
        [datas addObject:myQs];
    }
    /*
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
     */
}
- (void)processDataForShow{
    dataForShow = [[NSMutableArray alloc] initWithCapacity:20];
    
    for (OttaQuestion *myQs in datas) {
        [dataForShow addObject:myQs.questionText];
        if (myQs.isSeeAll) {
            for (OttaAnswer *ans in myQs.ottaAnswers) {
                [dataForShow addObject:ans];
            }
        }else{
            if (myQs.ottaAnswers.count > 0) {
                [dataForShow addObject:myQs.ottaAnswers[0]];
            }
        }
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
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataForShow.count;
}
//----
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    id dto = [dataForShow objectAtIndex:indexPath.row];
    
    if ([dto isKindOfClass:[OttaAnswer class]]) {
        return [self textCellAtIndexPath:indexPath];
    }else if([dto isKindOfClass:[NSString class]]){
        return [self headerCellAtIndexPath:indexPath];
    }else{
        
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
    OttaAnswer *answerDto = dataForShow[indexPath.row];
    
    cell.lblOrderNumber.text = [NSString stringWithFormat:@"%ld",indexPath.row + 1];
    cell.lblText.text = answerDto.answerText;
}
// For Header Cell
- (OttaMyQuestionHeaderCell *)headerCellAtIndexPath:(NSIndexPath *)indexPath {
    OttaMyQuestionHeaderCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:OttaMyQuestionHeaderCellIdentifier forIndexPath:indexPath];
    [self configureHeaderCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureHeaderCell:(OttaMyQuestionHeaderCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    NSString *dto = dataForShow[indexPath.row];
    
    cell.lblTextHeader.text = dto;
}

#pragma mark - UITableview Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // do something
}

//-------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    id dto = [dataForShow objectAtIndex:indexPath.row];
    
    if ([dto isKindOfClass:[OttaAnswer class]]) {
        return [self heightForTextCellAtIndexPath:indexPath];
    }else if([dto isKindOfClass:[NSString class]]){
        return [self heightForHeaderCellAtIndexPath:indexPath];
    }else{
        
    }
    return [self heightForTextCellAtIndexPath:indexPath];
}

// ---------------
- (CGFloat)heightForTextCellAtIndexPath:(NSIndexPath *)indexPath {
    static OttaMyQuestionTextCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.myTableView dequeueReusableCellWithIdentifier:OttaMyQuestionTextCellIdentifier];
    });
    
    [self configureTextCell:sizingCell atIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:sizingCell];
}
- (CGFloat)heightForHeaderCellAtIndexPath:(NSIndexPath *)indexPath {
    static OttaMyQuestionHeaderCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.myTableView dequeueReusableCellWithIdentifier:OttaMyQuestionHeaderCellIdentifier];
    });
    
    [self configureHeaderCell:sizingCell atIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:sizingCell];
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    
    sizingCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.myTableView.frame), CGRectGetHeight(sizingCell.bounds));
    
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height+1; // Add 1.0f for the cell separator height
}

@end
