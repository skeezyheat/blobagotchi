//
//  Model.m
//  model
//
//  Created by SVAD Student on 10/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FMDatabase.h"
#import "Model.h"

@implementation Model

@synthesize tableName, type, database;

-(id)init {
    self = [super init];
    if(self)
    {
        self.type = @"sqlite3";
    }
    return self;
}

/**
 * Loads the declared database
 *
 * @return FMDatabase A Flying Meat database instance of the database.
 */
-(FMDatabase *)loadDatabase {
	// get the path to the Documents directory
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
	// the Documents directory will always be the first element in the array if you specify NSDocumentDirectory in the line above
	NSString *documentsDirectory = [paths objectAtIndex:0];
    
	// create a pathname to the writeable database
	NSString *pathToDb = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@", self.database, self.type]]; 
        
    return [FMDatabase databaseWithPath:pathToDb];
}

-(void)makeTable:(NSString *)table WithCode:(NSString *)code{
    FMDatabase *db = [self loadDatabase];
    
    [db open];
    NSString *tableCheck = @"SELECT * FROM main.sqlite_master WHERE type='table';";
    FMResultSet *tbl_fmrs = [db executeQuery:tableCheck];
    
    BOOL newTable = TRUE;
    
    while([tbl_fmrs next])
    {
        if([[tbl_fmrs stringForColumn:@"tbl_name"] isEqualToString:table])
        {
            newTable = FALSE;
        }
    }

    if(newTable)
    {
       [db executeUpdate:code];
    }
    [db close];
}
/**
 * Gets an array of column names within this table.
 *
 * @return NSArray an array of dictionary items with the format (name=>column_name, type=>cast_type)
 */
-(NSArray *)loadColumns {
    //Load the database
    FMDatabase *db = [self loadDatabase];
    
    //This call will get all column names and types.
    NSString *cols = [[NSString alloc] initWithFormat:@"PRAGMA table_info(%@)", self.tableName];
    [db open];
    FMResultSet *col_fmrs = [db executeQuery:cols];
    NSMutableArray *set = [[NSMutableArray alloc] init];
    while([col_fmrs next])
    {
        // Build a dictionary with name, type declarations.
        NSString *name = [col_fmrs stringForColumn:@"name"];
        NSString *cast = [col_fmrs stringForColumn:@"type"];
        NSMutableDictionary *col_info = [[NSMutableDictionary alloc] init];
        [col_info setValue:name forKey:@"name"];
        [col_info setValue:cast forKey:@"type"];
        
        NSDictionary *returnDict = [[NSDictionary alloc] initWithDictionary:col_info];
        
        // Set that dictionary in the array
        [set addObject:returnDict];
    }
    [db close];
    
    NSArray *returnArray = [[NSArray alloc] initWithArray:set];
    return returnArray;
}
/**
 * Selects every row in a specific table.
 *
 * @return Returns an array of the called class containing NSObjects filled with column parameters.
 */
-(NSArray *)find {
    // Load the database.
    FMDatabase *db = [self loadDatabase];
    // Get the columns
    NSArray *columns = [self loadColumns];

    NSString *query = [[[NSString alloc]initWithString: @"SELECT * FROM "] stringByAppendingString:self.tableName];

    
    [db open];
    FMResultSet *fmrs = [db executeQuery:query];
    
    NSMutableArray *classObjectsInArray = [[NSMutableArray alloc] init];
    
    while([fmrs next]) {
        // Create a new instance of whatever child class was called.
        id called_class = [[[self class] alloc] init];
        
        // Go through the column array and get the name/value pairs
        for(NSString *column in columns) {
            NSString *name = [column valueForKey:@"name"];
            NSString *value = [column valueForKey:@"type"];
            
            // If the value is an integer init the class item (name) with an int.
            if([value isEqualToString:@"integer"])
            {
                [called_class setValue:[[NSNumber alloc] initWithInt:[fmrs intForColumn:name]] forKey:name];
            }
            // Else init with a string (don't really have much in this part as of yet.
            else
            {
                [called_class setValue:[fmrs stringForColumn:name] forKey:name];
            }
        }
        // Add that object to the set array
        [classObjectsInArray addObject:called_class];
    }
    [db close];
    
    // Return the set array
    NSArray *returnArray = [[NSArray alloc] initWithArray:classObjectsInArray];
    return returnArray;
}

