//
//  HomePageAnimationViewController.h
//  blobagotchi
//
//  Created by SVAD Student on 12/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface HomePageAnimationViewController : UIViewController{
IBOutlet UIImageView *idleImage;
}

@property (nonatomic, retain) IBOutlet UIImageView *idleImage;
@property (nonatomic, strong) NSArray *idleFrames;

@end
