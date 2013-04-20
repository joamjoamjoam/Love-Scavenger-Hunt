//
//  LSHscavengerHunt.h
//  Love Scavenger Hunt
//
//  Created by Trent Callan on 3/25/13.
//  Copyright (c) 2013 Trent Callan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSHmapPoint.h"

@interface LSHscavengerHunt : NSObject

@property NSString* finalMessage;
@property NSMutableArray* locationArray;
@property NSString* title;
@property int activeLocationIndex;
@property LSHmapPoint* activeLocation;


- (id)initWithTitle: (NSString*) stringTitle FinalMessage: (NSString*) lastMessage;
- (void)encodeWithCoder: (NSCoder*) encoder;
- (id)initWithCoder:(NSCoder *)decoder;

@end
