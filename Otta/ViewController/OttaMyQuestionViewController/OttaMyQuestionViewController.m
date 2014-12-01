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

@interface OttaMyQuestionViewController ()<UITableViewDataSource, UITableViewDelegate>{
    NSMutableArray *datas;
}

@end

@implementation OttaMyQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createDemoData];
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
    
    for (int i=0; i<10; i++) {
        OttaQuestion *myQs = [[OttaQuestion alloc] init];
        myQs.questionID = [NSString stringWithFormat:@"%d",i];
        myQs.ottaAnswers = [[NSMutableArray alloc] init];
        for (int j=0; j<4; j++) {
            OttaAnswer *answer = [[OttaAnswer alloc] init];
            //answer.answerImage = [UIImage imageNamed:@"creme_brelee.jpg"];
            answer.answerText  = [NSString stringWithFormat:@"answer number %d",j];
            answer.answerHasContent = YES;
            answer.answerHasphoto   = NO;
            [myQs.ottaAnswers addObject:answer];
        }
        myQs.askerID = [NSString stringWithFormat:@"162817629"];
        myQs.expirationDate = 5;
        myQs.questionText = @"What food we should to eat tonight, Do you to eat more food without healthy, come to London, right now?";
        
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
#pragma mark - UITableview Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // do something
}
@end
