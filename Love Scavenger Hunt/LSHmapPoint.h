//
//  LSHmapPoint.h
//  Love Scavenger Hunt
//
//  Created by Trent Callan on 2/3/13.
//  Copyright (c) 2013 Trent Callan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface LSHmapPoint : NSObject <MKAnnotation>
@property CLLocationCoordinate2D coordinate;
@property NSString* title;
@property NSString* description;
@property NSString* foundMessage;
@property NSString* passcode;


- (id)initWithTitle: (NSString*) titleString description:(NSString*)descriptionMessage foundMessage: (NSString*) foundString passcode:(NSString*) passcodeString coordinateWithLattitude:(CLLocationDegrees)lattitude longitude:(CLLocationDegrees) longitude;

- (void)encodeWithCoder: (NSCoder*) encoder;
- (id)initWithCoder:(NSCoder *)decoder;
@end
