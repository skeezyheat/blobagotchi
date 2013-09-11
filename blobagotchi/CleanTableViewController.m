//
//  CleanTableViewController.m
//  blobagotchi
//
//  Created by SVAD Student on 12/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CleanTableViewController.h"
#import "Blobs.h"

@implementation CleanTableViewController

-(void)viewWillAppear:(BOOL)animated
{
    super.cellChoice = @"Clean Pet";
}

-(void)returnToHome {
    [super returnToHome];
    [[[Blobs alloc] init] get_clean];
}

@end
