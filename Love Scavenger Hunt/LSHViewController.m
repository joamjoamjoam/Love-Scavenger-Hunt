//
//  LSHViewController.m
//  Love Scavenger Hunt
//
//  Created by Trent Callan on 2/3/13.
//  Copyright (c) 2013 Trent Callan. All rights reserved.
//

#define METERS_PER_MILE 1609.344
#import "LSHViewController.h"
#import "LSHscavengerHunt.h"

@interface LSHViewController ()

@end
@implementation LSHViewController
@synthesize myMapView;
@synthesize myTextView;
@synthesize distanceLabel;
@synthesize scavengerHunt;
@synthesize mapViewChangeBtn;
@synthesize currentLocationManager;
@synthesize rowSelected;
const double METERS_TO_MILES = .000621371;


// fix up finishing Screen

// create new objects for my unique hunt for heather

// set up object for hunt in table viw cell selected method

// make sure all hunts persist



- (void)viewDidLoad
{
   [super viewDidLoad];
    rowSelected = [[NSUserDefaults standardUserDefaults] integerForKey:@"Row"];
    
    // load the recieved scavengerHunt object and activeLocationIndex
    NSData* myDecodedObject = [[NSUserDefaults standardUserDefaults] objectForKey:@"activeHunt"];
    NSArray* activeHuntArray = [NSKeyedUnarchiver unarchiveObjectWithData:myDecodedObject];
    
    
    scavengerHunt = [activeHuntArray objectAtIndex:rowSelected];
    
    
    currentLocationManager = [[CLLocationManager alloc] init];
    currentLocationManager.delegate = self;
    currentLocationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [currentLocationManager startUpdatingLocation];
    
    // add all locations
    
    
    
    
    scavengerHunt.activeLocation = [scavengerHunt.locationArray objectAtIndex:scavengerHunt.activeLocationIndex];
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

-(void) viewDidAppear:(BOOL)animated{
    if (scavengerHunt.activeLocationIndex == ([scavengerHunt.locationArray count] -1)) {
        [self performSegueWithIdentifier:@"mapToCompleted" sender:self];
    }
    
}


#pragma mark IBAction Methods


- (IBAction)checkSpot:(id)sender {
    
    CLLocation* location = myMapView.userLocation.location;
    CLLocation* currentDestination = [[CLLocation alloc] initWithLatitude:scavengerHunt.activeLocation.coordinate.latitude longitude:scavengerHunt.activeLocation.coordinate.longitude];
    
    // get distance from current location to point
    CLLocationDistance distance =([location distanceFromLocation:currentDestination] * METERS_TO_MILES);
    
    // distance is closer than 10 ft
    if (distance <= .002 && scavengerHunt.activeLocationIndex != ([scavengerHunt.locationArray count]-1)) {
        [self getUserLocation];
        distanceLabel.text = @"Location Found";
        [self showAlertFoundLocation];
    }
    else if(distance <= .002 && scavengerHunt.activeLocationIndex == ([scavengerHunt.locationArray count]-1)){
        [self getUserLocation];
        distanceLabel.text = @"Location Found";
        [self showAlertFoundLocation];
        // this is the final location and it has been found
        //display finish screen
        
    }
    else{
        [self getUserLocation];
    }
}

- (IBAction)trackingModeChange:(UIButton*)sender {
    if([sender.titleLabel.text isEqualToString:@"Heading Up"]){
        
        [myMapView setUserTrackingMode:MKUserTrackingModeFollowWithHeading animated:YES];
        
        [sender setTitle:@"North Up" forState:UIControlStateNormal];
    }
    else{
        [myMapView setUserTrackingMode:MKUserTrackingModeNone animated:YES];
        [sender setTitle:@"Heading Up" forState:UIControlStateNormal];
    }
}

- (IBAction)infoBtnPressed:(id)sender {
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"fromInfoButton"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self performSegueWithIdentifier:@"huntToWelcome" sender:self];
    
}

- (IBAction)currLocationOrDestination:(UIButton*)sender {
    
    
    if ([sender.titleLabel.text isEqualToString:@"My Location"]) {
        
        CLLocationCoordinate2D location = myMapView.userLocation.location.coordinate;
        [sender setTitle:@"Destination" forState:UIControlStateNormal];
        
        [self updateMap:location];
    }
    else if ([sender.titleLabel.text isEqualToString:@"Show Destination"]){
        [sender setTitle:@"My Location" forState:UIControlStateNormal];
        [self updateMap:scavengerHunt.activeLocation.coordinate];
    }
    else{
        
        // decrepit function
        
    }
}




#pragma mark Helper Functions

