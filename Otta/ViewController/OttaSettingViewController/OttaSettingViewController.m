#import "UIViewController+ECSlidingViewController.h"
#import "OttaSettingViewController.h"

@implementation OttaSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
}

- (IBAction)btnMenuPress:(id)sender {
    [self.slidingViewController anchorTopViewToRightAnimated:YES];
}
@end
