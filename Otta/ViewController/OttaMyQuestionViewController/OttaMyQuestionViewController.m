//
//  OttaMyQuestionViewController.m
//  Otta
//
//  Created by Thien Chau on 11/30/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaMyQuestionViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "SideMenuViewController.h"

#import "OttaQuestion.h"
#import "OttaAnswer.h"
#import "OttaUser.h"
#import "OttaMyQuestionData.h"

#import "OttaMyQuestionHeaderCell.h"
#import "OttaMyQuestionFooterCell.h"
#import "OttaMyQuestionTextCell.h"
#import "OttaMyQuestionPictureCell.h"
#import "OttaMyQuestionDoneCell.h"
#import "OttaMyQuestionVoteCell.h"

#import "OttaParseClientManager.h"
#import "MBProgressHUD.h"

static NSString * const OttaMyQuestionHeaderCellIdentifier      = @"OttaMyQuestionHeaderCell";
static NSString * const OttaMyQuestionTextCellIdentifier        = @"OttaMyQuestionTextCell";
static NSString * const OttaMyQuestionFooterCellIdentifier      = @"OttaMyQuestionFooterCell";
static NSString * const OttaMyQuestionPictureCellIdentifier     = @"OttaMyQuestionPictureCell";
static NSString * const OttaMyQuestionDoneCellIdentifier        = @"OttaMyQuestionDoneCell";
static NSString * const OttaMyQuestionVoteCellIdentifier        = @"OttaMyQuestionVoteCell";

#define kDefaultColorBackGround [UIColor colorWithRed:143*1.0/255 green:202*1.0/255 blue:64*1.0/255 alpha:1.0f]

@interface OttaMyQuestionViewController ()<UITableViewDataSource, UITableViewDelegate, OttaMyQuestionFooterCellDelegate>{
    NSMutableArray *datas;
    
    NSMutableArray *dataForShow;
    NSMutableDictionary *dictVoteData;
}

@end

@implementation OttaMyQuestionViewController
@synthesize myTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    myTableView.dataSource  = self;
    myTableView.delegate    = self;
    
    // Do any additional setup after loading the view.
    //[self createDemoData];
    //[self processDataForShow];
    //[self createVoteData];
    //[myTableView reloadData];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/*
