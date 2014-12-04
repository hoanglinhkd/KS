//
//  OttaMyQuestionFooterCell.m
//  Otta
//
//  Created by cscv on 12/2/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaMyQuestionFooterCell.h"

@implementation OttaMyQuestionFooterCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)clickSeeAll:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(ottaMyQuestionFooterCellDidSelectSeeAllAtIndex:atCurrentIndex:)]) {
        [self.delegate ottaMyQuestionFooterCellDidSelectSeeAllAtIndex:self.referIndex atCurrentIndex:self.currIndex];
    }
}
@end
