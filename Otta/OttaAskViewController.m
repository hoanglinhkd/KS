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

#define openSansFontRegular [UIFont fontWithName:@"OpenSans-Light" size:18.00f]

@interface OttaAskViewController ()

@end

@implementation OttaAskViewController
@synthesize itsTextView;
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
    
    self.answerViewController.ottaAnswers = [[NSMutableArray alloc]init];

   self.answerTableView.delegate = self.answerViewController;
    self.answerTableView.dataSource = self.answerViewController;
    [self.answerTableView reloadData];
    
    [itsTextView setReturnKeyType:UIReturnKeyDone];
    [itsTextView setFont:openSansFontRegular];
    
    [itsTextView setText:@"Ask a question..."];
    [itsTextView setTextColor:[UIColor lightGrayColor]];
    
    // Do any additional setup after loading the view.
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

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (itsTextView.textColor == [UIColor lightGrayColor]) {
        itsTextView.text = @"";
        itsTextView.textColor = [UIColor blackColor];
    }
    
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    if(itsTextView.text.length == 0){
        itsTextView.textColor = [UIColor lightGrayColor];
        itsTextView.text = @"Ask a question...";
        [itsTextView resignFirstResponder];
    }
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        if(itsTextView.text.length == 0){
            itsTextView.textColor = [UIColor lightGrayColor];
            itsTextView.text = @"Ask a question...";
            [itsTextView resignFirstResponder];
        }
        return NO;
    }
    
    return YES;
}

@end
