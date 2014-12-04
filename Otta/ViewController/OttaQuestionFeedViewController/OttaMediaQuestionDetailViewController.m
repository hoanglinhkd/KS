//
//  OttaMediaQuestionDetailViewController.m
//  Otta
//
//  Created by Thien Chau on 11/30/14.
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

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.questionbl.text = self.question.questionText;
    self.optionLbl.text = ((OttaAnswer*)[self.question.ottaAnswers objectAtIndex:0]).answerText;
    OttaAnswer *answer;
    
    for (int i = 0; i < self.question.ottaAnswers.count; i++) {
        answer = [self.question.ottaAnswers objectAtIndex:i];
        CGRect frame;
        frame.origin.x = self.imgscrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.imgscrollView.frame.size;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [imageView setClipsToBounds:YES];
        
        NSURL *url = [NSURL URLWithString:answer.imageURL];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        UIImage *placeholderImage = [UIImage imageNamed:@"OttaLandingTopLogo.png"];
        
        //Indicator
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] init];
        indicator.center = imageView.center;
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [indicator startAnimating];
        
        //Lazy loading image
        [imageView setImageWithURLRequest:request
                             placeholderImage:nil
                                      success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                          
                                          imageView.image = image;
                                          [indicator stopAnimating];
                                      } failure:nil];
        
        
        [self.imgscrollView addSubview:imageView];
        [self.imgscrollView addSubview:indicator];

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
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.optionLbl.alpha = 0.0f;
                         self.orderLbl.alpha = 0.0f;
                         self.orderLbl.text = [NSString stringWithFormat:@"%d",page+1];
                         self.optionLbl.text = answer.answerText;
                         self.optionLbl.alpha = 1.0f;
                         self.orderLbl.alpha = 1.0f;
                         
                     }];
  
}


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
