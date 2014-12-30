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
#import "OttaParseClientManager.h"

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
    
    if(_showFromPage == ShowFromPage_QuestionFeed) {
        PFUser *asker = _question[kAsker];
        self.ownerNameLbl.text = [NSString stringWithFormat:@"%@ %@",asker.firstName, asker.lastName];
        self.questionbl.text = _question[kQuestionText];
    } else {
        NSString *questionText = _question[kQuestionText];
        self.ownerNameLbl.text = questionText;
        int sumAnswers = 0;
        for (PFObject *ans in _question[kAnswers]) {
            NSArray *listVotes = _question[ans.objectId];
            sumAnswers += [listVotes count];
        }
        [self.questionbl setText:[NSString stringWithFormat:[@"%d answers so far" toCurrentLanguage], sumAnswers]];
    }
    
    NSDate * now = [NSDate date];
    if([now compare:_question[kExpTime]] == NSOrderedDescending) {
        [self.expirationDateLbl setHidden:YES];
        [self.hourglass setHidden:YES];
    } else {
        self.expirationDateLbl.text = [OttaUlti timeAgo:_question[kExpTime]];
    }
    
    
    NSArray *arrAnswers = [NSArray arrayWithArray:_question[kAnswers]];
    
    PFObject *answer = ((PFObject*)[arrAnswers objectAtIndex:0]);
    if(_showFromPage == ShowFromPage_MyQuestion) {
        
        NSInteger voteUsersCount = [_question[answer.objectId] count];
        [_selectBtn setHidden:YES];
        NSString *text = [NSString stringWithFormat:@"%@ - %d",answer[kDescription], voteUsersCount];
        NSRange range = [text rangeOfString:@"-" options:NSBackwardsSearch]; //Fix for show wrong counter colors
        range.length = text.length - range.location;
        
        NSMutableAttributedString *mutable = [[NSMutableAttributedString alloc] initWithString:text];
        [mutable addAttribute: NSForegroundColorAttributeName value:kDefaultColorBackGround range:range];
        [self.optionLbl setAttributedText:mutable];
        
    } else { //Show from Question Feed
        if(_selectedCell.selectedIndexPath && _selectedCell.selectedIndexPath.row == self.currentOption) {
            self.orderLbl.backgroundColor = [UIColor orangeColor];
            [self.selectBtn setTitle:[@"Selected" toCurrentLanguage] forState:UIControlStateNormal];
        } else {
            self.orderLbl.backgroundColor = kDefaultColorBackGround;
            [self.selectBtn setTitle:[@"Select?" toCurrentLanguage] forState:UIControlStateNormal];
        }
        self.optionLbl.text = answer[kDescription];
    }
    
    answer = nil;
    for (int i = 0; i < arrAnswers.count; i++) {
        answer = [arrAnswers objectAtIndex:i];
        CGRect frame;
        frame.origin.x = self.imgscrollView.frame.size.width * i;
        frame.origin.y = 0;
        frame.size = self.imgscrollView.frame.size;
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        __weak UIImageView *imageShowing = imageView;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        [imageView setClipsToBounds:YES];
        
        NSURL *url = [NSURL URLWithString:((PFFile*)answer[kImage]).url];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        //UIImage *placeholderImage = [UIImage imageNamed:@"OttaLandingTopLogo.png"];
        
        //Indicator
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] init];
        indicator.center = imageView.center;
        indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [indicator startAnimating];
        if (((PFFile*)answer[kImage]).url.length > 0){
            //Lazy loading image
            [imageView setImageWithURLRequest:request
                             placeholderImage:nil
                                      success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
                                          
                                          imageShowing.image = image;
                                          [indicator stopAnimating];
                                      } failure:nil];
        }
        
        
        
        [self.imgscrollView addSubview:imageView];
        [self.imgscrollView addSubview:indicator];
        
    }
    
    self.imgscrollView.contentSize = CGSizeMake(self.imgscrollView.frame.size.width *  arrAnswers.count, self.imgscrollView.frame.size.height);
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
    [self setVisisbleButton];
    PFObject *answer = [_question[kAnswers] objectAtIndex:page];
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.optionLbl.alpha = 0.0f;
                         self.orderLbl.alpha = 0.0f;
                         self.orderLbl.text = [NSString stringWithFormat:@"%d",page+1];
                         self.optionLbl.alpha = 1.0f;
                         self.orderLbl.alpha = 1.0f;
                         if(_showFromPage == ShowFromPage_MyQuestion) {
                             
                             NSInteger voteUsersCount = [_question[answer.objectId] count];
                             [_selectBtn setHidden:YES];
                             NSString *text = [NSString stringWithFormat:@"%@ - %d",answer[kDescription], voteUsersCount];
                             NSRange range = [text rangeOfString:@"-" options:NSBackwardsSearch]; //Fix for show wrong counter colors
                             range.length = text.length - range.location;
                             
                             NSMutableAttributedString *mutable = [[NSMutableAttributedString alloc] initWithString:text];
                             [mutable addAttribute: NSForegroundColorAttributeName value:kDefaultColorBackGround range:range];
                             [self.optionLbl setAttributedText:mutable];
                             
                         } else { //Show from Question Feed
                             if(_selectedCell.selectedIndexPath && _selectedCell.selectedIndexPath.row == self.currentOption) {
                                 self.orderLbl.backgroundColor = [UIColor orangeColor];
                                 [self.selectBtn setTitle:[@"Selected" toCurrentLanguage] forState:UIControlStateNormal];
                             } else {
                                 self.orderLbl.backgroundColor = kDefaultColorBackGround;
                                 [self.selectBtn setTitle:[@"Select?" toCurrentLanguage] forState:UIControlStateNormal];
                             }
                             self.optionLbl.text = answer[kDescription];
                         }
                         
                         
                     }];
    
}


