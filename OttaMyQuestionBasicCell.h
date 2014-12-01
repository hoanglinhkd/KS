//
//  OttaMyQuestionBasicCell.h
//  Otta
//
//  Created by cscv on 12/1/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OttaMyQuestionBasicCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UITableView*   tvData;
@property (nonatomic, weak) IBOutlet UILabel*       lblTitle;


- (void)setData:(NSArray*)data;

@end
