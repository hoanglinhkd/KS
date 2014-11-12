//
//  SideMenuViewController.m
//  Otta
//
//  Created by Steven Ojo on 7/27/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "SideMenuViewController.h"
#import "OttaMenuCell.h"

@interface SideMenuViewController ()

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
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)unwindToSideMenu:(UIStoryboardSegue *)unwindSegue
{


}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75.0;
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
    
    switch (indexPath.row) {
        case 0:
        {
            cell.imageView.image = [UIImage imageNamed:@"menu_question.png"];
            cell.lblText.text = @"Ask a question";
        }
            break;
            
        default:
            break;
    }
    
    return cell;
}

@end
