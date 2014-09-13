//
//  JHFetcher.h
//  Kolumbus
//
//  Created by Finn Gaida on 13.09.14.
//  Copyright (c) 2014 Jugend Hackt. All rights reserved.
//

#import "AFNetworking.h"
#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>

@interface JHCommunicator : NSObject

+ (NSDictionary *)getSuggestionsFrom:(NSDate *)startDate until:(NSDate *)endDate visitedCount:(int)visits budgetClass:(int)budget visitIntensity:(int)intensity;
+ (NSDictionary *)getSearch:(NSString *)query coordinates:(CLLocation *)location;
+ (NSDictionary *)getFinalTrip;

@end
