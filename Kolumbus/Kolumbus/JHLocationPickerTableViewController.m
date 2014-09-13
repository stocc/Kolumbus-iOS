//
//  JHLocationPickerTableViewController.m
//  Kolumbus
//
//  Created by Daniel Petri on 13.09.14.
//  Copyright (c) 2014 Jugend Hackt. All rights reserved.
//

#import "JHLocationPickerTableViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface JHLocationPickerTableViewController ()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *currentLocationActivityIndicator;
@property (weak, nonatomic) IBOutlet UITextField *locationTextfield;
@property (strong,nonatomic) CLLocationManager *locationManager;
@end

@implementation JHLocationPickerTableViewController



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 1) {
        //Select current location button
        [self.currentLocationActivityIndicator startAnimating];
        
        
    }
    
}

- (IBAction)done:(id)sender {
}

@end
