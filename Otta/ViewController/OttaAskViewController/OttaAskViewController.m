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
#import "OttaAlertManager.h"
#import "NSString+Language.h"
#import "UIViewController+ECSlidingViewController.h"
#import "OttaAnswerersViewController.h"
#import "CZPhotoPreviewViewController.h"
#import "SideMenuViewController.h"

@interface OttaAskViewController ()
{
    NSMutableDictionary *listHeightQuestion;
    NSString* deadlineString;
    NSInteger selectedTimeValue;
    TimeSelection selectedDuration;
}

@property (strong) OttaOptionCell *editingOptionCell;

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

    selectedTimeValue = 0;
    selectedDuration = -1;
    
    [self.navigationController setNavigationBarHidden:YES];
    
    listHeightQuestion = [NSMutableDictionary dictionary];
    //Default is having first row
    [listHeightQuestion setObject:[NSNumber numberWithFloat:70.0f] forKey:@"row0"];
    
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
    //[_itsTextView setReturnKeyType:UIReturnKeyDone];
    
    [_itsTextView setFont:[UIFont fontWithName:@"OpenSans-Light" size:17.00f]];
    
    _itsTextView.placeholder = [@"Ask a question..." toCurrentLanguage];
    _itsTextView.placeholderTextColor = [UIColor lightGrayColor];
    
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

- (BOOL) textView:(UITextView*)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString*) text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

- (IBAction)menuButtonPressed:(id)sender {
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
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
 */

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


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_optionsArray.count < 4) {
        return _optionsArray.count + 2;
    } else {
        return _optionsArray.count + 1;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ((_optionsArray.count < 4 && indexPath.row == _optionsArray.count + 1) || (_optionsArray.count == 4 && indexPath.row == _optionsArray.count)) {
        // Choose deadline
        static NSString *cellIdentifier = @"OttaDeadlineOptionCellIID";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                                cellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc]initWithStyle:
                    UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        }
        
        UILabel *label = (UILabel *)[cell viewWithTag:1001];
        if (deadlineString != nil && ![deadlineString isEqualToString:@""]) {
            label.text = deadlineString;
        } else {
            label.text = [@"Choose deadline..." toCurrentLanguage];
        }
        
        return cell;
    }
    
    if (_optionsArray.count < 4 && indexPath.row == _optionsArray.count) {
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
    cell.indexPath = indexPath;
    [cell enableAutoHeightCell];
    [cell.lblNumber setText:[NSString stringWithFormat:@"%d", indexPath.row + 1]];
    
    //Mapping data model
    OttaAnswer *curAnswer = [_optionsArray objectAtIndex:indexPath.row];
    cell.answer = curAnswer;
    if(curAnswer.answerHasphoto) {
        [cell displayThumbAndCaption:curAnswer.answerImage caption:curAnswer.answerText];
    } else if(curAnswer.answerHasContent){
        [cell displayContent:curAnswer.answerText];
    } else {
        [cell displayViewAction];
    }
    
    cell.delegate = self;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ((_optionsArray.count < 4 && indexPath.row == _optionsArray.count + 1) || (_optionsArray.count == 4 && indexPath.row == _optionsArray.count)) {
        // Choose deadline
        return 116;
    }
    
    if (_optionsArray.count < 4 && indexPath.row == _optionsArray.count) {
        // Add option
        return 55;
    }
    
    NSNumber *currentRowHeight = [listHeightQuestion objectForKey:[NSString stringWithFormat:@"row%d", indexPath.row]];
    return [currentRowHeight floatValue];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ((_optionsArray.count < 4 && indexPath.row == _optionsArray.count + 1) || (_optionsArray.count == 4 && indexPath.row == _optionsArray.count)) {
        // Choose deadline
        [[OttaAlertManager sharedManager] showLimitTimerPickerOnView:self.view completionBlock:^(NSInteger timeValue, TimeSelection timeSelectionValue) {
            
            selectedTimeValue = timeValue;
            selectedDuration = timeSelectionValue;
            
            NSString *str = @"";
            switch (timeSelectionValue) {
                case TimeSelection_Minutes:
                    str = [NSString stringWithFormat:@"%d Minutes",timeValue];
                    break;
                case TimeSelection_Hours:
                    str = [NSString stringWithFormat:@"%d Hours",timeValue];
                    break;
                case TimeSelection_Days:
                    str = [NSString stringWithFormat:@"%d Days",timeValue];
                    break;
                case TimeSelection_Weeks:
                    str = [NSString stringWithFormat:@"%d Weeks",timeValue];
                    break;
                case TimeSelection_Months:
                    str = [NSString stringWithFormat:@"%d Months",timeValue];
                    break;
                default:
                    break;
            }
            deadlineString = str;
            [tableView reloadData];
        }];
    }
    
    //Check has any option empty or not. Don't allow add more option if has empty option
    BOOL hasOptionEmpty = [self hasOptionEmpty:_optionsArray];
    if (_optionsArray.count < 4 && indexPath.row == _optionsArray.count && !hasOptionEmpty) {
        // Add option
        [_optionsArray addObject:[[OttaAnswer alloc] init]];
        [listHeightQuestion setObject:[NSNumber numberWithFloat:70.0f] forKey:[NSString stringWithFormat:@"row%d", indexPath.row]];
        [tableView reloadData];
    }
   
}

