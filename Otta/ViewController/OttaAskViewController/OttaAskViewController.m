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
#import "OttaOptionCell.h"
#import "OttaAnswer.h"

@interface OttaAskViewController ()

@end

@implementation OttaAskViewController
//@synthesize itsTextView,answerTableView,activeTextField;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
/*
- (void)keyboardWasShown:(NSNotification *)notification
{
    
    // Step 1: Get the size of the keyboard.
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    // Step 2: Adjust the bottom content inset of your scroll view by the keyboard height.
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0);
    answerTableView.contentInset = contentInsets;
    answerTableView.scrollIndicatorInsets = contentInsets;
    
    
    // Step 3: Scroll the target text field into view.
    CGRect aRect = self.view.frame;
    aRect.size.height -= keyboardSize.height;
   // if (!CGRectContainsPoint(aRect, activeTextField.frame.origin) ) {
    CGPoint scrollPoint = CGPointMake(0.0, activeTextField.frame.origin.y - (keyboardSize.height-15));
        [answerTableView setContentOffset:scrollPoint animated:YES];
   // }
}

- (void) keyboardWillHide:(NSNotification *)notification {
    
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    answerTableView.contentInset = contentInsets;
    answerTableView.scrollIndicatorInsets = contentInsets;
}
 */
- (IBAction)dismissKeyboard:(id)sender
{
    //[activeTextField resignFirstResponder];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];

  /*  [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
   */
   
  /*  OttaAnswer * testAnswer = [[OttaAnswer alloc]init];
    OttaAnswer * testAnswer2 = [[OttaAnswer alloc]init];
    OttaAnswer * testAnswer3 = [[OttaAnswer alloc]init];
    OttaAnswer * testAnswer4 = [[OttaAnswer alloc]init];

testAnswer.answerText = @"Creme Brelee";
    testAnswer.answerImage = [UIImage imageNamed:@"creme_brelee.jpg"];
    testAnswer2.answerText = @"Hamburger";
    testAnswer2.answerImage =[UIImage imageNamed:@"hamburger.jpg"];
    
    
    self.answerViewController.ottaAnswers = [NSMutableArray arrayWithObjects:testAnswer,testAnswer2, nil];
    
   */
    
    //self.answerViewController.ottaAnswers = [[NSMutableArray alloc]init];

//   self.answerTableView.delegate = self.answerViewController;
//    self.answerTableView.dataSource = self.answerViewController;
//    [self.answerTableView reloadData];
//    self.answerViewController.mainViewController = self;
    [_itsTextView setReturnKeyType:UIReturnKeyDone];
    [_itsTextView setFont:[UIFont fontWithName:@"OpenSans-Light" size:17.00f]];
    
    [_itsTextView setText:[@"Ask a question..." toCurrentLanguage]];
    [_itsTextView setTextColor:[UIColor lightGrayColor]];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadQuestions)
                                                 name:@"reloadQuestions"
                                               object:nil];
    
    // Do any additional setup after loading the view.
        _optionsArray = [NSMutableArray new];
    [_optionsArray addObject:[[OttaAnswer alloc] init]];
}
-(void)reloadQuestions
{
    //[self.answerTableView reloadData];
    
    ///NSLog(@"Questions reloaded:%@",self.answerViewController.ottaAnswers);
  
    /*OttaAnswer * testAnswer = [self.answerViewController.ottaAnswers objectAtIndex:0
                               ];
    if(testAnswer.answerHasContent == YES)
    {
        NSLog(@"It has content wtf");
    }
    if(testAnswer.answerHasContent == NO)
    {
        NSLog(@"It doesnt have content");
    }
     */
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

-(IBAction)addQuestionButtonText:(id)sender
{
   /* YIPopupTextView* popupTextView = [[YIPopupTextView alloc] initWithPlaceHolder:@"Add answer here." maxCount:0];
    popupTextView.delegate = self;
    popupTextView.caretShiftGestureEnabled = YES;   // default = NO
    
   // popupTextView.text = self.textView.text;
    //popupTextView.editable = NO;                  // set editable=NO to show without keyboard
    
    //[popupTextView showInView:self.view];
    [popupTextView showInViewController:self]; // recommended, especially for iOS7
    */
    
//    if([self.answerViewController.ottaAnswers count]<4)
//    {
//    OttaAnswer * newAnswer = [[OttaAnswer alloc]init];
//    newAnswer.answerHasContent = NO;
//    newAnswer.answerImage = nil;
    //[self.answerViewController.ottaAnswers addObject:newAnswer];
    //[self.answerTableView reloadData];
       
    //}

}
/*
- (void)popupTextView:(YIPopupTextView*)textView didDismissWithText:(NSString*)text cancelled:(BOOL)cancelled;

{
 
    __weak typeof(self) weakSelf = self;
    
   
    
    OttaAnswer * newAnswer = [[OttaAnswer alloc]init];
    newAnswer.answerText = [NSString stringWithString:text];
    newAnswer.answerHasContent = YES;
    newAnswer.answerImage = nil;
    
    
    self.photoPicker = [[CZPhotoPickerController alloc] initWithPresentingViewController:self withCompletionBlock:^(UIImagePickerController *imagePickerController, NSDictionary *imageInfoDict) {
        
        if (imagePickerController.allowsEditing) {
            newAnswer.answerImage = imageInfoDict[UIImagePickerControllerEditedImage];
        }
        else {
            newAnswer.answerImage = imageInfoDict[UIImagePickerControllerOriginalImage];
        }
        
        [weakSelf.photoPicker dismissAnimated:YES];
        weakSelf.photoPicker = nil;
        [weakSelf.answerViewController.ottaAnswers addObject:newAnswer];
        [weakSelf.answerTableView reloadData];
        
    }];
    
    self.photoPicker.allowsEditing = YES; // optional
    
   // self.photoPicker.cropOverlaySize = CGSizeMake(320, 160); // optional
    
  //  [self presentViewController:self.photoPicker animated:YES completion:nil];
    UIBarButtonItem * somebarbutton =[[UIBarButtonItem alloc]init];
    [self.photoPicker showFromBarButtonItem:somebarbutton];
    
}
 /*

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark TextView Delegate methods

/*
UITextView itsTextView = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, itsTextView.frame.size.width, itsTextView.frame.size.height)];
[itsTextView setDelegate:self];
[itsTextView setReturnKeyType:UIReturnKeyDone];
[itsTextView setText:@"List words or terms separated by commas"];
[itsTextView setFont:[UIFont fontWithName:@"HelveticaNeue" size:11]];
[itsTextView setTextColor:[UIColor lightGrayColor]];
 */

/*- (void) textViewDidBeginEditing:(UITextField *)textView {
    UITableViewCell *cell;
    
    if (floor(NSFoundationVersionNumber) <= NSFoundationVersionNumber_iOS_6_1) {
        // Load resources for iOS 6.1 or earlier
        cell = (UITableViewCell *) textView.superview.superview;
        
    } else {
        // Load resources for iOS 7 or later
        cell = (UITableViewCell *) textView.superview.superview.superview;
        // TextField -> UITableVieCellContentView -> (in iOS 7!)ScrollView -> Cell!
    }
    [self.answerTableView scrollToRowAtIndexPath:[self.answerTableView indexPathForCell:cell] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}
 */

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    
    self.activeTextField = textView;

    if (_itsTextView.textColor == [UIColor lightGrayColor]) {
        _itsTextView.text = @"";
        _itsTextView.textColor = [UIColor blackColor];
    }
    
    return YES;
}



- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {

    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        if(_itsTextView.text.length == 0){
            _itsTextView.textColor = [UIColor lightGrayColor];
            _itsTextView.text = [@"Ask a question..." toCurrentLanguage];
            [_itsTextView resignFirstResponder];
        }
        return NO;
    }
    
    return YES;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _optionsArray.count + 2;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"Options:";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == _optionsArray.count + 1) {
        // Choose deadline
        static NSString *cellIdentifier = @"OttaDeadlineOptionCellIID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:
                    UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        return cell;
    }
    
    if (indexPath.row == _optionsArray.count) {
        // Add option
        static NSString *cellIdentifier = @"OttaAddOptionCellIID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:
                    UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        return cell;
    }
    
    static NSString *cellIdentifier = @"OttaOptionCellIID";
    OttaOptionCell *cell = [tableView dequeueReusableCellWithIdentifier:
                          cellIdentifier];
    if (cell == nil) {
        cell = [[OttaOptionCell alloc]initWithStyle:
                UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == _optionsArray.count + 1) {
        // Choose deadline
        return 116;
    }
    
    if (indexPath.row == _optionsArray.count) {
        // Add option
        return 55;
    }
    
    return 152;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == _optionsArray.count + 1) {
        // Choose deadline
        
    }
    
    if (indexPath.row == _optionsArray.count) {
        // Add option
        [_optionsArray addObject:[[OttaAnswer alloc] init]];
        [tableView reloadData];
    }
}

@end
