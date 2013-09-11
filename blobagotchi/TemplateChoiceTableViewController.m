//
//  PlayTableViewController.m
//  blobagotchi
//
//  Created by SVAD Student on 12/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TemplateChoiceTableViewController.h"
#import "HomePageAnimationViewController.h"

@implementation TemplateChoiceTableViewController
@synthesize cellChoice;
@synthesize actionAnimation;
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"theCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell.tag = 4;
    cell.textLabel.text = cellChoice;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    if (selectedCell.tag == 4) 
        [self returnToHome];
}

-(void)returnToHome
{
    self.tabBarController.selectedIndex = 0; 
    
    //self.tabBarController.selectedViewController.navigationController.idleFrames = [[NSArray alloc] init];
    //Pop View Controller to root
    [self.tabBarController.selectedViewController.navigationController popToRootViewControllerAnimated:NO];     
}
@end
