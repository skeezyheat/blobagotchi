//
//  Products.m
//  model
//
//  Created by SVAD Student on 10/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Model.h"
#import "Blobs.h"

@implementation Blobs

@synthesize tableName, database, id, name, sleep, clean, hunger, play, sleep_time, time;

-(id)init {
    self = [super init];
    if(self)
    {
        database  = @"blobagotchi";
        tableName = @"blobagotchi";
        [self makeTable:@"blobagotchi" WithCode:@"CREATE TABLE blobagotchi (id interger primary key, name varchar(255), hunger integer, sleep interger, play interger, clean interger, sleep_time interger(255), time interger(255))"];

    }
    
    return self;
}

-(void)get_fed {
    Blobs *blob = [[[Blobs alloc] init] get_one];
    if(blob.hunger.intValue < 10)
    {
        blob.hunger   = [NSNumber numberWithInt:blob.hunger.intValue + 1];        
        [blob save];
    }
}

-(void)played_with {
    Blobs *blob = [[[Blobs alloc] init] get_one];
    if(blob.play.intValue < 10)
    {
        blob.play   = [NSNumber numberWithInt:blob.play.intValue + 1];        
        [blob save];
    }
    
}

-(void)get_clean {
    Blobs *blob = [[[Blobs alloc] init] get_one];
    if(blob.clean.intValue < 10)
    {
        blob.clean   = [NSNumber numberWithInt:blob.clean.intValue + 1];        
        [blob save];
    }
}
-(void)go_sleep {
    Blobs *blob = [[[Blobs alloc] init] get_one];
    if([blob.sleep_time intValue] == 0)
    {
        int timestamp = [[NSDate date] timeIntervalSince1970];
        blob.sleep_time = [NSNumber numberWithInt:timestamp];
        [self save];
    }
}
-(void)wake_up {
    Blobs *blob = [[[Blobs alloc] init] get_one];
    if([blob.sleep_time intValue] != 0)
    {
        int timestamp = [[NSDate date] timeIntervalSince1970];
        int slept_since = [sleep_time intValue];
        
        blob.sleep_time = [NSNumber numberWithInt:0];
        
        int time_sleeping = timestamp - slept_since;
        
        [self save];
    }
    
}
-(void)get_hungry {
    int value = [hunger intValue];
    if(value > 0)
    {
        hunger = [NSNumber numberWithInt:value - 1];
        [self save];        
    }
}
-(void)get_dirty {
    int value = [clean intValue];
    if(value < 0)
    {
        clean = [NSNumber numberWithInt:value - 1];
        [self save];
    }
}
-(void)get_bored {
    int value = [play intValue];
    if(value < 0)
    {
        play = [NSNumber numberWithInt:value - 1];
        [self save];
    }
}

-(id)get_one {
    Blobs *blob = [[Blobs alloc] init];
    NSArray *blobs_array = [blob find];
    
    NSNumber *counter = [NSNumber numberWithInt:0];
    
    Blobs *single = nil;
    
    for(Blobs *blo in blobs_array)
    {
        counter = [NSNumber numberWithInt:[counter intValue] + 1];
    }
    if([counter intValue] > 0)
    {
        single = [blobs_array objectAtIndex:0];
    }
    
    return single;
}

@end
