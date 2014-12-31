
#import "UIViewController+ECSlidingViewController.h"
#import "OttaAboutViewController.h"

@implementation OttaAboutViewController

- (IBAction)btnMenuPress:(id)sender {
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}
@end
