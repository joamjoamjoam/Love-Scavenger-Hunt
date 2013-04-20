//
//  LSHTableViewController.h
//  Love Scavenger Hunt
//
//  Created by Trent Callan on 4/5/13.
//  Copyright (c) 2013 Trent Callan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSHmapPoint.h"
#import "LSHscavengerHunt.h"

@interface LSHTableViewController : UITableViewController <UITableViewDataSource, UITableViewDelegate>

@property NSMutableArray* huntArray;


@end