/**
 * Saves the object to the database. If the id parameter is nil, then it creates a new row. Otherwise, it upadates
 * the row with the coorisponding id.
 *
 * @return BOOL YES on save, NO if something went wrong.
 */
-(BOOL)save {
    // Grab the database
    FMDatabase *db = [self loadDatabase];
    // Grab the column
    NSArray *columns = [self loadColumns];
    
    // Init an empty string to build the query.
    NSString *query = [[NSString alloc] init];
    
    // If the id is nil then it's a new record
    if([self valueForKey:@"id"] == nil)
    {
        // Create a columns and values array
        NSMutableArray *columnArray = [[NSMutableArray alloc] init];
        NSMutableArray *valuesArray = [[NSMutableArray alloc] init];
        
        // Loop through the columns dictionary
        for(NSDictionary *column in columns)
        {
            // If it's not the array, then add that key and value to the column and values arrays (respectively)
            if(![[column valueForKey:@"name"] isEqualToString:@"id"])
            {
                [columnArray addObject:[column valueForKey:@"name"]];
                
                // If the value is a string, don't put quotes around it, if it's not, then do.
                if([[column valueForKey:@"type"] isEqualToString:@"integer"])
                {
                    [valuesArray addObject:[self valueForKey:[column valueForKey:@"name"]]];                
                }
                else
                {
                    [valuesArray addObject:[NSString stringWithFormat:@"'%@'", [self valueForKey:[column valueForKey:@"name"]]]];                
                }
            }
            else
            {
                [columnArray addObject:[column valueForKey:@"name"]];
                // If the value is a string, don't put quotes around it, if it's not, then do.
                [valuesArray addObject:[NSNumber numberWithInt:1]];                
            }
        }
        
        // Join the arrays together with commas.
        NSString *columnString = [columnArray componentsJoinedByString:@", "];
        NSString *valuesString = [valuesArray componentsJoinedByString:@", "];
        
        // Build the insert query
        query = [NSString stringWithFormat:@"INSERT INTO %@(%@) VALUES (%@)", self.tableName, columnString, valuesString];
    }
    // Or else it's an update to an existing row.
    else
    {
        // Create a mutable array to build from.
        NSMutableArray *columnArray = [[NSMutableArray alloc] init];
        
        // Loop through the column dictionary.
        for(NSDictionary *column in columns)
        {
            // If it's not the id then get that columns updated information.
            if(![[column valueForKey:@"name"] isEqualToString:@"id"])
            {
                // Quotes on string, not on ints.
                if([[column valueForKey:@"type"] isEqualToString:@"integer"])
                {
                    [columnArray addObject:[NSString stringWithFormat:@"%@ = %@", [column valueForKey:@"name"], [self valueForKey:[column valueForKey:@"name"]]]];                    
                }
                else
                {
                    [columnArray addObject:[NSString stringWithFormat:@"%@ = %@", [column valueForKey:@"name"], [NSString stringWithFormat:@"'%@'", [self valueForKey:[column valueForKey:@"name"]]]]];
                }
            }
        }
        
        // Concat with commas
        NSString *columnString = [columnArray componentsJoinedByString:@", "];
        
        // Build the update query
        query = [NSString stringWithFormat:@"UPDATE %@ SET %@ WHERE id=%@", self.tableName, columnString, [self valueForKey:@"id"]];
    }
    
    
    
    // Open the database, execute the query, and return the response.
    [db open];
    
    BOOL returnBool =  [db executeUpdate:query];
    
    [db close];
    
    return returnBool;
}

@end
