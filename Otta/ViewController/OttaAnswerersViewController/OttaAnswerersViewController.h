

#import <UIKit/UIKit.h>
#import "OttaFriendsCell.h"
#import "OttaFriend.h"

@interface OttaAnswerersViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *follows;
@property (strong, nonatomic) NSMutableArray *optionsArray;
@property (assign, nonatomic) int selectedTimeValue;
@property (strong, nonatomic) NSString *askQuestionValue;
@property (assign, nonatomic) TimeSelection selectedDuration;
@property (weak, nonatomic) IBOutlet UIButton *btnCheck;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)btnCheckPress:(id)sender;
- (IBAction)btnBackPress:(id)sender;

@end
