//
//  MyScrollView.m
//  adfasdfasdfasdfasdf
//
//  Created by Linh.Nguyen on 6/10/13.
//  Copyright (c) 2013 InnoTech. All rights reserved.
//

#import "MyScrollView.h"

@implementation MyScrollView
@synthesize myDelegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    //DLog(@"DEBUG: Touches began" );
    
    //UITouch *touch = [[event allTouches] anyObject];
    
    [super touchesBegan:touches withEvent:event];
    if ([self.myDelegate respondsToSelector:@selector(myScrollView:touchBegan:withEvent:)]) {
        [self.myDelegate myScrollView:self touchBegan:touches withEvent:event];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //DLog(@"DEBUG: Touches cancelled");
    
    // Will be called if something happens - like the phone rings
    
    //UITouch *touch = [[event allTouches] anyObject];
    
    [super touchesCancelled:touches withEvent:event];
    
}


- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //DLog(@"DEBUG: Touches moved" );
    
    //UITouch *touch = [[event allTouches] anyObject];
    
    [super touchesMoved:touches withEvent:event];
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    //DLog(@"DEBUG: Touches ending" );
    //Get all the touches.
    NSSet *allTouches = [event allTouches];
    
    //Number of touches on the screen
    switch ([allTouches count])
    {
        case 1:
        {
            //Get the first touch.
            UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
            
            switch([touch tapCount])
            {
                case 1://Single tap
                    
                    break;
                case 2://Double tap.
                    
                    break;
            }
        }
            break;
    }
    [super touchesEnded:touches withEvent:event];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