- (void)createVoteData{
    dictVoteData = [[NSMutableDictionary alloc] initWithCapacity:10];
    for (NSInteger i=0; i < dataForShow.count; i++) {
        NSMutableArray *data = [[NSMutableArray alloc] init];
        
        OttaUser *user1 = [[OttaUser alloc] init];
        user1.firstName = @"Hao";
        user1.lastName  = @"Tran";
        [data addObject:user1];
        
        OttaUser *user2 = [OttaUser new];
        user2.firstName = @"Linh";
        user2.lastName = @"Nguyen";
        [data addObject:user2];
        
        OttaUser *user3 = [OttaUser new];
        user3.firstName = @"Thien";
        user3.lastName = @"Chau";
        [data addObject:user3];
        
        OttaUser *user4 = [OttaUser new];
        user4.firstName = @"Dong";
        user4.lastName = @"Nguyen";
        [data addObject:user4];
        
        OttaUser *user5 = [OttaUser new];
        user5.firstName = @"Phuc";
        user5.lastName = @"Nguyen";
        [data addObject:user5];
        
        OttaMyQuestionData *dto = dataForShow[i];
        if (dto.dataType == MyQuestionDataTypeAnswer ||dto.dataType == MyQuestionDataTypeAnswerPicture) {
            [dictVoteData setValue:data forKey:[NSString stringWithFormat:@"%.0ld",i]];
        }
    }
}
- (void)createDemoData{
    datas = [[NSMutableArray alloc] initWithCapacity:5];
    
    int i,j;
    for (i = 0; i<3; i++) {
        OttaQuestion *myQs = [[OttaQuestion alloc] init];
        myQs.questionID = [NSString stringWithFormat:@"%d",i];
        myQs.ottaAnswers = [[NSMutableArray alloc] init];
        for (j=0; j<4; j++) {
            OttaAnswer *answer = [[OttaAnswer alloc] init];
            answer.answerImage = [UIImage imageNamed:@"creme_brelee.jpg"];
            if (j==2) {
                answer.answerText  = [NSString stringWithFormat:@"this is an answer with very long content, may be it will look like this number - %d",j];
            }else if(j==3){
                answer.answerText  = [NSString stringWithFormat:@"this is an answer with very long content, may be it will look like this number, this is an answer with very long content, may be it will look like this number - %d",j];
            }else{
                answer.answerText  = [NSString stringWithFormat:@"answer number - %d",j];
            }
            
            answer.answerHasContent = YES;
            answer.answerHasphoto   = YES;
            [myQs.ottaAnswers addObject:answer];
        }
        myQs.askerID = [NSString stringWithFormat:@"162817629"];
        myQs.expirationDate = 8;
        myQs.isSeeAll = NO;
        if (i==2) {
            myQs.questionText = @"Is it a short question?";
        }else{
            myQs.questionText = @"What food we should to eat tonight, Do you to eat more food without healthy, come to London, right now?";
        }
        
        [datas addObject:myQs];
    }
    for (i=0; i<2; i++) {
        OttaQuestion *myQs = [[OttaQuestion alloc] init];
        myQs.questionID = [NSString stringWithFormat:@"%d",i];
        myQs.ottaAnswers = [[NSMutableArray alloc] init];
        for (j=0; j<4; j++) {
            OttaAnswer *answer = [[OttaAnswer alloc] init];
            //answer.answerImage = [UIImage imageNamed:@"creme_brelee.jpg"];
            if (j==2) {
                answer.answerText  = [NSString stringWithFormat:@"this is an answer with very long content, may be it will look like this number - %d",j];
            }else{
                answer.answerText  = [NSString stringWithFormat:@"answer number - %d",j];
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

    // For done cell with picture
    for (i = 0; i<2; i++) {
        OttaQuestion *myQs = [[OttaQuestion alloc] init];
        myQs.questionID = [NSString stringWithFormat:@"%d",i];
        myQs.ottaAnswers = [[NSMutableArray alloc] init];
        for (j=0; j<4; j++) {
            OttaAnswer *answer = [[OttaAnswer alloc] init];
            answer.answerImage = [UIImage imageNamed:@"creme_brelee.jpg"];
            if (j==2) {
                answer.answerText  = [NSString stringWithFormat:@"this is an answer with very long content, may be it will look like this number - %d",j];
            }else if(j==3){
                answer.answerText  = [NSString stringWithFormat:@"this is an answer with very long content, may be it will look like this number, this is an answer with very long content, may be it will look like this number - %d",j];
            }else{
                answer.answerText  = [NSString stringWithFormat:@"answer number - %d",j];
            }
            
            answer.answerHasContent = YES;
            answer.answerHasphoto   = YES;
            [myQs.ottaAnswers addObject:answer];
        }
        myQs.askerID = [NSString stringWithFormat:@"162817629"];
        myQs.expirationDate = 0;
        myQs.isSeeAll = NO;
        if (i==1) {
            myQs.questionText = @"Is it a short question?";
        }else{
            myQs.questionText = @"What food we should to eat tonight, Do you to eat more food without healthy, come to London, right now?";
        }
        
        [datas addObject:myQs];
    }
    // For done cell with Text
    for (i=0; i<2; i++) {
        OttaQuestion *myQs = [[OttaQuestion alloc] init];
        myQs.questionID = [NSString stringWithFormat:@"%d",i];
        myQs.ottaAnswers = [[NSMutableArray alloc] init];
        for (j=0; j<4; j++) {
            OttaAnswer *answer = [[OttaAnswer alloc] init];
           
            if (j==2) {
                answer.answerText  = [NSString stringWithFormat:@"this is an answer with very long content, may be it will look like this number - %d",j];
            }else{
                answer.answerText  = [NSString stringWithFormat:@"answer number - %d",j];
            }
            
            answer.answerHasContent = YES;
            answer.answerHasphoto   = NO;
            [myQs.ottaAnswers addObject:answer];
        }
        myQs.askerID = [NSString stringWithFormat:@"162817629"];
        myQs.expirationDate = 0;
        myQs.isSeeAll = NO;
        if (i==1) {
            myQs.questionText = @"Is it a short question?";
        }else{
            myQs.questionText = @"What food we should to eat tonight, Do you to eat more food without healthy, come to London, right now?";
        }
        
        [datas addObject:myQs];
    }
}
 */
- (void)processDataForShow{
    dataForShow = [[NSMutableArray alloc] initWithCapacity:[datas count]];
    
    for (int i=0;i<datas.count;i++) {
        OttaQuestion *qs = datas[i];
        OttaMyQuestionData *obj = [[OttaMyQuestionData alloc] init];
        NSDate * now = [NSDate date];
        if([now compare:qs.expTime] == NSOrderedDescending) {
        //if (qs.expirationDate <= 0) {
            obj.dataType = MyQuestionDataTypeDone;
            obj.questionText = qs.questionText;
            obj.isShowedOptionDone = NO;
            obj.referIndex = i;
            [dataForShow addObject:obj];
        }else{
            obj.dataType = MyQuestionDataTypeHeader;
            obj.questionText = qs.questionText;
            [dataForShow addObject:obj];
            
            int numberLocation = 1;
            if (qs.isSeeAll) {
                BOOL flagHasPhoTo = NO;
                for (OttaAnswer *ans in qs.ottaAnswers) {
                    OttaMyQuestionData *objAnswer1 = [[OttaMyQuestionData alloc] init];
                    ans.numberAnswer = numberLocation;
                    if (ans.answerHasphoto) {
                        objAnswer1.dataType = MyQuestionDataTypeAnswerPicture;
                        flagHasPhoTo = YES;
                    }else{
                        objAnswer1.dataType = MyQuestionDataTypeAnswer;
                    }
                    objAnswer1.answer = ans;
                    [dataForShow addObject:objAnswer1];
                    
                    numberLocation++;
                }
                
                OttaMyQuestionData *objFooter1 = [[OttaMyQuestionData alloc] init];
                objFooter1.dataType = flagHasPhoTo ? MyQuestionDataTypeFooterCollapse:MyQuestionDataTypeFooterNormal;
                //objFooter1.expirationDate = qs.expirationDate;
                objFooter1.expTime = qs.expTime;
                objFooter1.referIndex = i;
                objFooter1.currentTableIndex = dataForShow.count;
                [dataForShow addObject:objFooter1];
                
            }else{
                if (qs.ottaAnswers.count > 0) {
                    OttaMyQuestionData *objAnswer2 = [[OttaMyQuestionData alloc] init];
                    ((OttaAnswer*)qs.ottaAnswers[0]).numberAnswer = numberLocation;
                    objAnswer2.dataType = MyQuestionDataTypeAnswerPicture;
                    objAnswer2.answer = qs.ottaAnswers[0];
                    
                    [dataForShow addObject:objAnswer2];
                    
                    OttaMyQuestionData *objFooter2 = [[OttaMyQuestionData alloc] init];
                    objFooter2.dataType = MyQuestionDataTypeFooterSeeAll;
                    //objFooter2.expirationDate = qs.expirationDate;
                    objFooter2.expTime = qs.expTime;
                    objFooter2.referIndex = i;
                    objFooter2.currentTableIndex = dataForShow.count;
                    [dataForShow addObject:objFooter2];
                }
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
- (IBAction)pressBtnLogo:(id)sender{
    
    [[SideMenuViewController sharedInstance] selectRowAtIndex:[NSIndexPath indexPathForRow:0 inSection:0] forViewController:self];
    
    //[[SideMenuViewController sharedInstance] tableView:[SideMenuViewController sharedInstance].menuTableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
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
    OttaMyQuestionData *dto = [dataForShow objectAtIndex:indexPath.row];
    
    switch (dto.dataType) {
        case MyQuestionDataTypeHeader:
            return [self headerCellAtIndexPath:indexPath];
            break;
        case MyQuestionDataTypeAnswer:
            return [self textCellAtIndexPath:indexPath];
            break;
        case MyQuestionDataTypeFooterNormal:
            return [self footerCellAtIndexPath:indexPath];
            break;
        case MyQuestionDataTypeAnswerPicture:
            return [self pictureCellAtIndexPath:indexPath];
            break;
        case MyQuestionDataTypeFooterSeeAll:
            return [self footerCellAtIndexPath:indexPath];
            break;
        case MyQuestionDataTypeFooterCollapse:
            return [self footerCellAtIndexPath:indexPath];
            break;
        case MyQuestionDataTypeDone:
            return [self doneCellAtIndexPath:indexPath];;
            break;
        case MyQuestionDataTypeVote:
            return [self voteCellAtIndexPath:indexPath];;
            break;
        default:
            break;
    }
    
    return nil;
}

#pragma mark - UITableview Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row >= dataForShow.count)
        return;
    // do something
    //Change the selected background view of the cell.
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row >= dataForShow.count)
        return;
    
    OttaMyQuestionData* dto = [dataForShow objectAtIndex:indexPath.row];
    
    switch (dto.dataType) {
        case MyQuestionDataTypeHeader:
            //[self fixFrameForHeaderCell:(OttaMyQuestionHeaderCell*)cell];
            break;
        case MyQuestionDataTypeAnswer:
            if (!dto.disableSelecting) {
                [self processVoteDataForRowAtIndex:indexPath];
            }
            break;
        case MyQuestionDataTypeFooterNormal:
            break;
        case MyQuestionDataTypeAnswerPicture:
            if (!dto.disableSelecting) {
                [self processVoteDataForRowAtIndex:indexPath];
            }
            break;
        case MyQuestionDataTypeFooterSeeAll:
            break;
        case MyQuestionDataTypeFooterCollapse:
            break;
        case MyQuestionDataTypeDone:
            [self processOptionDoneQuestionForRowAtIndex:indexPath];
            break;
        default:
            break;
    }
    
}
- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row >= dataForShow.count)
        return;
    
    OttaMyQuestionData* dto = [dataForShow objectAtIndex:indexPath.row];
    
    switch (dto.dataType) {
        case MyQuestionDataTypeHeader:
            [self fixFrameForHeaderCell:(OttaMyQuestionHeaderCell*)cell];
            break;
        case MyQuestionDataTypeAnswer:
            break;
        case MyQuestionDataTypeFooterNormal:
            break;
        case MyQuestionDataTypeAnswerPicture:
            break;
        case MyQuestionDataTypeFooterSeeAll:
            break;
        case MyQuestionDataTypeFooterCollapse:
            break;
        case MyQuestionDataTypeDone:
            [self fixFrameForDoneCell:(OttaMyQuestionDoneCell*)cell];
            break;
        default:
            break;
    }
}
/*
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    OttaMyQuestionData* dto = [dataForShow objectAtIndex:indexPath.row];
    
    switch (dto.dataType) {
        case MyQuestionDataTypeHeader:
            [self fixFrameForHeaderCell:(OttaMyQuestionHeaderCell*)cell];
            break;
        case MyQuestionDataTypeAnswer:
            break;
        case MyQuestionDataTypeFooterNormal:
            break;
        case MyQuestionDataTypeAnswerPicture:
            break;
        case MyQuestionDataTypeFooterSeeAll:
            break;
        case MyQuestionDataTypeDone:
            [self fixFrameForDoneCell:(OttaMyQuestionDoneCell*)cell];
            break;
        default:
            break;
    }
}
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row >= dataForShow.count)
        return 0;
    
    OttaMyQuestionData* dto = [dataForShow objectAtIndex:indexPath.row];

    switch (dto.dataType) {
        case MyQuestionDataTypeHeader:
            return [self heightForHeaderCellAtIndexPath:indexPath];
            break;
        case MyQuestionDataTypeAnswer:
            return [self heightForTextCellAtIndexPath:indexPath];
            break;
        case MyQuestionDataTypeFooterNormal:
            return [self heightForFooterCellAtIndexPath:indexPath];
            break;
        case MyQuestionDataTypeAnswerPicture:
            return [self heightForPictureCellAtIndexPath:indexPath];
            break;
        case MyQuestionDataTypeFooterSeeAll:
            return [self heightForFooterCellAtIndexPath:indexPath];
            break;
        case MyQuestionDataTypeFooterCollapse:
            return [self heightForFooterCellAtIndexPath:indexPath];
            break;
        case MyQuestionDataTypeDone:
            return [self heightForDoneCellAtIndexPath:indexPath];
            break;
        case MyQuestionDataTypeVote:
            return 80.0;
            break;
        default:
            break;
    }
    
    return 0.0;
}

#pragma mark - Calculator Height of Cells
// For Header Cell
- (CGFloat)heightForHeaderCellAtIndexPath:(NSIndexPath *)indexPath {
    static OttaMyQuestionHeaderCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.myTableView dequeueReusableCellWithIdentifier:OttaMyQuestionHeaderCellIdentifier];
    });
    
    [self configureHeaderCell:sizingCell atIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:sizingCell];
}

// For Text Cell
- (CGFloat)heightForTextCellAtIndexPath:(NSIndexPath *)indexPath {
    static OttaMyQuestionTextCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.myTableView dequeueReusableCellWithIdentifier:OttaMyQuestionTextCellIdentifier];
    });
    
    [self configureTextCell:sizingCell atIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:sizingCell];
}
// For Picture Cell
- (CGFloat)heightForPictureCellAtIndexPath:(NSIndexPath *)indexPath {
    static OttaMyQuestionPictureCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.myTableView dequeueReusableCellWithIdentifier:OttaMyQuestionPictureCellIdentifier];
    });
    
    [self configurePictureCell:sizingCell atIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:sizingCell];
}
// For Footer Cell
- (CGFloat)heightForFooterCellAtIndexPath:(NSIndexPath *)indexPath {
    static OttaMyQuestionFooterCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.myTableView dequeueReusableCellWithIdentifier:OttaMyQuestionFooterCellIdentifier];
    });
    
    [self configureFooterCell:sizingCell atIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:sizingCell];
}
// For Done Cell
- (CGFloat)heightForDoneCellAtIndexPath:(NSIndexPath *)indexPath {
    static OttaMyQuestionDoneCell *sizingCell = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sizingCell = [self.myTableView dequeueReusableCellWithIdentifier:OttaMyQuestionDoneCellIdentifier];
    });
    
    [self configureDoneCell:sizingCell atIndexPath:indexPath];
    return [self calculateHeightForConfiguredSizingCell:sizingCell];
}

- (CGFloat)calculateHeightForConfiguredSizingCell:(UITableViewCell *)sizingCell {
    
    sizingCell.bounds = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.myTableView.frame), CGRectGetHeight(sizingCell.bounds));
    
    [sizingCell setNeedsLayout];
    [sizingCell layoutIfNeeded];
    
    CGSize size = [sizingCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    return size.height+1; // Add 1.0f for the cell separator height
}

#pragma mark - For inital Cell
// For text cell
- (OttaMyQuestionTextCell *)textCellAtIndexPath:(NSIndexPath *)indexPath {
    OttaMyQuestionTextCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:OttaMyQuestionTextCellIdentifier forIndexPath:indexPath];
    [self configureTextCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureTextCell:(OttaMyQuestionTextCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    OttaMyQuestionData *dto = dataForShow[indexPath.row];
    
    cell.lblOrderNumber.text = [NSString stringWithFormat:@"%d",dto.answer.numberAnswer];
    
    NSString *text = dto.answer.answerText;
    NSRange range = [text rangeOfString:@"-"];
    //range.location += 2;
    range.length = text.length - range.location;
    
    NSMutableAttributedString *mutable = [[NSMutableAttributedString alloc] initWithString:text];
    [mutable addAttribute: NSForegroundColorAttributeName value:kDefaultColorBackGround range:range];
    
    [cell.lblText setAttributedText:mutable];
}
// For text cell
- (OttaMyQuestionPictureCell *)pictureCellAtIndexPath:(NSIndexPath *)indexPath {
    OttaMyQuestionPictureCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:OttaMyQuestionPictureCellIdentifier forIndexPath:indexPath];
    [self configurePictureCell:cell atIndexPath:indexPath];
    return cell;
}
// For Picture Cell
- (void)configurePictureCell:(OttaMyQuestionPictureCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    OttaMyQuestionData *dto = dataForShow[indexPath.row];
    
    cell.lblOrderNumber.text = [NSString stringWithFormat:@"%d",dto.answer.numberAnswer];
    //cell.imageViewData.image = dto.answer.answerImage;
    [dto.answer.answerImageFile getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!error) {
            cell.imageViewData.image =  [UIImage imageWithData:data];
        }
    }];

    NSString *text = dto.answer.answerText;
    NSRange range = [text rangeOfString:@"-"];
    //range.location += 2;
    range.length = text.length - range.location;
    
    NSMutableAttributedString *mutable = [[NSMutableAttributedString alloc] initWithString:text];
    [mutable addAttribute: NSForegroundColorAttributeName value:kDefaultColorBackGround range:range];
    [cell.lblText setAttributedText:mutable];
}
// For Header Cell
- (OttaMyQuestionHeaderCell *)headerCellAtIndexPath:(NSIndexPath *)indexPath {
    OttaMyQuestionHeaderCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:OttaMyQuestionHeaderCellIdentifier forIndexPath:indexPath];
    [self configureHeaderCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureHeaderCell:(OttaMyQuestionHeaderCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    OttaMyQuestionData *dto = dataForShow[indexPath.row];
    
    cell.vDivide.hidden = indexPath.row == 0 ? YES:NO;
    cell.lblTextHeader.text = dto.questionText;
}
// For Footer Cell
- (OttaMyQuestionFooterCell *)footerCellAtIndexPath:(NSIndexPath *)indexPath {
    OttaMyQuestionFooterCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:OttaMyQuestionFooterCellIdentifier forIndexPath:indexPath];
    [self configureFooterCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureFooterCell:(OttaMyQuestionFooterCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    OttaMyQuestionData *dto = dataForShow[indexPath.row];
    
    cell.btnSeeAll.hidden = (dto.dataType == MyQuestionDataTypeFooterNormal) ? YES:NO;
    NSString *title = dto.dataType == MyQuestionDataTypeFooterSeeAll ? kSeeAll : kCollapse;
    [cell.btnSeeAll setTitle:title forState:UIControlStateNormal];
    
    cell.lblTime.text = [self timeAgo:dto.expTime];
    //cell.lblTime.text = [NSString stringWithFormat:@"%d min",dto.expirationDate];
    cell.referIndex = dto.referIndex;
    cell.currIndex  = dto.currentTableIndex;
    
    cell.delegate = self;
}
// For Done cell
- (OttaMyQuestionDoneCell *)doneCellAtIndexPath:(NSIndexPath *)indexPath {
    OttaMyQuestionDoneCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:OttaMyQuestionDoneCellIdentifier forIndexPath:indexPath];
    [self configureDoneCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureDoneCell:(OttaMyQuestionDoneCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    OttaMyQuestionData *dto = dataForShow[indexPath.row];
    
    cell.lblText.text = dto.questionText;
}
// For Vote cell
- (OttaMyQuestionVoteCell *)voteCellAtIndexPath:(NSIndexPath *)indexPath {
    OttaMyQuestionVoteCell *cell = [self.myTableView dequeueReusableCellWithIdentifier:OttaMyQuestionVoteCellIdentifier forIndexPath:indexPath];
    [self configureVoteCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureVoteCell:(OttaMyQuestionVoteCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    OttaMyQuestionData *dto = dataForShow[indexPath.row];
    
    [cell setData:dto.voteUsers];
}
#pragma mark - Fix UI Custome
- (void)fixFrameForHeaderCell:(OttaMyQuestionHeaderCell*)cell{
    if ([cell respondsToSelector:@selector(vDivide)]) {
        CGRect rect = cell.vDivide.frame;
        rect.origin.y = 1;
        rect.size.height = 1;
        cell.vDivide.frame = rect;
    }
}
- (void)fixFrameForDoneCell:(OttaMyQuestionDoneCell*)cell{
    if ([cell respondsToSelector:@selector(vDivide)]) {
        CGRect rect = cell.vDivide.frame;
        rect.origin.y = 1;
        rect.size.height = 1;
        cell.vDivide.frame = rect;
    }
}
#pragma mark - OttaMyQuestionFooterCell Delegate
- (void)ottaMyQuestionFooterCellDidSelectSeeAllAtIndex:(int)referIndex atCurrentIndex:(NSInteger)currIndex{
    BOOL isSeeAll = !((OttaQuestion*)datas[referIndex]).isSeeAll;
    ((OttaQuestion*)datas[referIndex]).isSeeAll = isSeeAll;
    
    //[self processDataForShow];
    // Process Data
    int numberLocation = -1;
    if (isSeeAll) {
        BOOL flagHasPhoTo = NO;
        for (OttaAnswer *ans in ((OttaQuestion*)datas[referIndex]).ottaAnswers) {
            if(numberLocation >= 0){
                OttaMyQuestionData *objAnswer1 = [[OttaMyQuestionData alloc] init];
                ans.numberAnswer = numberLocation+2;
                if (ans.answerHasphoto) {
                    objAnswer1.dataType = MyQuestionDataTypeAnswerPicture;
                    flagHasPhoTo = YES;
                }else{
                    objAnswer1.dataType = MyQuestionDataTypeAnswer;
                }
                objAnswer1.answer = ans;
                [dataForShow insertObject:objAnswer1 atIndex:currIndex + numberLocation];
            }
            numberLocation++;
        }
        OttaMyQuestionData *objFooter1 = [dataForShow objectAtIndex:currIndex+numberLocation];
        objFooter1.dataType = flagHasPhoTo ? MyQuestionDataTypeFooterCollapse:MyQuestionDataTypeFooterNormal;
        objFooter1.currentTableIndex = (int)currIndex + numberLocation;
    }else{
        OttaMyQuestionData *objFooter2 = [dataForShow objectAtIndex:currIndex];
        objFooter2.dataType = MyQuestionDataTypeFooterSeeAll;
    }
    
    // -- End Process Data
    // Animation
    if(isSeeAll){
        
        NSMutableArray *arrInsertIdxPaths = [[NSMutableArray alloc] initWithCapacity:3];
        for (int i=0; i<((OttaQuestion*)datas[referIndex]).ottaAnswers.count - 1; i++) {
            NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:currIndex+i inSection:0];
            [arrInsertIdxPaths addObject:newIndexPath];
        }
        
        [self.myTableView insertRowsAtIndexPaths:arrInsertIdxPaths withRowAnimation:UITableViewRowAnimationFade];
        
    }else{
        
        [UIView animateWithDuration:0.2f animations:^{
            
            NSMutableArray *rowsToDelete = [[NSMutableArray alloc] initWithCapacity:5];
            for(int i=1; i < currIndex; i++){
                NSIndexPath* indexPathToDelete = [NSIndexPath indexPathForRow:currIndex-i - 1 inSection:0];
                
                //Check Data
                OttaMyQuestionData *dataAtCurrent = [dataForShow objectAtIndex:indexPathToDelete.row];
                if (dataAtCurrent.dataType != MyQuestionDataTypeHeader) {
                    dataAtCurrent.isShowedVote = NO;
                    OttaMyQuestionData *dataNextCurrent = [dataForShow objectAtIndex:indexPathToDelete.row+1];
                    if (dataNextCurrent.dataType != MyQuestionDataTypeHeader) {
                        [rowsToDelete addObject:[NSIndexPath indexPathForRow:indexPathToDelete.row+1 inSection:0]];
                        [dataForShow removeObjectAtIndex:indexPathToDelete.row+1];
                    }
                }else{
                    break;
                }
            }
            [self.myTableView deleteRowsAtIndexPaths:rowsToDelete withRowAnimation:UITableViewRowAnimationTop];
            [self.myTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:currIndex-rowsToDelete.count-2 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
        } completion:^(BOOL finished) {
            if (finished) {
                [self.myTableView reloadData];
            }
        }];
    }
    
}
- (void)processVoteDataForRowAtIndex:(NSIndexPath*)indexPath{
    OttaMyQuestionData *currQuestion = [dataForShow objectAtIndex:indexPath.row];
    if (currQuestion.isShowedVote) {
        currQuestion.isShowedVote = NO;
        // Remove data at dataForShow
        [dataForShow removeObjectAtIndex:indexPath.row + 1];
        
        // Animation for delete row
        NSIndexPath* rowIndexPath = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:0];
        NSArray *rowsToDelete = [[NSArray alloc] initWithObjects:rowIndexPath, nil];
        [self.myTableView deleteRowsAtIndexPaths:rowsToDelete withRowAnimation:UITableViewRowAnimationTop];
        
    }else{
        currQuestion.isShowedVote = YES;
        
        //get Data for vote at index
        OttaMyQuestionData *obj = [[OttaMyQuestionData alloc] init];
        NSArray *voteData = [dictVoteData valueForKey:@"1"];
        obj.voteUsers = [[NSArray alloc] initWithArray:voteData];
        obj.dataType = MyQuestionDataTypeVote;
        
        // add new data for vote cell
        [dataForShow insertObject:obj atIndex:indexPath.row+1];
        
        // Animation for add cell
        NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:0];
        NSArray *arrInsertIdxPaths = [[NSArray alloc] initWithObjects:newIndexPath, nil];
        [self.myTableView insertRowsAtIndexPaths:arrInsertIdxPaths withRowAnimation:UITableViewRowAnimationFade];
        
    }
}

- (void)processOptionDoneQuestionForRowAtIndex:(NSIndexPath*)indexPath{
    OttaMyQuestionData *currQuestion = [dataForShow objectAtIndex:indexPath.row];
    
    
    if (currQuestion.isShowedOptionDone) {
        
        currQuestion.isShowedOptionDone = NO;
        
        NSMutableArray *rowsToDelete = [[NSMutableArray alloc] initWithCapacity:5];
        // Remove data at dataForShow
        for (NSInteger i = indexPath.row + 1; i < dataForShow.count; i++) {
            
            OttaMyQuestionData *checkOptionQuestion = [dataForShow objectAtIndex:i];
            if (checkOptionQuestion.dataType == MyQuestionDataTypeAnswer || checkOptionQuestion.dataType == MyQuestionDataTypeAnswerPicture) {
                
                NSIndexPath* rowIndexPath = [NSIndexPath indexPathForRow:i inSection:0];
                [rowsToDelete addObject:rowIndexPath];
            }else{
                break;
            }
            
        }
        
        // Remove data
        for (NSInteger j = rowsToDelete.count-1; j >= 0; j--) {
            [dataForShow removeObjectAtIndex:((NSIndexPath*)rowsToDelete[j]).row];
        }
        // Animation for delete row
        [self.myTableView deleteRowsAtIndexPaths:rowsToDelete withRowAnimation:UITableViewRowAnimationTop];
        
    }else{
        currQuestion.isShowedOptionDone = YES;
        
        OttaQuestion *qs = [datas objectAtIndex:currQuestion.referIndex];
        int numberLocation = 1;
        
        // animation add cell and data
        NSMutableArray *arrInsertIdxPaths = [[NSMutableArray alloc] init];
        for (OttaAnswer *answer in qs.ottaAnswers) {
            OttaMyQuestionData *optionData = [[OttaMyQuestionData alloc] init];
            
            answer.numberAnswer = numberLocation;
            if (answer.answerHasphoto) {
                optionData.dataType = MyQuestionDataTypeAnswerPicture;
            }else{
                optionData.dataType = MyQuestionDataTypeAnswer;
            }
            optionData.answer = answer;
            optionData.disableSelecting = YES;
            NSIndexPath *newIndexPath = [NSIndexPath indexPathForRow:indexPath.row+numberLocation inSection:0];
            [arrInsertIdxPaths addObject:newIndexPath];
            [dataForShow insertObject:optionData atIndex:newIndexPath.row];
            
            numberLocation++;
        }
        
        // Animation for add cell
        [self.myTableView insertRowsAtIndexPaths:arrInsertIdxPaths withRowAnimation:UITableViewRowAnimationFade];
        [self.myTableView scrollToRowAtIndexPath:((NSIndexPath*)[arrInsertIdxPaths lastObject]) atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

- (void)loadData{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    datas = [[NSMutableArray alloc] init];
    [[OttaParseClientManager sharedManager] getMyQuestionFromUser:[PFUser currentUser] withBlock:^(NSArray *array, NSError *error) {
        for (PFObject *object in array) {
            OttaQuestion *myQs = [[OttaQuestion alloc] init];
            myQs.questionID = object.objectId;
            myQs.askerID = [PFUser currentUser].objectId;
            myQs.expTime = object[@"expTime"];
            myQs.expirationDate = 8;
            myQs.isSeeAll = NO;
            myQs.questionText = object[@"questionText"];
            
            myQs.ottaAnswers = [[NSMutableArray alloc] init];
            for (PFObject *pfAnswer in object[@"answers"]) {
                OttaAnswer* answer = [[OttaAnswer alloc] init];
                //answer.answerText = pfAnswer[@"description"];
                //hardcode vote number 1 - 10
                int randomNumber = (arc4random() % 10) + 1;
                answer.answerText =[NSString stringWithFormat:@"%@ - %d",pfAnswer[@"description"], randomNumber];
                answer.answerHasContent = YES;
                answer.answerHasphoto   = NO;
                if (pfAnswer[@"image"] != nil) {
                    answer.answerHasphoto   = YES;
                    answer.answerImageFile = pfAnswer[@"image"];
                }
                [myQs.ottaAnswers addObject:answer];
            }
            [datas addObject:myQs];
        }
        [self processDataForShow];
        [myTableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

-(NSString *) timeAgo:(NSDate *)origDate {
    NSDate *timeNow = [[NSDate alloc] init];
    double ti = [timeNow timeIntervalSinceDate:origDate];
    ti = ti*-1;
    if (ti < 60) {
        return [NSString stringWithFormat:@"%d sec",(int) ti];
    } else if (ti < 3600) {
        int diff = round(ti / 60);
        return [NSString stringWithFormat:@"%d min", diff];
    } else if (ti < 86400) {
        int diff = round(ti / 60 / 60);
        return[NSString stringWithFormat:@"%d hour", diff];
    } else if (ti < 2629743) {
        int diff = round(ti / 60 / 60 / 24);
        return[NSString stringWithFormat:@"%d day", diff];
    }
    return @"";
}

@end
