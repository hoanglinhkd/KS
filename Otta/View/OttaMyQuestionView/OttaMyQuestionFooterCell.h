//
//  OttaMyQuestionFooterCell.h
//  Otta
//
//  Created by cscv on 12/2/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OttaMyQuestionFooterCellDelegate <NSObject>

- (void)ottaMyQuestionFooterCellDidSelectSeeAllAtIndex:(int)referIndex atCurrentIndex:(NSInteger)currIndex;

@end

@interface OttaMyQuestionFooterCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@property (strong, nonatomic) IBOutlet UIButton *btnSeeAll;

@property (nonatomic, assign) id <OttaMyQuestionFooterCellDelegate>delegate;
@property (nonatomic, assign) int referIndex;
@property (nonatomic, assign) NSInteger currIndex;
- (IBAction)clickSeeAll:(id)sender;
@end
