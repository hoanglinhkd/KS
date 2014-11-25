

#import "OttaAnswerersViewController.h"

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
    [self loadData];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData{
    OttaFriend *f1 = [[OttaFriend alloc] initWithName:@"Jamie Moskowitz" selected:YES];
    OttaFriend *f2 = [[OttaFriend alloc] initWithName:@"Danny Madriz" selected:NO];
    OttaFriend *f3 = [[OttaFriend alloc] initWithName:@"Brandon Baer" selected:YES];
    OttaFriend *f4 = [[OttaFriend alloc] initWithName:@"Austin Thomas" selected:YES];
    OttaFriend *f5 = [[OttaFriend alloc] initWithName:@"Chloe Fulton" selected:NO];
    OttaFriend *f6 = [[OttaFriend alloc] initWithName:@"David Chu" selected:YES];
    OttaFriend *f7 = [[OttaFriend alloc] initWithName:@"Peter Carey" selected:NO];
    friends = [[NSMutableArray alloc] initWithObjects:f1,f2,f3,f4,f5,f6,f7,nil];
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
    
    OttaFriend *f = [friends objectAtIndex:indexPath.row];
    cell.lblText.text = f.name;
    
    if (f.isSelected){
        cell.imgIcon.image = [UIImage imageNamed:@"Otta_friends_button_added.png"];
    } else {
        cell.imgIcon.image = [UIImage imageNamed:@"Otta_ask_button_add_grey.png"];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [friends count];
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

@end
