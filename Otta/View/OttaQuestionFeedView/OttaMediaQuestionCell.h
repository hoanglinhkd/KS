//
//  OttaMediaQuestionCell.h
//  Otta
//
//  Created by Gambogo on 11/18/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaBasicQuestionCell.h"

@interface OttaMediaQuestionCell : OttaBasicQuestionCell

@property (weak, nonatomic) IBOutlet UIImageView *customImageView;

@property (weak, nonatomic) IBOutlet UIButton *collapseBtn;
@property (weak, nonatomic) IBOutlet UIButton *viewAllBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collapseHeghtConstraint;
@property (weak, nonatomic) IBOutlet UIButton *imageBtn;
@property (weak, nonatomic) IBOutlet UIButton *imageBtnTapped;

@end