

#import <UIKit/UIKit.h>
#import "OttaFriendsCell.h"
#import "OttaFriend.h"

@interface OttaAnswerersViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *btnCheck;

@property (weak, nonatomic) IBOutlet UIButton *btnBack;
@property (weak, nonatomic) IBOutlet UITableView *table;


@property (weak, nonatomic) IBOutlet UIButton *btnBackPress;
- (IBAction)btnCheckPress:(id)sender;
- (IBAction)btnBackPress:(id)sender;

@end
