//
//  LSHscavengerHunt.m
//  Love Scavenger Hunt
//
//  Created by Trent Callan on 3/25/13.
//  Copyright (c) 2013 Trent Callan. All rights reserved.
//

#import "LSHscavengerHunt.h"

@implementation LSHscavengerHunt
@synthesize locationArray;
@synthesize finalMessage;
@synthesize activeLocationIndex;
@synthesize activeLocation;
@synthesize title;

- (id)initWithTitle: (NSString*) stringTitle FinalMessage: (NSString*) lastMessage{
    
    self = [super init];
    if (self) {
        self.locationArray = [[NSMutableArray alloc] init];
        self.finalMessage = lastMessage;
        self.activeLocationIndex = 0;
        self.title = stringTitle;
    }
    else{
        NSLog(@"object of type LSHscavengerHunt failed its super init method");
    }
    return self;
}


- (void)encodeWithCoder: (NSCoder*) encoder{
    
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.locationArray forKey:@"locationArray"];
    [encoder encodeObject:finalMessage forKey:@"finalMessage"];
    [encoder encodeObject:activeLocation forKey:@"activeLocation"];
    [encoder encodeInteger:activeLocationIndex forKey:@"activeLocationIndex"];
    
}

- (id)initWithCoder:(NSCoder *)decoder{
    
    self = [super init];
    
    if (self) {
        self.title = [decoder decodeObjectForKey:@"title"];
        self.locationArray = [decoder decodeObjectForKey:@"locationArray"];
        self.finalMessage = [decoder decodeObjectForKey:@"finalMessage"];
        self.activeLocationIndex = [decoder decodeIntegerForKey:@"activeLocationIndex"];
        self.activeLocation = [decoder decodeObjectForKey:@"activeLocation"];
    }
    return self;
}

@end