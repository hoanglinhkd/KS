//
//  OttaMediaQuestionDetailViewController.m
//  Otta
//
//  Created by Dong Duong on 11/30/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaMediaQuestionDetailViewController.h"
#import "OttaAnswer.h"
#import "UIImageView+AFNetworking.h"

@interface OttaMediaQuestionDetailViewController ()

@end

@implementation OttaMediaQuestionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.orderLbl.clipsToBounds = YES;
//    // Do any additional setup after loading the view.
//    _question = [[OttaQuestion alloc] init];
//
//    _question.questionText = @"Test long question, long question test, test long question test?";
//    // Do any additional setup after loading the view.
//    OttaAnswer* answer = [[OttaAnswer alloc] init];
//    answer.answerText = @"Caesar Blah Caesar Blah Caesar  Blah Caesar Caesar Blah Caesar Blah Caesar  Blah Caesar";
//    answer.answerImage = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];
//    
//    OttaAnswer* answer1 = [[OttaAnswer alloc] init];
//    answer1.answerText = @"Thousand Islands";
//    answer1.answerImage = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];
//    
//    OttaAnswer* answer2 = [[OttaAnswer alloc] init];
//    answer2.answerText = @"Strawberry Something";
//    answer2.answerImage = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];
//    
//    OttaAnswer* answer3 = [[OttaAnswer alloc] init];
//    answer3.answerText = @"Japanese noddle with pork";
//    answer3.answerImage = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];
//    
//    NSArray *answers = [NSArray arrayWithObjects:answer,answer1,answer2,answer3, nil];
//    _question.ottaAnswers = [NSMutableArray arrayWithArray:answers];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.questionbl.text = self.question.questionText;
    self.optionLbl.text = ((OttaAnswer*)[self.question.ottaAnswers objectAtIndex:0]).answerText;
    
    for (int i = 0; i < self.question.ottaAnswers.count; i++) {
        CGRect frame;
        frame.origin.x = self.imgscrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.imgscrollView.frame.size;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        NSString *urlString = @"https://farm6.static.flickr.com/5557/15191895482_e495291616_m.jpg";
        
        NSURL *url = [NSURL URLWithString:urlString];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        UIImage *placeholderImage = [UIImage imageNamed:@"OttaLandingTopLogo.png"];
        
        [imageView setImageWithURLRequest:request
                             placeholderImage:placeholderImage
                                      success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                          
                                          imageView.image = image;
                                      } failure:nil];
        
        //imageView.image = [UIImage imageNamed:@"japanese_noodle_with_pork.jpg"];
        [self.imgscrollView addSubview:imageView];

    }
    
    self.imgscrollView.contentSize = CGSizeMake(self.imgscrollView.frame.size.width *  self.question.ottaAnswers.count, self.imgscrollView.frame.size.height);
    
    [self scrollToPage:self.currentOption];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    
    [sender setContentOffset: CGPointMake(sender.contentOffset.x, 0)];
    
    
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.imgscrollView.frame.size.width;
    int page = floor((self.imgscrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;

    self.currentOption = page;
    OttaAnswer *answer = [self.question.ottaAnswers objectAtIndex:page];
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.optionLbl.alpha = 0.0f;
                         self.orderLbl.alpha = 0.0f;
                         self.orderLbl.text = [NSString stringWithFormat:@"%d",page+1];
                         self.optionLbl.text = answer.answerText;
                         self.optionLbl.alpha = 1.0f;
                         self.orderLbl.alpha = 1.0f;
                         
                     }];
  
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)leftBtnTapped:(id)sender {
    if (self.currentOption == 0)
        return;
    self.currentOption  -= 1;
    [self scrollToPage:self.currentOption];
}

- (IBAction)rightBtnTapped:(id)sender {
    if (self.currentOption == self.question.ottaAnswers.count -1)
        return;
    self.currentOption  += 1;
    [self scrollToPage:self.currentOption];
}

- (void)scrollToPage:(int)page {
    CGRect frame;
    frame.origin.x = self.imgscrollView.frame.size.width * page;
    frame.origin.y = 0;
    frame.size = self.imgscrollView.frame.size;
    [self.imgscrollView scrollRectToVisible:frame animated:YES];
}

- (IBAction)btnBackPress:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}

@end