- (IBAction)leftBtnTapped:(id)sender {
    if (self.currentOption == 0)
        return;
    self.currentOption  -= 1;
    [self scrollToPage:self.currentOption];
}

- (IBAction)rightBtnTapped:(id)sender {
    if (self.currentOption == [_question[kAnswers] count] -1)
        return;
    self.currentOption  += 1;
    [self scrollToPage:self.currentOption];
}

- (void)scrollToPage:(NSInteger)page {
    [self setVisisbleButton];
    CGRect frame;
    frame.origin.x = self.imgscrollView.frame.size.width * page;
    frame.origin.y = 0;
    frame.size = self.imgscrollView.frame.size;
    
    if(_showFromPage == ShowFromPage_MyQuestion) {
        [_selectBtn setHidden:YES];
        
    } else { //Question Feed
        if(_selectedCell.selectedIndexPath && _selectedCell.selectedIndexPath.row == self.currentOption) {
            self.orderLbl.backgroundColor = [UIColor orangeColor];
            [self.selectBtn setTitle:[@"Selected" toCurrentLanguage] forState:UIControlStateNormal];
        } else {
            self.orderLbl.backgroundColor = kDefaultColorBackGround;
            [self.selectBtn setTitle:[@"Select?" toCurrentLanguage] forState:UIControlStateNormal];
        }
    }
    [self.imgscrollView scrollRectToVisible:frame animated:YES];
}

- (IBAction)btnBackPress:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (IBAction)btnSelectPress:(id)sender
{
    [_selectedCell selectAnswerIndex:self.currentOption];
    [self.navigationController popViewControllerAnimated:TRUE];
}

- (void) setVisisbleButton{
    _leftBtn.hidden = FALSE;
    _rightBtn.hidden = FALSE;
    if (self.currentOption == 0){
        _leftBtn.hidden = TRUE;
    }
    if (self.currentOption == [_question[kAnswers] count] -1){
        _rightBtn.hidden = TRUE;
    }

}

@end
