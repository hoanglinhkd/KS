//
//  OttAddFriendViewController.m
//  Otta
//
//  Created by Thien Chau on 11/11/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttAddFriendViewController.h"

@interface OttAddFriendViewController()

@property (strong) NSMutableArray *friends;
@property (strong) NSMutableArray *searchResults;
@property (strong) NSMutableArray *selectedFriends;

@end
@implementation OttAddFriendViewController


- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"OttaSideMenuBackground.png"]];
    
    
    _friends = [NSMutableArray array];
    _searchResults = [NSMutableArray array];
    _selectedFriends = [NSMutableArray array];
    
    [_friends addObject:@"Adam"];
    [_friends addObject:@"Adrian"];
    [_friends addObject:@"Alan"];
    [_friends addObject:@"Alexander"];
    [_friends addObject:@"Andrew"];
    [_friends addObject:@"Anthony"];
    [_friends addObject:@"Austin"];
    [_friends addObject:@"Benjamin"];
    [_friends addObject:@"Blake"];
    [_friends addObject:@"Boris"];
    [_friends addObject:@"Brandon"];
    [_friends addObject:@"Brian"];
    [_friends addObject:@"Cameron"];
    [_friends addObject:@"Carl"];
    [_friends addObject:@"Charles"];
    [_friends addObject:@"Christian"];
    [_friends addObject:@"Christopher"];
    [_friends addObject:@"Colin"];
    [_friends addObject:@"Connor"];
    [_friends addObject:@"Dan"];
    [_friends addObject:@"David"];
    [_friends addObject:@"Dominic"];
    [_friends addObject:@"Dylan"];
    [_friends addObject:@"Edward"];
    [_friends addObject:@"Eric"];
    [_friends addObject:@"Evan"];
    [_friends addObject:@"Frank"];
    [_friends addObject:@"Gavin"];
    [_friends addObject:@"Gordon"];
    [_friends addObject:@"Harry"];
    [_friends addObject:@"Ian"];
    [_friends addObject:@"Isaac"];
    [_friends addObject:@"Jack"];
    [_friends addObject:@"Jacob"];
    [_friends addObject:@"Jake"];
    [_friends addObject:@"James"];
    [_friends addObject:@"Jason"];
    [_friends addObject:@"Joe"];
    [_friends addObject:@"John"];
    [_friends addObject:@"Jonatha"];
    [_friends addObject:@"Joseph"];
    [_friends addObject:@"Joshua"];
    [_friends addObject:@"Julian"];
    [_friends addObject:@"Justin"];
    [_friends addObject:@"Keith"];
    [_friends addObject:@"Kevin"];
    [_friends addObject:@"Leonard"];
    [_friends addObject:@"Liam"];
    
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
    for(NSString *friendName in _friends) {
        NSRange substringRange = [friendName rangeOfString:searchname];
        if (substringRange.location != NSNotFound) {
            [_searchResults addObject:friendName];
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
    NSString *name = [_searchResults objectAtIndex:indexPath.row];
    cell.textLabel.text = name;
    cell.textLabel.textColor = [UIColor whiteColor];
    
    if ([_selectedFriends containsObject:name]) {
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
    NSString *selectedName = [_searchResults objectAtIndex:indexPath.row];
    if ([_selectedFriends containsObject:selectedName]) {
        [_selectedFriends removeObject:selectedName];
    }else{
        [_selectedFriends addObject:selectedName];
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
