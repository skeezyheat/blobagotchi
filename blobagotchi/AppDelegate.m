//
//  AppDelegate.m
//  blobagotchi
//
//  Created by SVAD Student on 11/26/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    return YES;
}
-(void)createEditableCopyOfDatabaseIfNeeded:(NSString *)dbName {
	/* *** AUTHORS:       adapted by Jon Friskics from work by Justin Taylor
     *** WHERE IT GOES: copy this method into your AppDelegate.m file
     *** WHERE TO CALL: call this method from applicationDidFinishLaunchingWithOptions:
     *** CODE TO CALL:  [self createEditableCopyOfDatabaseIfNeeded:@"NAME_OF_DB"];
     */
    
	// define a boolean variable to check if the copy is successful later on in the method
	BOOL dbExists;
    
	// define an object to access the app filesystem
	NSFileManager *fileManager = [NSFileManager defaultManager];
    
	// define an object to hold potential errors
	NSError *error;
    
	// get the path to the Documents directory
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
	// the Documents directory will always be the first element in the array if you specify NSDocumentDirectory in the line above
	NSString *documentsDirectory = [paths objectAtIndex:0];
    
	// create a pathname to the writeable database
	NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:dbName];
    
	// dbExists will be true(YES) if the a copy of the database already exists
	dbExists = [fileManager fileExistsAtPath:writableDBPath];
    
	// if the database already exists, leave this function
	if (dbExists) return;
	
	// if we get this far then we know there is no database in the Documents directory, so setup a path to the initial database included in the main app bundle
	NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:dbName];
    
	// copy from the app bundle to the Documents directory, and throw an error if that fails
	dbExists = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    
	// if that operation fails too, then push out the error for debugging
	if (!dbExists) {
		NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
	}
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
