

#import "OttaAnswerersViewController.h"
#import "OttaParseClientManager.h"

#import "OttaAnswer.h"
#import "NSDate-Utilities.h"
#import "OttaAlertManager.h"

@interface OttaAnswerersViewController ()
{
    OttaFriendsCell *lastCellSelected;
    NSMutableDictionary *friends;
    NSMutableArray *listSelected;
    BOOL isSelectAll;
}
@end

@implementation OttaAnswerersViewController
@synthesize btnCheck;

- (void)viewDidLoad {
    [super viewDidLoad];
    isSelectAll = NO;
    listSelected = [NSMutableArray array];
    //[self loadData];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadFriends];
    friends = [NSMutableDictionary dictionary];
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
    PFUser *user = follow[kFrom];
    cell.lblText.text = @"";
    
    PFUser *f = [friends objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
    if(f == nil) {
        [user fetchIfNeededInBackgroundWithBlock:^(PFObject *object, NSError *error) {
            NSString *name = [NSString stringWithFormat:@"%@ %@", user[kFirstName], user[kLastName]];
            [user setName:name];
            [friends setObject:user forKey:[NSString stringWithFormat:@"%d",indexPath.row]];
            cell.lblText.text = name;
        }];
    } else {
        cell.lblText.text = [f name];
    }
    
    cell.imgIcon.image = [UIImage imageNamed:@"Otta_ask_button_add_grey.png"];
    @try {
        if ([f isSelected]){
            cell.imgIcon.image = [UIImage imageNamed:@"Otta_friends_button_added.png"];
        }
    }
    @catch (NSException *exception) {
        
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_follows count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PFUser *f = [friends objectForKey:[NSString stringWithFormat:@"%d",indexPath.row]];
    if(![f isSelected]) {
        [f setIsSelected:YES];
        [listSelected addObject:f];
    } else {
        [f setIsSelected:NO];
        [listSelected removeObject:f];
    }
    
    if(isSelectAll) {
        isSelectAll = NO;
        [btnCheck setImage:[UIImage imageNamed:@"Otta_ask_box_unchecked"] forState:UIControlStateNormal];
    }
    [tableView reloadData];
}

- (void) selectAllFriends:(BOOL)isSelect{
    
    [listSelected removeAllObjects];
    
    NSArray *allUsers = [friends allValues];
    for (PFUser *curFriend in allUsers) {
        [curFriend setIsSelected:isSelect];
        [listSelected addObject:curFriend];
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

-(IBAction)btnBackPress:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(IBAction)btnAskPress:(id)sender{
    
    if (!isSelectAll && listSelected.count <= 0) {
        [[OttaAlertManager sharedManager] showSimpleAlertWithContent:[@"Please select your friends" toCurrentLanguage] complete:nil];
        return;
    }
    
    if([OttaNetworkManager isOfflineShowedAlertView]) {
        return;
    }
    
    [[OttaLoadingManager sharedManager] show];
    
    OttaQuestion* question = [[OttaQuestion alloc] init];
    question.questionText = _askQuestionValue;
    question.ottaAnswers = _optionsArray;
    
    if(_selectedDuration == TimeSelection_Days) {
         question.expTime = [NSDate dateWithDaysFromNow:_selectedTimeValue];
    } else if(_selectedDuration == TimeSelection_Hours) {
         question.expTime = [NSDate dateWithHoursFromNow:_selectedTimeValue];
    } else if(_selectedDuration == TimeSelection_Minutes) {
         question.expTime = [NSDate dateWithMinutesFromNow:_selectedTimeValue];
    } else if(_selectedDuration == TimeSelection_Weeks) {
        question.expTime = [NSDate dateWithWeeksFromNow:_selectedTimeValue];
    } else if(_selectedDuration == TimeSelection_Months) {
        question.expTime = [NSDate dateWithMonthsFromNow:_selectedTimeValue];
    }
    
    question.isPublic = isSelectAll;
    if(!isSelectAll) {
        question.responders = listSelected;
    }
    
    
    [[OttaParseClientManager sharedManager] addQuestion:question withBlock:^(BOOL isSucceeded, NSError *error) {
        if(isSucceeded) {
            [[OttaAlertManager sharedManager] showSimpleAlertOnView:self.view withContent:[@"Sent" toCurrentLanguage] complete:^{
                
                if ([_delegate respondsToSelector:@selector(askSuccessed)]) {
                    [_delegate askSuccessed];
                }
                
                [[OttaLoadingManager sharedManager] hide];
                [self dismissViewControllerAnimated:YES completion:nil];
            }];
        } else {
            
            [[OttaLoadingManager sharedManager] hide];
            [[OttaAlertManager sharedManager] showSimpleAlertOnView:self.view withContent:[@"Ask failed" toCurrentLanguage] complete:nil];
        }
        
    }];
    
}
- (void) loadFriends {
    
    if([OttaNetworkManager isOfflineShowedAlertView]) {
        return;
    }
    
    [[OttaLoadingManager sharedManager] show];
    [[OttaParseClientManager sharedManager] getAllFollowToUser:[PFUser currentUser] withBlock:^(NSArray *array, NSError *error) {
        _follows = [[NSArray alloc] initWithArray:array];
        [_tableView reloadData];
        [[OttaLoadingManager sharedManager] hide];
    }];
    
}


@end
