//
//  OttaLoginViewController.m
//  Otta
//
//  Created by Steven Ojo on 7/27/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaLoginViewController.h"

@interface OttaLoginViewController ()

@end

@implementation OttaLoginViewController

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
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"OttaGreenBackground.png"]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    if(viewUp)return;
    if ([UIApplication currentSize].width > [UIApplication currentSize].height || [UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone){
        [self slideViewUp:YES];
    }
}

-(void)slideViewUp:(BOOL)up{
    int amtToMove = [UIApplication currentSize].height < 568 ? 150 : 80;
    [UIView animateWithDuration:0.3 animations:^{
        CGRect newFrame = viewContainer.frame;
        newFrame.origin.y -= up ? amtToMove : -amtToMove;
        viewContainer.frame = newFrame;
        viewUp = up ? YES : NO;
    }];
    
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    if(viewUp == YES)
        [self slideViewUp:NO];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [passwordTextField resignFirstResponder];
    [usernameTextField resignFirstResponder];
    [self loginAction];
    return YES;
    
 
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

@end
