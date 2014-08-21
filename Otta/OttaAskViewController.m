//
//  OttaAskViewController.m
//  Otta
//
//  Created by Steven Ojo on 8/20/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaAskViewController.h"
#import "OttaAnswer.h"
#import "YIPopupTextView.h"
@interface OttaAskViewController ()

@end

@implementation OttaAskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    self.answerViewController = [[OttaAnswerTableController alloc]init];
    
    OttaAnswer * testAnswer = [[OttaAnswer alloc]init];
    OttaAnswer * testAnswer2 = [[OttaAnswer alloc]init];
    OttaAnswer * testAnswer3 = [[OttaAnswer alloc]init];
    OttaAnswer * testAnswer4 = [[OttaAnswer alloc]init];

testAnswer.answerText = @"Creme Brelee";
    testAnswer.answerImage = [UIImage imageNamed:@"creme_brelee.jpg"];
    testAnswer2.answerText = @"Hamburger";
    testAnswer2.answerImage =[UIImage imageNamed:@"hamburger.jpg"];
    

    
    self.answerViewController.ottaAnswers = [NSMutableArray arrayWithObjects:testAnswer,testAnswer2];
    self.answerTableView.delegate = self.answerViewController;
    self.answerTableView.dataSource = self.answerViewController;
    [self.answerTableView reloadData];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

-(IBAction)addQuestionButtonText:(id)sender
{
    YIPopupTextView* popupTextView = [[YIPopupTextView alloc] initWithPlaceHolder:@"Add answer here." maxCount:0];
    popupTextView.delegate = self;
    popupTextView.caretShiftGestureEnabled = YES;   // default = NO
    
   // popupTextView.text = self.textView.text;
    //popupTextView.editable = NO;                  // set editable=NO to show without keyboard
    
    //[popupTextView showInView:self.view];
    [popupTextView showInViewController:self]; // recommended, especially for iOS7
}

- (void)popupTextView:(YIPopupTextView*)textView didDismissWithText:(NSString*)text cancelled:(BOOL)cancelled;

{
 
    
    
    OttaAnswer * newAnswer = [[OttaAnswer alloc]init];
    newAnswer.answerText = [NSString stringWithString:text];
    newAnswer.answerHasContent = YES;
    newAnswer.answerImage = nil;
    [self.answerViewController.ottaAnswers addObject:newAnswer];
    [self.answerTableView reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
