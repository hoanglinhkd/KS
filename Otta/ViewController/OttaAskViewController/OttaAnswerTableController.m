//
//  OttaAnswerTableController.m
//  Otta
//
//  Created by Steven Ojo on 8/21/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//
#import "OttaQuestionTableViewCell.h"
#import "OttaAnswerTableController.h"
#import "OttaQuestionTableViewCell.h"
@implementation OttaAnswerTableController
@synthesize ottaAnswers;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ottaAnswers count];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 150.00;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    OttaQuestionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[OttaQuestionTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
        
        NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"OttaQuestionTableViewCell" owner:self options:nil];
        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[UITableViewCell class]]) {
                cell = (OttaQuestionTableViewCell *)currentObject;
                break;
            }
        
        
        
        }
    }
    OttaAnswer * ottaAnswer = [ottaAnswers objectAtIndex:indexPath.row];
    UIImage * ottaNumberBackground = [UIImage imageNamed:@"OttaNumberBackground.png"];
    UIImageView * ottaNumberBackgroundImageView = [[UIImageView alloc]initWithImage:ottaNumberBackground];
    
    [ottaNumberBackgroundImageView setFrame:CGRectMake(15.0f, 25.0f, 25.0f, 25.0f)];
    [cell addSubview:ottaNumberBackgroundImageView];
    UILabel * questionCount = [[UILabel alloc]initWithFrame:CGRectMake(23.0f, 25.0f, 25.0f, 25.0f)];
    [questionCount setTextColor:[UIColor whiteColor]];
    [questionCount setText:[NSString stringWithFormat:@"%ld",indexPath.row+1]];
    [cell addSubview:questionCount];
    if(ottaAnswer.answerHasContent == NO)
    {
        NSLog(@"Drawing cell");
        UIImage *pencilImage = [UIImage imageNamed:@"OttaAddTextButton.png"];
        UIImage *cameraImage = [UIImage imageNamed:@"addPhotoOtta.png"];
     
        cell.addTextButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        cell.addTextButton.frame = CGRectMake(100.0f, 0.0f, 67.0f, 56.0f);
        [cell.addTextButton setTitle:@"" forState:UIControlStateNormal];
        [cell addSubview:cell.addTextButton];
        [cell.addTextButton addTarget:self
                            action:@selector(addText:)
                  forControlEvents:UIControlEventTouchUpInside];
        [cell.addTextButton setBackgroundImage:pencilImage forState:UIControlStateNormal];
       
        
        
        cell.addPhotoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        cell.addPhotoButton.frame = CGRectMake(200.0, 0.0f, 67.0f, 56.0f);
        [cell.addPhotoButton setTitle:@" " forState:UIControlStateNormal];
        [cell addSubview:cell.addPhotoButton];
        [cell.addPhotoButton addTarget:self
                            action:@selector(addPhoto:)
                  forControlEvents:UIControlEventTouchUpInside];
        [cell.addPhotoButton setBackgroundImage:cameraImage forState:UIControlStateNormal];
        cell.addPhotoButton.tag = indexPath.row;
        cell.addTextButton.tag = indexPath.row;
       
       // cell.textLabel.text = @"A NEW CELL";

     //   NSLog(@"Label Frame:%f %f %f %f",cell.textLabel.frame.origin.x,cell.textLabel.frame.origin.y, cell.textLabel.frame.size.width,cell.textLabel.frame.size.height);
       
       // CGR
        [cell.ottaAnswerText setDelegate:self];


        
    }
    
    else
    {
        
        [cell.ottaAnswerText setFont:openSansFontRegular];
        [cell.ottaAnswerText setDelegate:self];
        [cell.addTextButton setHidden:YES];
        [cell.addPhotoButton setHidden:YES];
        [cell.ottaAnswerText setHidden:NO];
        cell.ottaAnswerText.tag = indexPath.row;
        if(ottaAnswer.answerText !=nil)
        {
        [cell.ottaAnswerText setText:ottaAnswer.answerText];
            [cell.ottaAnswerText setTextColor:[UIColor blackColor]];
           
        }
        
        else
        {
            [cell.ottaAnswerText setText: [@"Enter an answer..." toCurrentLanguage]];
            [cell.ottaAnswerText setTextColor:[UIColor lightGrayColor]];

        }
        if(ottaAnswer.answerImage !=nil &&ottaAnswer.answerHasphoto == YES)
        {
            [cell.answerImage setImage:ottaAnswer.answerImage];
        }
        
        [cell.ottaAnswerText setReturnKeyType:UIReturnKeyDone];
        [cell.ottaAnswerText setFont:openSansFontRegular];
        
        
       // [cell.ottaAnswerText setText:@"Ask a question..."];
        
        
    }
    //iOS_B0$$2k14#N
   /* if([[ottaAnswers objectAtIndex:indexPath.row] isKindOfClass:[OttaAnswer class]])
    {
        OttaAnswer * ottaAnswer = [ottaAnswers objectAtIndex:indexPath.row];
        
        cell.textLabel.text = ottaAnswer.answerText;
        
        if(ottaAnswer.answerImage !=nil)
            cell.imageView.image = ottaAnswer.answerImage;
        else
            [cell.imageView setHidden:YES];
 
    }
    
    else
    {
        [ottaAnswers removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    }
    
    */
    return cell;
}


