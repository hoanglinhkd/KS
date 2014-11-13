//
//  OttaQuestionTableViewCell.h
//  Otta
//
//  Created by Steven Ojo on 9/13/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OttaQuestionTableViewCell : UITableViewCell

@property (nonatomic,strong)IBOutlet UIButton * addPhotoButton;
@property (nonatomic,strong)IBOutlet UIButton * addTextButton;
@property (nonatomic,strong)IBOutlet UITextView * ottaAnswerText;
@property (nonatomic,strong)IBOutlet UIImageView * answerImage;

@end
