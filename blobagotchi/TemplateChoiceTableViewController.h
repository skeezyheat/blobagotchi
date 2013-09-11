//
//  TemplateChoiceTableViewController.h
//  blobagotchi
//
//  Created by SVAD Student on 12/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TemplateChoiceTableViewController : UITableViewController

@property (strong, atomic) NSString *cellChoice;
@property (strong, atomic) NSArray *actionAnimation; 
-(void)returnToHome;

@end
