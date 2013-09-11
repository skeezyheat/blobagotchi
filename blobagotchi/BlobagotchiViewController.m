//
//  BlobagotchiViewController.m
//  blobagotchi
//
//  Created by SVAD Student on 11/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BlobagotchiViewController.h"
#import "Blobs.h"

@implementation BlobagotchiViewController

-(void)viewWillAppear:(BOOL)animated {
    Blobs *blob = [[Blobs alloc] init];

    NSArray *blobs_array = [blob find];
    
    NSNumber *counter = [NSNumber numberWithInt:0];

    for(Blobs *blo in blobs_array)
    {
        counter = [NSNumber numberWithInt:[counter intValue] + 1];
    }
    if([counter intValue] == 0)
    {
        Blobs *blob = [[Blobs alloc] init];
        blob.name   = @"Bob";
        blob.hunger = [NSNumber numberWithInt:10];
        blob.sleep  = [NSNumber numberWithInt:10];
        blob.play   = [NSNumber numberWithInt:10];
        blob.clean  = [NSNumber numberWithInt:10]; 
        blob.sleep_time  = [NSNumber numberWithInt:0]; 
        blob.time  = [NSNumber numberWithInt:0]; 
        
        [blob save];
    }
    else
    {
        Blobs *single = [blobs_array objectAtIndex:0];
        [single wake_up];        
    }
    
    
}

@end
