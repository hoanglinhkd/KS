

#import "OttaAnswerersViewController.h"
#import "OttaParseClientManager.h"
#import "MBProgressHUD.h"

@interface OttaAnswerersViewController ()
{
    OttaFriendsCell *lastCellSelected;
    NSMutableArray *friends;
    BOOL isSelectAll;
}
@end

@implementation OttaAnswerersViewController
@synthesize btnCheck;

- (void)viewDidLoad {
    [super viewDidLoad];
    isSelectAll = NO;
    //[self loadData];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadFriends];
    friends = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 57.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"OttaAnswerersCellID";
    
    OttaFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:
                          cellIdentifier];
    if (cell == nil) {
        cell = [[OttaFriendsCell alloc] initWithStyle:
                UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    PFObject *follow = _follows[indexPath.row];
    PFUser *user = follow[kTo];
    cell.lblText.text = @"";
    //[user fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
    
    NSString *name = [NSString stringWithFormat:@"%@ %@", user[kFirstName], user[kLastName]];
    OttaFriend *ottaFriend = [[OttaFriend alloc] initWithName:@"Jamie Moskowitz" selected:NO];
    ottaFriend.pfUser = user;
    [friends addObject:ottaFriend];
    cell.lblText.text = name;
    
    //}];
    
    cell.imgIcon.image = [UIImage imageNamed:@"Otta_ask_button_add_grey.png"];
    @try {
        OttaFriend *f = [friends objectAtIndex:indexPath.row];
        if (f.isSelected){
            cell.imgIcon.image = [UIImage imageNamed:@"Otta_friends_button_added.png"];
        }
    }
    @catch (NSException *exception) {
        //<#Handle an exception thrown in the @try block#>
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_follows count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    OttaFriend *f = [friends objectAtIndex:indexPath.row];
    f.isSelected = !f.isSelected;
    [tableView reloadData];
}

- (void) selectAllFriends:(BOOL)isSelect{
    for (OttaFriend *curFriend in friends) {
        curFriend.isSelected = isSelect;
    }
}

- (IBAction)btnCheckPress:(id)sender {
    isSelectAll = !isSelectAll;
    if (!isSelectAll) {
        [btnCheck setImage:[UIImage imageNamed:@"Otta_ask_box_unchecked"] forState:UIControlStateNormal];
        [self selectAllFriends:NO];
        [_tableView reloadData];
    } else {
        [btnCheck setImage:[UIImage imageNamed:@"Otta_ask_box_checked"] forState:UIControlStateNormal];
        [self selectAllFriends:YES];
        [_tableView reloadData];
    }
}

- (IBAction)btnBackPress:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) loadFriends {
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[OttaParseClientManager sharedManager] getAllFollowFromUser:[PFUser currentUser] withBlock:^(NSArray *array, NSError *error) {
        _follows = [[NSArray alloc] initWithArray:array];
        [_tableView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];

    
}

@end
