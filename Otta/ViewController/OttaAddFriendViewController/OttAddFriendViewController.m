//
//  OttAddFriendViewController.m
//  Otta
//
//  Created by Thien Chau on 11/11/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttAddFriendViewController.h"
#import "OttaFriend.h"
#import "OttaFindFriendsViewController.h"

@interface OttAddFriendViewController()

@property (strong) NSMutableArray *friends;
@property (strong) NSMutableArray *searchResults;
@property (strong) NSMutableArray *selectedFriends;

@end
@implementation OttAddFriendViewController


- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"OttaSideMenuBackground.png"]];
    
    [self inittempData];
    
}

- (void)inittempData {
    _friends = [NSMutableArray array];
    _searchResults = [NSMutableArray array];
    _selectedFriends = [NSMutableArray array];
    
    NSMutableArray *names = [NSMutableArray array];
    
    [names addObject:@"Adam"];
    [names addObject:@"Adrian"];
    [names addObject:@"Alan"];
    [names addObject:@"Alexander"];
    [names addObject:@"Andrew"];
    [names addObject:@"Anthony"];
    [names addObject:@"Austin"];
    [names addObject:@"Benjamin"];
    [names addObject:@"Blake"];
    [names addObject:@"Boris"];
    [names addObject:@"Brandon"];
    [names addObject:@"Brian"];
    [names addObject:@"Cameron"];
    [names addObject:@"Carl"];
    [names addObject:@"Charles"];
    [names addObject:@"Christian"];
    [names addObject:@"Christopher"];
    [names addObject:@"Colin"];
    [names addObject:@"Connor"];
    [names addObject:@"Dan"];
    [names addObject:@"David"];
    [names addObject:@"Dominic"];
    [names addObject:@"Dylan"];
    [names addObject:@"Edward"];
    [names addObject:@"Eric"];
    [names addObject:@"Evan"];
    [names addObject:@"Frank"];
    [names addObject:@"Gavin"];
    [names addObject:@"Gordon"];
    [names addObject:@"Harry"];
    [names addObject:@"Ian"];
    [names addObject:@"Isaac"];
    [names addObject:@"Jack"];
    [names addObject:@"Jacob"];
    [names addObject:@"Jake"];
    [names addObject:@"James"];
    [names addObject:@"Jason"];
    [names addObject:@"Joe"];
    [names addObject:@"John"];
    [names addObject:@"Jonatha"];
    [names addObject:@"Joseph"];
    [names addObject:@"Joshua"];
    [names addObject:@"Julian"];
    [names addObject:@"Justin"];
    [names addObject:@"Keith"];
    [names addObject:@"Kevin"];
    [names addObject:@"Leonard"];
    [names addObject:@"Liam"];
    
    for (NSString *name in names) {
        OttaFriend *friendToAdd = [[OttaFriend alloc] initWithName:name friendStatus:NO];
        [_friends addObject:friendToAdd];
    }
}

- (IBAction)backButtonPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)checkButtonPressed:(id)sender {
    _doesAccessContact = !_doesAccessContact;
    if (_doesAccessContact) {
        [_btnCheck setBackgroundImage:[UIImage imageNamed:@"icon_check2.png"] forState:UIControlStateNormal];
    } else {
        [_btnCheck setBackgroundImage:[UIImage imageNamed:@"icon_uncheck.png"] forState:UIControlStateNormal];
    }
}

-(IBAction)btnFacebookFriendPressed:(id)sender
{
    [self performSegueWithIdentifier:@"connectFriendSegue" sender:@"FacebookFriends"];
}

-(IBAction)btnContactPressed:(id)sender
{
    [self performSegueWithIdentifier:@"connectFriendSegue" sender:@"Contacts"];
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"connectFriendSegue"]) {
        OttaFindFriendsViewController *findFriendVC = segue.destinationViewController;
        NSString *senderValue = sender;
        if([senderValue isEqualToString:@"Contacts"]) {
            findFriendVC.isFromContact = YES;
        }
    }
}

#pragma mark - Text Field

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
    textField.text = @"";
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string {
    
    NSString *substring = [NSString stringWithString:textField.text];
    substring = [substring
                 stringByReplacingCharactersInRange:range withString:string];
    [self searchWithName:substring];
    return YES;
}

- (void)searchWithName:(NSString*)searchname
{
    [_searchResults removeAllObjects];
    for(OttaFriend *friend in _friends) {
        NSRange substringRange = [[friend.name uppercaseString] rangeOfString:[searchname uppercaseString]];
        if (substringRange.location != NSNotFound) {
            [_searchResults addObject:friend];
        }
    }
    [_searchResultTableView reloadData];
}

#pragma mark tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 30.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"OttaFindFriendsCellID";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:
                UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.backgroundColor = [UIColor clearColor];
    OttaFriend *friend = [_searchResults objectAtIndex:indexPath.row];
    cell.textLabel.text = friend.name;
    cell.textLabel.textColor = [UIColor whiteColor];
    
    if ([_selectedFriends containsObject:friend]) {
        cell.accessoryView = [[ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"Otta_friends_button_added"]];
        [cell.accessoryView setFrame:CGRectMake(0, 0, 15, 15)];
    }else{
        cell.accessoryView = [[ UIImageView alloc ] initWithImage:[UIImage imageNamed:@"Otta_friends_button_add"]];
        [cell.accessoryView setFrame:CGRectMake(0, 0, 15, 15)];
    }
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _searchResults.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    OttaFriend *friend = [_searchResults objectAtIndex:indexPath.row];
    if ([_selectedFriends containsObject:friend]) {
        [_selectedFriends removeObject:friend];
    }else{
        [_selectedFriends addObject:friend];
    }
    [_searchResultTableView reloadData];
    [self updateNextButtonStatus];
    
}

- (void) updateNextButtonStatus{
    if (_selectedFriends.count > 0) {
        _btnSkipNext.titleLabel.text = [@"Next" toCurrentLanguage];
    }else{
        _btnSkipNext.titleLabel.text = [@"Skip" toCurrentLanguage];
    }
}



@end
