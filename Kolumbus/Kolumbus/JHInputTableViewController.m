//
//  JHInputTableViewController.m
//  Kolumbus
//
//  Created by Daniel Petri on 13.09.14.
//  Copyright (c) 2014 Jugend Hackt. All rights reserved.
//

#import "JHInputTableViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface JHInputTableViewController ()<CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *currentLocationActivityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *locationTextfield;
@property (strong,nonatomic) CLLocationManager *locationManager;
@property (strong,nonatomic) CLLocation* userLocation;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *budgetSegmentedControl;
@property (weak, nonatomic) IBOutlet UISlider *intensitySlider;
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;
@end

@implementation JHInputTableViewController


-(CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        
    }
    
    return _locationManager;
    
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.currentLocationActivityIndicator startAnimating];
    self.currentLocationActivityIndicator.hidden = NO;
        
    //add visited count
    //budget class 1-4
    //visit intensity 1-10
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager.delegate = self;
        [self.locationManager startUpdatingLocation];
    }


}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    [manager stopUpdatingLocation];
    [self.currentLocationActivityIndicator stopAnimating];
    
    self.userLocation = locations[0];
    self.locationTextfield.text = [NSString stringWithFormat:@"%f, %f",self.userLocation.coordinate.latitude,self.userLocation.coordinate.longitude];
    self.goButton.enabled = YES;
    
    
    

}


-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{

    NSLog(@"Location error %@",error.description);

}
- (IBAction)stepperChanged:(UIStepper *)sender {
}
@end
