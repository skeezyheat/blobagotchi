//
//  Model.h
//  model
//
//  Created by SVAD Student on 10/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface Model : NSObject

@property (nonatomic, strong) NSString *database;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *tableName;

-(NSArray *)loadColumns;
-(FMDatabase *)loadDatabase;
-(BOOL *)save;
-(NSArray *)find;

-(void)makeTable:(NSString *)table WithCode:(NSString *)code;


@end
