//
//  PlayTableViewController.m
//  blobagotchi
//
//  Created by SVAD Student on 12/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PlayTableViewController.h"
#import "Blobs.h"

@implementation PlayTableViewController

-(void)viewWillAppear:(BOOL)animated
{
    super.cellChoice = @"Play with Pet";
}

-(void)returnToHome {
    [super returnToHome];
    [[[Blobs alloc] init] played_with];
}
@end
