//
//  LSHViewController.h
//  Love Scavenger Hunt
//
//  Created by Trent Callan on 2/3/13.
//  Copyright (c) 2013 Trent Callan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "LSHmapPoint.h"
#import "LSHscavengerHunt.h"

@interface LSHViewController : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *myMapView;
@property (weak, nonatomic) IBOutlet UITextView *myTextView;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property LSHscavengerHunt* scavengerHunt;
@property (weak, nonatomic) IBOutlet UIButton *mapViewChangeBtn;
@property CLLocationManager* currentLocationManager;
@property int rowSelected;



- (IBAction)trackingModeChange:(UIButton*)sender;
- (IBAction)checkSpot:(id)sender;
- (IBAction)currLocationOrDestination:(UIButton*)sender;
- (IBAction)debugResetBtnPressed:(id)sender;
- (void)updateMap:(CLLocationCoordinate2D)destinationLocation;
- (IBAction)infoBtnPressed:(id)sender;
- (void)showAlertFoundLocation;
- (void)resetActiveLocation:(int) newIndex;
- (void)getUserLocation;
- (double) headingToSecondCoordinate:(CLLocationCoordinate2D) coordinate2 fromFirstCoordinate: (CLLocationCoordinate2D)coordinate1;
@end
