//
//  JHLocationPickerTableViewController.m
//  Kolumbus
//
//  Created by Daniel Petri on 13.09.14.
//  Copyright (c) 2014 Jugend Hackt. All rights reserved.
//

#import "JHLocationPickerTableViewController.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@interface JHLocationPickerTableViewController () <CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *currentLocationActivityIndicator;
@property (weak, nonatomic) IBOutlet UITextField *locationTextfield;
@property (strong,nonatomic) CLLocationManager *locationManager;
@property (strong,nonatomic) CLGeocoder *geocoder;
@end

@implementation JHLocationPickerTableViewController

-(CLLocationManager *)locationManager{
    if (!_locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        
    }
    
    return _locationManager;

}
-(CLGeocoder *)geocoder{
    if (!_geocoder) {
        _geocoder = [[CLGeocoder alloc] init];
        
    }
    
    return _geocoder;


}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 1) {
        //Select current location button
        [self.currentLocationActivityIndicator startAnimating];
        self.currentLocationActivityIndicator.hidden = NO;
        self.locationManager.delegate = self;
        [self.locationManager startUpdatingLocation];
        
    }
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{

    [manager stopUpdatingLocation];
    
    
    [self.geocoder reverseGeocodeLocation:locations[0] completionHandler:^(NSArray *placemarks, NSError *error){
        [self.currentLocationActivityIndicator stopAnimating];
    }];
    
    
        
        
 
    

}

- (IBAction)done:(id)sender {
    
}

@end