- (void)textViewDidChange:(UITextView *)textView
{
    //Defining auto height of Ask Question
    if(textView == _itsTextView) {
        int numLines = textView.contentSize.height / textView.font.leading;
        
        if(numLines >= 4) { //Max lines is 4
            _heightAskContent.constant = 92.0f;
        } else if(numLines == 2) { //Fixed redundant space in bottom for 2 lines text
            _heightAskContent.constant = 52.0f;
        } else {
            _heightAskContent.constant = textView.contentSize.height;
        }
        
        [UIView animateWithDuration:0.4 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

#pragma mark option cell delegate

-(void)optionCell:(OttaOptionCell *)cell textView:(HPGrowingTextView *)textViewUpdateHeight willChangeHeight:(float)height
{
    NSLog(@"Height = %f", height);
    if(cell.viewContent2.isHidden) {
        //NSIndexPath *indexPath = [self.tableAsk indexPathForCell:cell];
        //[listHeightQuestion setObject:[NSNumber numberWithFloat:height + 20] forKey:[NSString stringWithFormat:@"row%d",indexPath.row]];
        //[self.tableAsk reloadData];
    }
}

- (void)optionCell:(OttaOptionCell*)cell textBeginEditing:(id)textview
{
    
}

- (void)optionCell:(OttaOptionCell*)cell textEndEditing:(id)textview
{
    //Avoid crashing because of index change
    if(_optionsArray.count >= (cell.indexPath.row - 1)) {
        OttaAnswer *curAnswer = [_optionsArray objectAtIndex:cell.indexPath.row];
        curAnswer.answerText = textview;
    }
}

- (void)optionCell:(OttaOptionCell *)cell needEditPicture:(id)imageView{
    //Don't need to choose photo
    //[_photoPicker showFromRect:self.view.bounds];
    _editingOptionCell = cell;
    [self performSegueWithIdentifier:@"segueAddCaptionPicture" sender:@NO];
}
- (void)optionCell:(OttaOptionCell*)cell beginTakePicture:(id)imageView
{
    NSLog(@"take image");
    _editingOptionCell = cell;
    [self showImagePicker];
}

- (void)showImagePicker
{
    __weak typeof(self) weakSelf = self;
    
    _photoPicker = [[CZPhotoPickerController alloc] initWithPresentingViewController:self withCompletionBlock:^(UIImagePickerController *imagePickerController, NSDictionary *imageInfoDict) {
        UIImage *selectedImage = nil;
        if (imageInfoDict) {
            if (imagePickerController.allowsEditing) {
                selectedImage = imageInfoDict[UIImagePickerControllerEditedImage];
            }
            else {
                selectedImage = imageInfoDict[UIImagePickerControllerOriginalImage];
            }
            
            selectedImage = [OttaUlti resizeImage:selectedImage];
            if(weakSelf.editingOptionCell.answer) {
                weakSelf.editingOptionCell.answer.answerImage = selectedImage;
            }
            [weakSelf.photoPicker dismissAnimated:YES];
            
            [self performSegueWithIdentifier:@"segueAddCaptionPicture" sender:@YES];//YES mean shouldHideBtnDiscard = YES: hide button discard image when the view showed because in this case it is taking picture
            
        } else {
            [weakSelf.photoPicker dismissAnimated:YES];
        }
        
    }];
    
    _photoPicker.allowsEditing = YES; // optional
    
    UIBarButtonItem * somebarbutton =[[UIBarButtonItem alloc]init];
    [_photoPicker showFromBarButtonItem:somebarbutton];
}

#pragma mark - Answerer VC delegate

-(void)askSuccessed
{
    [self clearAllDataViews];
}

#pragma mark -

-(BOOL) hasOptionEmpty:(NSMutableArray*) arrayOptions
{
    for (OttaAnswer *curAnswer in arrayOptions) {
        if(curAnswer.answerImage == nil && curAnswer.answerText.length <= 0) {
            return YES;
        }
    }
    return NO;
}

- (void) clearAllDataViews
{
    [_optionsArray removeAllObjects];
    [_optionsArray addObject:[[OttaAnswer alloc] init]];
    selectedDuration = 0;
    selectedTimeValue = -1;
    _itsTextView.text = @"";
    deadlineString = @"";
    [_tableAsk reloadData];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString: @"segueAddCaptionPicture"]) {
        OttaAddCaptionImageViewController *dest = (OttaAddCaptionImageViewController *)[segue destinationViewController];
        //the sender is what you pass into the previous method
        dest.image = self.editingOptionCell.answer.answerImage;
        dest.question =  _itsTextView.text;
        dest.delegate = self;
        if (sender) {
            dest.shouldHideBtnDiscard = [sender boolValue];
        }
    } else if([[segue identifier] isEqualToString:@"segueAnswerers"]) {
        OttaAnswerersViewController *answerVC = (OttaAnswerersViewController*)[segue destinationViewController];
        answerVC.optionsArray = sender;
        answerVC.selectedDuration = selectedDuration;
        answerVC.selectedTimeValue = selectedTimeValue;
        answerVC.askQuestionValue = _itsTextView.text;
        answerVC.delegate  = self;
    }
}

- (void)addCaptionVC:(OttaAddCaptionImageViewController*)captionVC addCaption:(id)caption {
    OttaAnswer *answer = _editingOptionCell.answer;
    if(answer) { //Has mapping answer modal
        answer.answerText = caption;
        [_editingOptionCell displayThumbAndCaption:answer.answerImage caption:caption];
    } else { //just display caption if don't have answer modal
        [_editingOptionCell displayCabtion:caption];
    }
    
}

-(void)deleteCaptionVC:(OttaAddCaptionImageViewController *)captionVC
{
    OttaAnswer *answer = _editingOptionCell.answer;
    [_optionsArray removeObject:answer];
    [_tableAsk reloadData];
}

- (IBAction)btnNextPress:(id)sender {
    
    if(_itsTextView.text.length <= 0) {
        [[OttaAlertManager sharedManager] showSimpleAlertWithContent:[@"Please provide question" toCurrentLanguage] complete:nil];
        return;
    }
    
    if(selectedTimeValue <= 0) {
        [[OttaAlertManager sharedManager] showSimpleAlertWithContent:[@"Please choose deadline" toCurrentLanguage] complete:nil];
        return;
    }
    
    NSMutableArray *optionToAdd = [NSMutableArray array];
    //For check the real option data. we can't not user count property to check the count options
    for (OttaAnswer *curAnswer in _optionsArray) {
        if(curAnswer.answerImage == nil && curAnswer.answerText.length <= 0) {
            
        } else {
            [optionToAdd addObject:curAnswer];
        }
    }
    
    if(optionToAdd.count < 2) {
        [[OttaAlertManager sharedManager] showSimpleAlertWithContent:[@"The number of options must be greater than 1" toCurrentLanguage] complete:nil];
        return;
    }
    
    [self performSegueWithIdentifier:@"segueAnswerers" sender:optionToAdd];
    
}
- (IBAction)pressBtnLogo:(id)sender{
    [[SideMenuViewController sharedInstance] selectRowAtIndex:[NSIndexPath indexPathForRow:1 inSection:0] forViewController:self];
}
@end
