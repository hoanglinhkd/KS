//
//  OttaMyQuestionTextCell.m
//  Otta
//
//  Created by cscv on 12/2/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaMyQuestionTextCell.h"

@implementation OttaMyQuestionTextCell

- (void)awakeFromNib {
    // Initialization code
    self.lblOrderNumber.clipsToBounds = YES;
    //self.lblOrderNumber.layer.cornerRadius = 10.0;
    //self.lblOrderNumber.hidden = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
