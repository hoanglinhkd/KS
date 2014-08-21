//
//  OttaAnswerTableController.m
//  Otta
//
//  Created by Steven Ojo on 8/21/14.
//  Copyright (c) 2014 SojoDigital. All rights reserved.
//

#import "OttaAnswerTableController.h"

@implementation OttaAnswerTableController
@synthesize ottaAnswers;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [ottaAnswers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    if([[ottaAnswers objectAtIndex:indexPath.row] isKindOfClass:[OttaAnswer class]])
    {
        OttaAnswer * ottaAnswer = [ottaAnswers objectAtIndex:indexPath.row];
        
        cell.textLabel.text = ottaAnswer.answerText;
        
        if(ottaAnswer.answerImage !=nil)
            cell.imageView.image = ottaAnswer.answerImage;
        else
            [cell.imageView setHidden:YES];
 
    }
    
    else
    {
        [ottaAnswers removeObjectAtIndex:indexPath.row];
        [tableView reloadData];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove the row from data model
    [ottaAnswers removeObjectAtIndex:indexPath.row];
    
    // Request table view to reload
    [tableView reloadData];
}

@end
