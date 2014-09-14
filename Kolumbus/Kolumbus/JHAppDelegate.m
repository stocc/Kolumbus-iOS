//
//  AppDelegate.m
//  Kolumbus
//
//  Created by Finn Gaida on 12.09.14.
//  Copyright (c) 2014 Jugend Hackt. All rights reserved.
//

#import "JHAppDelegate.h"
#import <GoogleMaps/GoogleMaps.h>
@interface JHAppDelegate ()

@end

@implementation JHAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [GMSServices provideAPIKey:@"379814594190-gk9tsfnuoelmpdvua2hc2jfps8rohf0f.apps.googleusercontent.com"];
    return YES;
}


@end
