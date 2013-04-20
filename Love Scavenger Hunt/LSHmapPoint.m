//
//  LSHmapPoint.m
//  Love Scavenger Hunt
//
//  Created by Trent Callan on 2/3/13.
//  Copyright (c) 2013 Trent Callan. All rights reserved.
//

#import "LSHmapPoint.h"

@implementation LSHmapPoint
@synthesize description;
@synthesize coordinate;
@synthesize foundMessage;
@synthesize title;
@synthesize passcode;


- (id)initWithTitle: (NSString*) titleString description:(NSString*)descriptionMessage foundMessage: (NSString*) foundString passcode: (NSString*) passcodeString coordinateWithLattitude:(CLLocationDegrees)lattitude longitude:(CLLocationDegrees) longitude{
    
    self = [super init];
    if (self) {
        
        CLLocationCoordinate2D temp;
        temp.latitude = lattitude;
        temp.longitude = longitude;
        self.title = titleString;
        self.coordinate = temp;
        self.description = descriptionMessage;
        self.passcode = passcodeString;
        self.foundMessage = foundString;
    }
    return self;
}


- (void)encodeWithCoder: (NSCoder*) encoder{
    
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeDouble:self.coordinate.latitude forKey:@"latitude"];
    [encoder encodeDouble:self.coordinate.longitude forKey:@"longitude"];
    [encoder encodeObject:self.description forKey:@"description"];
    [encoder encodeObject:self.passcode    forKey:@"passcode"];
    [encoder encodeObject:self.foundMessage forKey:@"foundMessage"];
    
    
}

- (id)initWithCoder:(NSCoder *)decoder{
    self = [super init];
    
    if (self) {
        CLLocationCoordinate2D tmp;
        self.title = [decoder decodeObjectForKey:@"title"];
        self.description = [decoder decodeObjectForKey:@"description"];
        self.passcode = [decoder decodeObjectForKey:@"passcode"];
        self.foundMessage = [decoder decodeObjectForKey:@"foundMessage"];
        tmp.latitude = [decoder decodeDoubleForKey:@"latitude"];
        tmp.longitude = [decoder decodeDoubleForKey:@"longitude"];
        self.coordinate = tmp;
        
    }
    return self;
}


@end

