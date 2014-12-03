//
//  OttaMyQuestionFooterCell.h
//  Otta
//
//  Created by cscv on 12/2/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OttaMyQuestionFooterCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblTime;

- (IBAction)clickSeeAll:(id)sender;
@end
