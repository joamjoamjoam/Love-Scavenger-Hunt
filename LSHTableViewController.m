//
//  LSHTableViewController.m
//  Love Scavenger Hunt
//
//  Created by Trent Callan on 4/5/13.
//  Copyright (c) 2013 Trent Callan. All rights reserved.
//

#import "LSHTableViewController.h"


@implementation LSHTableViewController
@synthesize huntArray;

// load an array of all the scavenger hunt objects and return count to rowsInSction

// persist activeHUNT
-(void) viewDidLoad{
    NSData* myDecodedObject = [[NSUserDefaults standardUserDefaults] objectForKey:@"activeHunt"];
    NSArray* activeHuntArray = [NSKeyedUnarchiver unarchiveObjectWithData:myDecodedObject];
    
    
    if ([activeHuntArray count]) {
        huntArray = [[NSMutableArray alloc] initWithObjects:[activeHuntArray objectAtIndex:0], nil];
    }
    else{
        LSHscavengerHunt* scavengerHunt = [[LSHscavengerHunt alloc] initWithTitle:@"My First Hunt" FinalMessage:@"Congrats baby I love you so so much i am so happy to be married to you and i cant wait until i get to see yo so come home :)"];
        LSHscavengerHunt* scavengerHunt2 = [[LSHscavengerHunt alloc] initWithTitle:@"My First Hunt" FinalMessage:@"Congrats baby I love you so so much i am so happy to be married to you and i cant wait until i get to see yo so come home :)"];
        
        LSHmapPoint* firstLocation = [[LSHmapPoint alloc] initWithTitle: @"May Ranch Hill" description:@"First Location" foundMessage: @"you found it"  passcode:@"001" coordinateWithLattitude:(CLLocationDegrees)33.971961 longitude:(CLLocationDegrees)-117.382876];
        LSHmapPoint* secondLocation = [[LSHmapPoint alloc] initWithTitle: @"Random Second" description:@"Second Location" foundMessage: @"you found it" passcode:@"002" coordinateWithLattitude:33.970734 longitude:-117.383037];
        LSHmapPoint* thirdLocation = [[LSHmapPoint alloc] initWithTitle: @"Random third" description:@"Third Location" foundMessage: @"you found it" passcode:@"003" coordinateWithLattitude:33.970556 longitude:-117.381642];
        
        [scavengerHunt.locationArray addObject:firstLocation];
        [scavengerHunt.locationArray addObject:secondLocation];
        [scavengerHunt.locationArray addObject:thirdLocation];
        
        [scavengerHunt2.locationArray addObject:firstLocation];
        [scavengerHunt2.locationArray addObject:secondLocation];
        [scavengerHunt2.locationArray addObject:thirdLocation];
        
        huntArray = [[NSMutableArray alloc] initWithObjects:scavengerHunt,scavengerHunt2, nil];
    }
    
}



#pragma mark TableView Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // keep count of how many hunts are being loaded and return number here
    
    
    return [huntArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    
    cell.textLabel.text =  [[huntArray objectAtIndex:indexPath.row] title]; // scavengerHunt.title
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger) section{
    return @"Recieved Hunts";
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // return hunt selected from array of hunts receieved
    
    [[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:@"Row"];
    
    
    // have to encode to NSData to be able to store activeHunt
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject:huntArray];
    
    [[NSUserDefaults standardUserDefaults] setObject:myEncodedObject forKey:@"activeHunt"];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self performSegueWithIdentifier:@"tableToStart" sender:self];
    
    
}




@end
