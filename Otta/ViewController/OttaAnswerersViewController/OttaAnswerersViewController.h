

#import <UIKit/UIKit.h>
#import "OttaFriendsCell.h"
#import "OttaFriend.h"

@protocol OttaAnswerersViewControllerDelegate <NSObject>

-(void) askSuccessed;

@end

@interface OttaAnswerersViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) NSArray *follows;
@property (strong, nonatomic) NSMutableArray *optionsArray;
@property (assign, nonatomic) NSInteger selectedTimeValue;
@property (strong, nonatomic) NSString *askQuestionValue;
@property (assign, nonatomic) TimeSelection selectedDuration;
@property (weak, nonatomic) IBOutlet UIButton *btnCheck;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) id<OttaAnswerersViewControllerDelegate> delegate;

- (IBAction)btnCheckPress:(id)sender;
- (IBAction)btnBackPress:(id)sender;

@end
