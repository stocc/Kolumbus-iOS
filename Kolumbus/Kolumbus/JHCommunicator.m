//
//  JHFetcher.m
//  Kolumbus
//
//  Created by Finn Gaida on 13.09.14.
//  Copyright (c) 2014 Jugend Hackt. All rights reserved.
//

#import "JHCommunicator.h"

@implementation JHCommunicator

+ (void)getSuggestionsAt:(CLLocation *)location from:(NSDate *)startDate until:(NSDate *)endDate visitedCount:(int)visits budgetClass:(int)budget visitIntensity:(int)intensity finish:(void (^)(NSDictionary *response))responseBlock {
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://secure-mountain-7532.herokuapp.com/v1/"]];
    NSDictionary __block *result;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat=@"dd-MM-yyyy";
    
    [manager GET:@"suggestions" parameters:@{@"accomodation_lat" : [NSString stringWithFormat:@"%f", location.coordinate.latitude], @"accomodation_lng" : [NSString stringWithFormat:@"%f", location.coordinate.longitude],@"starts_at" : [formatter stringFromDate:startDate], @"ends_at" : [formatter stringFromDate:startDate], @"visited_count" : [NSString stringWithFormat:@"%i", visits], @"budget_class" : [NSString stringWithFormat:@"%i", budget], @"visit_intensity" : [NSString stringWithFormat:@"%i", intensity]} success:^(NSURLSessionDataTask *task, id responseObject) {
        
        responseBlock(responseObject);
        
        NSLog(@"Response: %@", responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        result = @{@"error" : error.description};
        
        responseBlock(result);
        
        NSLog(@"Error: %@", error.description);
        
    }];
    
}

+ (void)getSearch:(NSString *)query coordinates:(CLLocation *)location finish:(void (^)(NSDictionary *response))responseBlock {
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://secure-mountain-7532.herokuapp.com/v1/"]];
    
    NSDictionary __block *result;
    
    [manager GET:@"search" parameters:@{@"q" : query, @"accomodation_lat" : [NSString stringWithFormat:@"%f", location.coordinate.latitude], @"accomodation_lng" : [NSString stringWithFormat:@"%f", location.coordinate.longitude]} success:^(NSURLSessionDataTask *task, id responseObject) {
    
        responseBlock(responseObject);
        
        NSLog(@"Response: %@", result);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        result = @{@"error" : error.description};
        
        responseBlock(result);
        
        NSLog(@"Error: %@", error.description);
        
    }];

}

+ (void)getFinalTripFrom:(NSDate *)startDate until:(NSDate *)endDate spots:(NSArray *)spots finish:(void (^)(NSDictionary *response))responseBlock {
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://secure-mountain-7532.herokuapp.com/v1/"]];
    
    NSDictionary __block *result;
    
    [manager GET:@"final_trip" parameters:@{@"starts_at" : startDate, @"ends_at" : endDate, @"spots" : spots} success:^(NSURLSessionDataTask *task, id responseObject) {
        
        responseBlock(responseObject);
        
        NSLog(@"Response: %@", responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        result = @{@"error" : error.description};
        
        responseBlock(result);
        
        NSLog(@"Error: %@", error.description);
        
    }];
    
}

@end
