//
//  JHFetcher.m
//  Kolumbus
//
//  Created by Finn Gaida on 13.09.14.
//  Copyright (c) 2014 Jugend Hackt. All rights reserved.
//

#import "JHCommunicator.h"

@implementation JHCommunicator

+ (NSDictionary *)getSuggestionsFrom:(NSDate *)startDate until:(NSDate *)endDate visitedCount:(int)visits budgetClass:(int)budget visitIntensity:(int)intensity {
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://niklas-mbp.local:3000/v1/"]];
    
    [manager GET:@"suggestions" parameters:@{@"starts_at" : startDate, @"ends_at" : endDate, @"visited_count" : [NSString stringWithFormat:@"%i", visits], @"budget_class" : [NSString stringWithFormat:@"%i", budget], @"visit_intensity" : [NSString stringWithFormat:@"%i", intensity]} success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSError *error;
        result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        
        NSLog(@"Response: %@", responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"Error: %@", error.description);
        
    }];
    
    return [NSDictionary new];
    
}

+ (NSDictionary *)getSearch:(NSString *)query coordinates:(CLLocation *)location {
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://niklas-mbp.local:3000/v1/"]];
    
    NSDictionary __block *result;
    
    [manager GET:@"search" parameters:@{@"q" : query, @"accomodation_lat" : [NSString stringWithFormat:@"%f", location.coordinate.latitude], @"accomodation_lng" : [NSString stringWithFormat:@"%f", location.coordinate.longitude]} success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSError *error;
        result = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:&error];
        
        NSLog(@"Response: %@", result);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        result = @{@"error" : error.description};
        
        NSLog(@"Error: %@", error.description);
        
    }];
    
    if (result) {
        return result;
    } else {
        return @{@"error" : @"no dict"};
    }
}

+ (NSDictionary *)getFinalTrip {
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://niklas-mbp.local:3000/v1/"]];
    
    [manager GET:@"final_trip" parameters:@[@"spots"] success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"Response: %@", responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"Error: %@", error.description);
        
    }];
    
    return [NSDictionary new];
    
}

@end
