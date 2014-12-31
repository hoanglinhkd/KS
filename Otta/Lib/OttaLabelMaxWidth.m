//
//  OttaLabelMaxWidth.m
//  Otta
//
//  Created by gam bogo on 12/28/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaLabelMaxWidth.h"

@implementation OttaLabelMaxWidth

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    if ( self.numberOfLines == 0 )
    {
        if ( self.preferredMaxLayoutWidth != self.frame.size.width )
        {
            self.preferredMaxLayoutWidth = self.frame.size.width;
            [self setNeedsUpdateConstraints];
        }
    }
}

- (CGSize) intrinsicContentSize
{
    CGSize s = [super intrinsicContentSize];
    
    if ( self.numberOfLines == 0 )
    {
        // found out that sometimes intrinsicContentSize is 1pt too short!
        s.height += 1;
    }
    
    return s;
}


@end
