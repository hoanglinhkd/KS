

#import <UIKit/UIKit.h>
#import "OttaFriendsCell.h"
#import "OttaFriend.h"

@interface OttaAnswerersViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btnCheck;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)btnCheckPress:(id)sender;
- (IBAction)btnBackPress:(id)sender;

@end
