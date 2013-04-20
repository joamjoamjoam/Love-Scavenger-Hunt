//
//  LSHWelcomeScreen.h
//  Love Scavenger Hunt
//
//  Created by Trent Callan on 4/1/13.
//  Copyright (c) 2013 Trent Callan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSHWelcomeScreen : UIViewController

@property (weak, nonatomic) IBOutlet UISegmentedControl *mySegmentedControl;
@property bool dontShowWelcomeScreen;

- (IBAction)segmentedValueChanged:(id)sender;
- (IBAction)readyBtnPressed:(id)sender;


@end