-(void)updateMap:(CLLocationCoordinate2D)destinationLocation{
    
    double heading, mapDistanceLongitude = 0, mapDistanceLattitude = 0;
    MKCoordinateRegion locationViewReion;
    CLLocationCoordinate2D mapCenterPoint;
    
    CLLocation* currentDestination = [[CLLocation alloc] initWithLatitude:destinationLocation.latitude longitude:destinationLocation.longitude];
    
    
    
    // get distance from current location to point
    CLLocationDistance distance =([currentLocationManager.location distanceFromLocation:currentDestination] * METERS_TO_MILES);
    if (distance <= .15) {
        distance = distance * 5280;
        distanceLabel.text = [[NSString alloc] initWithFormat:@"You are %.2f feet away",distance];
    }
    else{
    distanceLabel.text = [[NSString alloc] initWithFormat:@"You are %.2f miles away",distance];
    }
    
    NSLog(@"distance = %f", distance);
    
    mapCenterPoint.latitude = ((destinationLocation.latitude + currentLocationManager.location.coordinate.latitude)/2);
    mapCenterPoint.longitude = ((destinationLocation.longitude + currentLocationManager.location.coordinate.longitude)/2);
    
    heading = [self headingToSecondCoordinate:currentDestination.coordinate fromFirstCoordinate:currentLocationManager.location.coordinate];
    
    
    if (heading == 90 || heading == 180 || heading == 270 || heading == 0) {
        mapDistanceLongitude = distance;
        mapDistanceLattitude = distance;
    }
    else{
        mapDistanceLongitude = ABS(((currentLocationManager.location.coordinate.longitude - destinationLocation.longitude) * 53.1));
        mapDistanceLattitude = ABS(((destinationLocation.latitude - currentLocationManager.location.coordinate.latitude) * 68.99));
    }
    
    //if (distance) {
        locationViewReion = MKCoordinateRegionMakeWithDistance(mapCenterPoint, (mapDistanceLattitude * METERS_PER_MILE), (mapDistanceLongitude * METERS_PER_MILE));
    //}
    //else{
        //NSLog(@"else region");
        //locationViewReion = MKCoordinateRegionMakeWithDistance(mapCenterPoint, (.9 * distance * METERS_PER_MILE),(.9*distance * METERS_PER_MILE));
    //}
    
    
    [myMapView addAnnotation:scavengerHunt.activeLocation];
    [myMapView setRegion:locationViewReion];
    
    
    
    
}




- (void)showAlertFoundLocation{
    
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"Location Found" message:@"Please enter the passcode you found at your location to verify you have found what you are looking for." delegate:self cancelButtonTitle:@"Verify Location" otherButtonTitles:nil, nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert textFieldAtIndex:0].keyboardType = UIKeyboardTypeNumberPad;
    [alert show];
}


- (void)resetActiveLocation:(int) newIndex{
    
    [myMapView removeAnnotation:scavengerHunt.activeLocation];
    scavengerHunt.activeLocation = [[scavengerHunt locationArray]objectAtIndex:newIndex];
    [self getUserLocation];
}


-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation
          fromLocation:(CLLocation *)oldLocation{
    if ( (newLocation.coordinate.latitude - oldLocation.coordinate.latitude) <= .1){
        [manager stopUpdatingLocation];
        NSLog(@"desired accuracy acheived.\nlattitude = %f\nlongitude = %f",newLocation.coordinate.latitude,newLocation.coordinate.longitude);
        [self updateMap:[scavengerHunt.activeLocation coordinate]];
        
    }
    else{
        NSLog(@"Accuracy too low still fixing on location.");
    }
}

-(void) getUserLocation{
    [currentLocationManager startUpdatingLocation];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.alertViewStyle == UIAlertViewStylePlainTextInput){
        UIAlertView* secondAlert;
        if(([[[alertView textFieldAtIndex:0] text] isEqualToString:scavengerHunt.activeLocation.passcode])){
            if (scavengerHunt.activeLocationIndex == (scavengerHunt.locationArray.count - 1)) {
                secondAlert = [[UIAlertView alloc] initWithTitle:@"Last Location Found" message:scavengerHunt.activeLocation.foundMessage delegate:self cancelButtonTitle:@"Congratulations on finishing your Quest!" otherButtonTitles:nil, nil];
                [secondAlert show];
                [self performSegueWithIdentifier:@"mapToCompleted" sender:self];
                
                
                
            }
            else{
                scavengerHunt.activeLocationIndex++;
                NSArray* encodedArray = [[NSArray alloc] initWithObjects:scavengerHunt, nil];
                NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject: encodedArray];
                [[NSUserDefaults standardUserDefaults] setObject:myEncodedObject forKey:@"activeHunt"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                [self resetActiveLocation:scavengerHunt.activeLocationIndex];
                secondAlert = [[UIAlertView alloc] initWithTitle:@"Passcode Accepted" message:scavengerHunt.activeLocation.foundMessage delegate:self cancelButtonTitle:@"On to the next Location" otherButtonTitles:nil, nil];
                [secondAlert show];
            }
        }
        else{
            secondAlert = [[UIAlertView alloc] initWithTitle:@"Passcode Denied" message:@"Please look for your passcode hidden somewhere in your location. Press Check Spot to reenter your passcode." delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil, nil];
            [secondAlert show];
        }
    }
}

- (double)headingToSecondCoordinate:(CLLocationCoordinate2D)coordinate2 fromFirstCoordinate:(CLLocationCoordinate2D)coordinate1{
    double heading;
    
    //convert incoming lat/longs into radians
    double dLon = coordinate2.longitude - coordinate1.longitude;
	double y = sin(dLon) * cos(coordinate2.latitude);
	double x = cos(coordinate1.latitude) * sin(coordinate2.latitude) - sin(coordinate1.latitude) * cos(coordinate2.latitude) * cos(dLon);
    
    heading = ABS(((atan2(y, x))* 180)/3.14);
    
    return heading;
}

#pragma mark Debug Functions

- (IBAction)debugResetBtnPressed:(id)sender {
    
    scavengerHunt.activeLocationIndex = 0;
    NSArray* encodedArray = [[NSArray alloc] initWithObjects:scavengerHunt, nil];
    NSData *myEncodedObject = [NSKeyedArchiver archivedDataWithRootObject: encodedArray];
    [[NSUserDefaults standardUserDefaults] setObject:myEncodedObject forKey:@"activeHunt"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self resetActiveLocation:scavengerHunt.activeLocationIndex];
    
}



#pragma mark View Lifecycle
- (void)viewDidUnload {
    [self setMyMapView:nil];
    [self setMyTextView:nil];
    [self setDistanceLabel:nil];
    [self setMapViewChangeBtn:nil];
    [super viewDidUnload];
}
@end
