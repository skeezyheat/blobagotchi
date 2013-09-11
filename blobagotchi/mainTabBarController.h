//
//  mainTabBarController.h
//  blobagotchi
//
//  Created by SVAD Student on 12/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface mainTabBarController : UITabBarController

@property (atomic, strong) NSNumber *checkInterval;

- (void) startTimer;

- (void) tick:(NSTimer *) timer;


@end
