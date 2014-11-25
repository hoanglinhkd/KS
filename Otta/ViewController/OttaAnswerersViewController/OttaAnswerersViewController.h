

#import <UIKit/UIKit.h>
#import "OttaFriendsCell.h"
#import "OttaFriend.h"

@interface OttaAnswerersViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *checkButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *btnCheckPress;
@property (weak, nonatomic) IBOutlet UIButton *btnBackPress;

@end
