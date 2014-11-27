//
//  OttaBasicQuestionCell.m
//  Otta
//
//  Created by Gambogo on 11/18/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaBasicQuestionCell.h"

@implementation OttaBasicQuestionCell

- (void)awakeFromNib {
    // Initialization code

    self.orderLbl.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
