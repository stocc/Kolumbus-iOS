//
//  JHFetcher.m
//  Kolumbus
//
//  Created by Finn Gaida on 13.09.14.
//  Copyright (c) 2014 Jugend Hackt. All rights reserved.
//

#import "JHCommunicator.h"

@implementation JHCommunicator

+ (NSDictionary *)getSuggestions {
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://niklas-mbp.local:3000/v1/"]];
    
    [manager GET:@"suggestions" parameters:@[@"starts_at", @"ends_at", @"visited_count", @"classic_trip", @"budget_class"] success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"Response: %@", responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"Error: %@", error.description);
        
    }];
    
    return [NSDictionary new];
    
}

+ (NSDictionary *)getSearch {
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://niklas-mbp.local:3000/v1/"]];
    
    [manager GET:@"search" parameters:@[@"q"] success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"Response: %@", responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"Error: %@", error.description);
        
    }];
    
    return [NSDictionary new];
    
}

+ (NSDictionary *)getFinalTrif {
    
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://niklas-mbp.local:3000/v1/"]];
    
    [manager GET:@"final_trip" parameters:@[@"spots"] success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"Response: %@", responseObject);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"Error: %@", error.description);
        
    }];
    
    return [NSDictionary new];
    
}

@end
