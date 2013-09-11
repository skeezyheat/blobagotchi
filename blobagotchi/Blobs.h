//
//  Products.h
//  model
//
//  Created by SVAD Student on 10/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"

@class Model;

@interface Blobs : Model

@property (nonatomic, strong) NSString *database;
@property (nonatomic, strong) NSString *tableName;

@property (nonatomic, strong) NSNumber *id;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *hunger;
@property (nonatomic, strong) NSNumber *sleep;
@property (nonatomic, strong) NSNumber *play;
@property (nonatomic, strong) NSNumber *clean;
@property (nonatomic, strong) NSNumber *sleep_time;
@property (nonatomic, strong) NSNumber *time;

-(void)get_hungry;
-(void)get_fed;
-(void)go_sleep;
-(void)wake_up;
-(void)get_clean;
-(void)get_dirty;
-(void)get_bored;
-(void)played_with;
-(id)get_one;


@end
