//
//  JHLocationPickerTableViewController.m
//  Kolumbus
//
//  Created by Daniel Petri on 13.09.14.
//  Copyright (c) 2014 Jugend Hackt. All rights reserved.
//

#import "JHLocationPickerTableViewController.h"

@interface JHLocationPickerTableViewController() <CLLocationManagerDelegate>
@property (strong,nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *currentLocationActivityIndicator;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *geocodingActivityIndicator;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (nonatomic,strong) CLGeocoder* geocoder;

@end
@implementation JHLocationPickerTableViewController

#pragma mark - Getters

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

#pragma mark - Table View Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        //Only one cell in section 0 -> Use current location
        
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        [self.currentLocationActivityIndicator startAnimating];
        self.currentLocationActivityIndicator.hidden = NO;
        
        //Ask for Permission if iOS 8+
        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [self.locationManager requestWhenInUseAuthorization];
        }
        if ([CLLocationManager locationServicesEnabled]) {
            self.locationManager.delegate = self;
            
            //Async get Location
            [self.locationManager startUpdatingLocation];
        }

    }else if (indexPath.row==1){
        //can only be in section 1 -> Search button
        
        [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        [self.geocodingActivityIndicator startAnimating];
        
        [self.geocoder geocodeAddressString:self.searchTextField.text completionHandler:^(NSArray *placemarks, NSError *error){
            //evaluate placemark
            if ([placemarks count]==0) {
                [[[UIAlertView alloc] initWithTitle:@"Fehler" message:@"Konnte Adresse nicht finden" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
                [self.geocodingActivityIndicator stopAnimating];
            }else{
                CLPlacemark *result = placemarks[0];
                [self.delegate didSelectLocation:result.location WithName:result.name];
            }
        }];
    }
}

#pragma mark - Location Manager Delegate
-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"location error");
}
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    //found location
    [manager stopUpdatingLocation];
    [self.currentLocationActivityIndicator stopAnimating];
    
    [self.delegate didSelectLocation:locations[0] WithName:@"Aktuelle Position"];
}
- (IBAction)cancel:(id)sender {
    [self.delegate didNotSelectLocation];
}
@end
