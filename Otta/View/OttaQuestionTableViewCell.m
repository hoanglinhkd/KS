//
//  OttaQuestionTableViewCell.m
//  Otta
//
//  Created by Steven Ojo on 9/13/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaQuestionTableViewCell.h"

@implementation OttaQuestionTableViewCell
@synthesize ottaAnswerText,addPhotoButton,addTextButton,answerImage;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
