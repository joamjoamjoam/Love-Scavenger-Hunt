//
//  LSHCompletedViewController.h
//  Love Scavenger Hunt
//
//  Created by Trent Callan on 4/3/13.
//  Copyright (c) 2013 Trent Callan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSHscavengerHunt.h"

@interface LSHCompletedViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *finalMessageTextView;
- (IBAction)resetQuestBtnPressed:(id)sender;
- (IBAction)backToTableBtnPressed:(id)sender;

@end
