//
//  NewCreatureViewController.h
//  blobagotchi
//
//  Created by SVAD Student on 12/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewCreatureViewController : UIViewController

@property (atomic, strong) IBOutlet UITextField *textField;

-(IBAction)adoptPet:(id)sender;

@end
