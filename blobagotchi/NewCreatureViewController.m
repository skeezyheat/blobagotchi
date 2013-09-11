//
//  NewCreatureViewController.m
//  blobagotchi
//
//  Created by SVAD Student on 12/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NewCreatureViewController.h"
#import "Blobs.h"

@implementation NewCreatureViewController

@synthesize textField;

-(void)viewWillAppear:(BOOL)animated
{    
    Blobs *blob = [[[Blobs alloc] init] get_one];
    
    if(blob)
    {
        [self performSegueWithIdentifier: @"created" sender: self];
    }
}
-(IBAction)adoptPet:(id)sender {
    Blobs *blob = [[Blobs alloc] init];
    blob.name   = textField.text;
    blob.hunger = [NSNumber numberWithInt:10];
    blob.sleep  = [NSNumber numberWithInt:10];
    blob.play   = [NSNumber numberWithInt:10];
    blob.clean  = [NSNumber numberWithInt:10]; 
    blob.sleep_time  = [NSNumber numberWithInt:0]; 
    blob.time  = [NSNumber numberWithInt:0]; 
    
    [blob save];
}
@end
