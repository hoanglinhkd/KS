//
//  OttaLoginContainerViewController.h
//  Otta
//
//  Created by Gambogo on 11/23/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum  {
    PageShowing_None = 0,
    PageShowing_IntroPage,
    PageShowing_LoginPage,
    PageShowing_JoinPage,
    PageShowing_FacebookPage
} PageShowing;

@interface OttaLoginContainerViewController : UIViewController

@property (assign) PageShowing currentPageShowing;

-(void) openLoginViewDetail;
-(void) openJoinViewDetail;
-(void) openFacebookViewDetail;

@end
