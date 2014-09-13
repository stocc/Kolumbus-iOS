//
//  JHMapViewController.m
//  Kolumbus
//
//  Created by Finn Gaida on 13.09.14.
//  Copyright (c) 2014 Jugend Hackt. All rights reserved.
//

#import "JHMapViewController.h"

@implementation JHMapViewController {
    
    MKMapView *mapView;
    MKCoordinateRegion region;
    
}

- (id)initWithRegion:(MKCoordinateRegion)reg {
    
    self = [super init];
    if (self) {
        region = reg;
    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    mapView = [[MKMapView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:mapView];
    [mapView setRegion:region animated:YES];
    
}

- (void)didReceiveMemoryWarning {[super didReceiveMemoryWarning];}

@end
