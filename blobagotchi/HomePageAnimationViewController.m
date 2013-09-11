//
//  HomePageAnimationViewController.m
//  blobagotchi
//
//  Created by SVAD Student on 12/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HomePageAnimationViewController.h"

@implementation HomePageAnimationViewController
@synthesize idleImage;
@synthesize idleFrames;

- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidLoad];    
    //setup animation
    if (!idleFrames) {
        idleFrames = [[NSArray alloc] initWithObjects:
                      [UIImage imageNamed:@"youngest_idle.png"],
                      [UIImage imageNamed:@"youngest_idle_side_left.png"],
                      [UIImage imageNamed:@"youngest_idle.png"],
                      [UIImage imageNamed:@"youngest_idle_side_right.png"],
                      nil];
//        idleFrames = [[NSArray alloc] initWithObjects:
//                      [UIImage imageNamed:@"youngest_eating_1.png"],
//                      [UIImage imageNamed:@"youngest_eating_2.png"],
//                      [UIImage imageNamed:@"youngest_eating_3.png"],
//                      nil];
//        idleImage.animationDuration = .5;
        idleImage.animationDuration = 5;
        idleImage.animationRepeatCount = 0;
        
    }
    else{
        
        
    }
    
    idleImage.animationImages = idleFrames;
    [idleImage startAnimating];
}



@end
