//
//  OttaMyQuestionPictureCell.h
//  Otta
//
//  Created by cscv on 12/2/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <UIKit/UIKit.h>

@class OttaMyQuestionPictureCell;

@protocol OttaMyQuestionPictureCellDelegate <NSObject>

- (void)optionCell:(OttaMyQuestionPictureCell *)cell imageBtnTappedAtRow:(NSInteger)row;

@end

@interface OttaMyQuestionPictureCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblOrderNumber;
@property (weak, nonatomic) IBOutlet UILabel *lblText;
@property (weak, nonatomic) IBOutlet UIImageView *imageViewData;
@property (weak, nonatomic) id <OttaMyQuestionPictureCellDelegate>delegate;
@property (strong, nonatomic) NSIndexPath *indexPathCell;
@end
