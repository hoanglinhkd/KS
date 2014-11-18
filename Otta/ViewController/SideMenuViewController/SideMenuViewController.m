//
//  SideMenuViewController.m
//  Otta
//
//  Created by Steven Ojo on 7/27/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "SideMenuViewController.h"


@interface SideMenuViewController ()
{
    OttaMenuCell *lastCellSelected;
    int selectedSideIndex;
}

@end

@implementation SideMenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"OttaSideMenuBackground.png"]];
    self.menuTableView.backgroundColor = [UIColor clearColor];
    // Do any additional setup after loading the view.
    
    selectedSideIndex = 0;
}

-(void)highlightAboutButton
{
    if (lastCellSelected) {
        [lastCellSelected.lblText setFont:[UIFont fontWithName:@"OpenSans-Light" size:18.00f]];
    }
    [_btnAbout.titleLabel setFont:[UIFont fontWithName:@"OpenSans-Bold" size:18.00f]];
}

-(void) dehighlightAboutButton
{
    [_btnAbout.titleLabel setFont:[UIFont fontWithName:@"OpenSans-Light" size:18.00f]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)btnAboutTapped:(id)sender
{
    [self highlightAboutButton];
}

- (IBAction)unwindToSideMenu:(UIStoryboardSegue *)unwindSegue
{
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 62.0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"OttaMenuCellID";
    
    
    OttaMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:
                          cellIdentifier];
    
    if (cell == nil) {
        cell = [[OttaMenuCell alloc]initWithStyle:
                UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    if(selectedSideIndex == indexPath.row) {
        [cell.lblText setFont:[UIFont fontWithName:@"OpenSans-Bold" size:18.00f]];
    } else {
        [cell.lblText setFont:[UIFont fontWithName:@"OpenSans-Light" size:18.00f]];
    }
    
    switch (indexPath.row) {
        case 0:
        {
            cell.imgIcon.image = [UIImage imageNamed:@"menu_question.png"];
            cell.lblText.text = [@"Ask a question" toCurrentLanguage];
        }
            break;
        case 1:
        {
            cell.imgIcon.image = [UIImage imageNamed:@"menu_home.png"];
            cell.lblText.text = [@"Question feed" toCurrentLanguage];
        }
            break;
        case 2:
        {
            cell.imgIcon.image = [UIImage imageNamed:@"menu_mail.png"];
            cell.lblText.text = [@"My questions" toCurrentLanguage];
        }
            break;
        case 3:
        {
            cell.imgIcon.image = [UIImage imageNamed:@"menu_heart.png"];
            cell.lblText.text = [@"Friends" toCurrentLanguage];
        }
            break;
        case 4:
        {
            cell.imgIcon.image = [UIImage imageNamed:@"menu_weel.png"];
            cell.lblText.text = [@"Settings" toCurrentLanguage];
        }
            break;
            
        default:
            break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

/*- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 cell.backgroundColor = [UIColor clearColor];
 cell.textLabel.backgroundColor = [UIColor clearColor];
 cell.detailTextLabel.backgroundColor = [UIColor clearColor];
 }
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self dehighlightAboutButton];
    OttaMenuCell *cell = (OttaMenuCell*)[tableView cellForRowAtIndexPath:indexPath];
    lastCellSelected = cell;
    [cell.lblText setFont:[UIFont fontWithName:@"OpenSans-Bold" size:18.00f]];
    [self performSegueWithIdentifier:@"segueAskQuestion" sender:nil];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    OttaMenuCell *cell = (OttaMenuCell*)[tableView cellForRowAtIndexPath:indexPath];
    [cell.lblText setFont:[UIFont fontWithName:@"OpenSans-Light" size:18.00f]];
}

@end
