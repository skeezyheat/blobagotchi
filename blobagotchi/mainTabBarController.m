//
//  mainTabBarController.m
//  blobagotchi
//
//  Created by SVAD Student on 12/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "mainTabBarController.h"
#import "Blobs.h"

@implementation mainTabBarController
@synthesize checkInterval;
-(void)viewWillAppear:(BOOL)animated {
    checkInterval = [NSNumber numberWithInt:0];
    [self startTimer];
}
- (void) startTimer {
    [NSTimer scheduledTimerWithTimeInterval:1 
                                     target:self 
                                   selector:@selector(tick:) 
                                   userInfo:nil
                                    repeats:YES];
}

- (void) tick:(NSTimer *) timer {
    checkInterval = [NSNumber numberWithInt:checkInterval.intValue + 1];
    if(checkInterval.intValue > 10)
    {
        Blobs *blob = [[[Blobs alloc] init] get_one];
        blob.hunger = [NSNumber numberWithInt:blob.hunger.intValue -1];
        blob.sleep  = [NSNumber numberWithInt:blob.sleep.intValue -1];
        blob.play   = [NSNumber numberWithInt:blob.play.intValue -1];
        blob.clean  = [NSNumber numberWithInt:blob.clean.intValue -1]; 
        
        [blob save];
       checkInterval = [NSNumber numberWithInt:0];
    }
    
}
@end
