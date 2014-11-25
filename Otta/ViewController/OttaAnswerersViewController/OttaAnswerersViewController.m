

#import "OttaAnswerersViewController.h"

@interface OttaAnswerersViewController ()
{
    OttaFriendsCell *lastCellSelected;
    NSMutableArray *friends;
    BOOL checked;
}
@end

@implementation OttaAnswerersViewController
@synthesize checkButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    checked = NO;
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
    OttaFriend *f1 = [[OttaFriend alloc] initWithName:@"Jamie Moskowitz" friendStatus:YES];
    OttaFriend *f2 = [[OttaFriend alloc] initWithName:@"Danny Madriz" friendStatus:NO];
    OttaFriend *f3 = [[OttaFriend alloc] initWithName:@"Brandon Baer" friendStatus:YES];
    OttaFriend *f4 = [[OttaFriend alloc] initWithName:@"Austin Thomas" friendStatus:YES];
    OttaFriend *f5 = [[OttaFriend alloc] initWithName:@"Chloe Fulton" friendStatus:NO];
    OttaFriend *f6 = [[OttaFriend alloc] initWithName:@"David Chu" friendStatus:YES];
    OttaFriend *f7 = [[OttaFriend alloc] initWithName:@"Peter Carey" friendStatus:NO];
    friends = [[NSMutableArray alloc] initWithObjects:f1,f2,f3,f4,f5,f6,f7,nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 57.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIImage *image;
    
    static NSString *cellIdentifier = @"OttaAnswerersCellID";
    
    OttaFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:
                          cellIdentifier];
    if (cell == nil) {
        cell = [[OttaFriendsCell alloc] initWithStyle:
                UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    image = [UIImage imageNamed:@"Otta_ask_button_add_grey.png"];

    
    OttaFriend *f = (OttaFriend *)[friends objectAtIndex:indexPath.row];
    cell.lblText.text = f.name;
    [cell.lblText setFont:[UIFont fontWithName:@"OpenSans-Light" size:18.00f]];
    
    if (f.isFriend || f.isSelected){
        image = [UIImage imageNamed:@"Otta_friends_button_added.png"];
    }
    
    [cell.imgIcon setImage:image];
    
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [friends count];
}

- (void) selectAllFriends:(BOOL) isSelect{
    for (OttaFriend *curFriend in friends) {
        curFriend.isSelected = isSelect;
    }
}

- (IBAction)btnCheckPress:(id)sender {
    if (checked) {
        [checkButton setImage:[UIImage imageNamed:@"Otta_ask_box_unchecked"] forState:UIControlStateNormal];
        checked = NO;
        [self selectAllFriends:NO];
        [self.tableView reloadData];
    } else {
        [checkButton setImage:[UIImage imageNamed:@"Otta_ask_box_checked"] forState:UIControlStateNormal];
        checked = YES;
        [self selectAllFriends:YES];
        [self.tableView reloadData];
    }
}

- (IBAction)btnBackPress:(id)sender:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
