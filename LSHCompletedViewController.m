//
//  LSHCompletedViewController.m
//  Love Scavenger Hunt
//
//  Created by Trent Callan on 4/3/13.
//  Copyright (c) 2013 Trent Callan. All rights reserved.
//

#import "LSHCompletedViewController.h"

@implementation LSHCompletedViewController
@synthesize finalMessageTextView;

-(void) viewDidLoad{
    LSHscavengerHunt* scavengerHunt = [[NSUserDefaults standardUserDefaults] objectForKey:@"activeHunt"];
    
    finalMessageTextView.text = scavengerHunt.finalMessage;

}


- (IBAction)resetQuestBtnPressed:(id)sender {
    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"activeLocationIndex"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"dontShowWelcomeScreen"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"fromInfoButton"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [self performSegueWithIdentifier:@"completedToStart" sender:self];
}

- (IBAction)backToTableBtnPressed:(id)sender {
    
    [self performSegueWithIdentifier:@"completedToTable" sender:self];
    
    
}
- (void)viewDidUnload {
    [self setFinalMessageTextView:nil];
    [super viewDidUnload];
}
@end
