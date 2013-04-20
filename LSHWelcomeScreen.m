//
//  LSHWelcomeScreen.m
//  Love Scavenger Hunt
//
//  Created by Trent Callan on 4/1/13.
//  Copyright (c) 2013 Trent Callan. All rights reserved.
//

#import "LSHWelcomeScreen.h"

@implementation LSHWelcomeScreen

@synthesize mySegmentedControl;
@synthesize dontShowWelcomeScreen;

-(void) viewDidLoad{
    
    [super viewDidLoad];
    
    dontShowWelcomeScreen = [[NSUserDefaults standardUserDefaults] boolForKey:@"dontShowWelcomeScreen"];
    NSLog(@"bool = %d", dontShowWelcomeScreen);
    
    [mySegmentedControl setFrame:CGRectMake(210, 425 ,100, 35)];
    if(dontShowWelcomeScreen && [[NSUserDefaults standardUserDefaults] boolForKey:@"fromInfoButton"]){
        mySegmentedControl.selectedSegmentIndex = 1;
    }
    else{
        
    }
    
}

- (void) viewDidAppear:(BOOL)animated{
    NSLog(@"dont show welcome screen = %d", dontShowWelcomeScreen);
    NSLog(@"fromInfoButton = %d", [[NSUserDefaults standardUserDefaults] boolForKey:@"fromInfoButton"]);
    
    if (dontShowWelcomeScreen) {
        
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"fromInfoButton"]) {
        [self performSegueWithIdentifier:@"welcomeToHunt" sender:self];
    }
    else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"fromInfoButton"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    }
}


# pragma mark IBAction Methods

- (IBAction)segmentedValueChanged:(id)sender {

    if (mySegmentedControl.selectedSegmentIndex  == 0) {
        
        
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"dontShowWelcomeScreen"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    else{
        NSLog(@"seleted 1");
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"dontShowWelcomeScreen"];
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"fromInfoButton"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}

- (IBAction)readyBtnPressed:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"fromInfoButton"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self performSegueWithIdentifier:@"welcomeToHunt" sender:self];
    
}

- (void)viewDidUnload {
    [self setMySegmentedControl:nil];
    [super viewDidUnload];
}
@end
