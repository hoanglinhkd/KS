//
//  OttaFindFriendsViewController.m
//  Otta
//
//  Created by Vo Cong Huy on 11/17/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaFindFriendsViewController.h"

@interface OttaFindFriendsViewController ()

@end

@implementation OttaFindFriendsViewController
NSArray *friends;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData{
    OttaFriend *f1 = [[OttaFriend alloc] initWithName:@"Jamie Moskowitz" friendStatus:true];
    OttaFriend *f2 = [[OttaFriend alloc] initWithName:@"Danny Madriz" friendStatus:false];
    OttaFriend *f3 = [[OttaFriend alloc] initWithName:@"Brandon Baer" friendStatus:true];
    OttaFriend *f4 = [[OttaFriend alloc] initWithName:@"Austin Thomas" friendStatus:true];
    OttaFriend *f5 = [[OttaFriend alloc] initWithName:@"Chloe Fulton" friendStatus:false];
    OttaFriend *f6 = [[OttaFriend alloc] initWithName:@"David Chu" friendStatus:true];
    OttaFriend *f7 = [[OttaFriend alloc] initWithName:@"Peter Carey" friendStatus:false];
    friends = [[NSArray alloc] initWithObjects:f1,f2,f3,f4,f5,f6,f7,nil];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 62.0;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIImage *btnImage;
    static NSString *cellIdentifier = @"OttaFindFriendsCellID";
    
    
    OttaFriendsCell *cell = [tableView dequeueReusableCellWithIdentifier:
                          cellIdentifier];
    
    if (cell == nil) {
        cell = [[OttaFriendsCell alloc]initWithStyle:
                UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    } else {
        OttaFriend *f = (OttaFriend *)[friends objectAtIndex:indexPath.row];
        btnImage= [UIImage imageNamed:@"OttaNumberBackground.png"];
        cell.lblText.text = f.name;
        if (f.isFriend){
            btnImage = [UIImage imageNamed:@"icon_time.png"];
        }
        [cell.btnIcon setBackgroundImage:btnImage forState:UIControlStateNormal];
    }
    return cell;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [friends count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //OttaFriendsCell *cell = (OttaFriendsCell*)[tableView cellForRowAtIndexPath:indexPath];
    
}



@end
