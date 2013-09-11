//
//  FeedTableViewController.m
//  blobagotchi
//
//  Created by SVAD Student on 12/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FeedTableViewController.h"
#import "Blobs.h"

@implementation FeedTableViewController

-(void)viewWillAppear:(BOOL)animated
{
    super.cellChoice = @"Feed Pet";
    
    super.actionAnimation = [[NSArray alloc] initWithObjects:
                                [UIImage imageNamed:@"youngest_eating_1.png"],
                                [UIImage imageNamed:@"youngest_eating_2.png"],
                                [UIImage imageNamed:@"youngest_eating_3.png"],
                                nil];
}

-(void)returnToHome {
    [super returnToHome];
    [[[Blobs alloc] init] get_fed];
}


@end