- (void)addText:(UIButton*)sender{
    
    OttaAnswer * answerToAddTextTo = [ottaAnswers objectAtIndex:sender.tag];
    answerToAddTextTo.answerHasContent = YES;
    answerToAddTextTo.answerHasphoto = NO;

    NSLog(@"Add text to otta qn..");
    
   
    [ottaAnswers replaceObjectAtIndex:sender.tag withObject:answerToAddTextTo];

    //[ottaAnswers removeAllObjects];
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"reloadQuestions"
     object:self];
    
    // Or place opening logic right here
}

- (void)addPhoto:(UIButton*)sender{
    OttaAnswer * newAnswer = [ottaAnswers objectAtIndex:sender.tag];
    newAnswer.answerHasContent = YES;
    newAnswer.answerHasphoto = YES;
    // Or place opening logic right here
    
    
    
    __weak typeof(self) weakSelf = self;
    
    
    
    newAnswer.answerHasContent = YES;
    newAnswer.answerImage = nil;
    
    
    self.photoPicker = [[CZPhotoPickerController alloc] initWithPresentingViewController:self.mainViewController withCompletionBlock:^(UIImagePickerController *imagePickerController, NSDictionary *imageInfoDict) {
        
        if (imagePickerController.allowsEditing) {
            newAnswer.answerImage = imageInfoDict[UIImagePickerControllerEditedImage];
        }
        else {
            newAnswer.answerImage = imageInfoDict[UIImagePickerControllerOriginalImage];
        }
        
        [weakSelf.photoPicker dismissAnimated:YES];
        weakSelf.photoPicker = nil;
        [ottaAnswers replaceObjectAtIndex:sender.tag withObject:newAnswer];
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"reloadQuestions"
         object:self];
    }];
    
    self.photoPicker.allowsEditing = YES; // optional
    
    // self.photoPicker.cropOverlaySize = CGSizeMake(320, 160); // optional
    
    //  [self presentViewController:self.photoPicker animated:YES completion:nil];
    UIBarButtonItem * somebarbutton =[[UIBarButtonItem alloc]init];
    [self.photoPicker showFromBarButtonItem:somebarbutton];
    


    
    
    
    
    

   
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove the row from data model
    
    
    [ottaAnswers removeObjectAtIndex:indexPath.row];
    
    // Request table view to reload
    [tableView reloadData];
}





- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if (textView.textColor == [UIColor lightGrayColor]) {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    
    
   

    NSLog(@"Add text to otta qn..");
    
    

    
    
    return YES;
}



- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        if(textView.text.length == 0){
            textView.textColor = [UIColor lightGrayColor];
            textView.text = [@"Enter an answer..." toCurrentLanguage];
            [textView resignFirstResponder];
        }
        return NO;
    }
    
    
    OttaAnswer * answerToAddTextTo = [ottaAnswers objectAtIndex:textView.tag];
    answerToAddTextTo.answerHasContent = YES;
    answerToAddTextTo.answerText = [textView.text stringByReplacingCharactersInRange:range withString:text];
    [ottaAnswers replaceObjectAtIndex:textView.tag withObject:answerToAddTextTo];
    return YES;
}




@end
