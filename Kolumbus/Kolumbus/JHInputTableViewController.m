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
    
    // Finish button
    JHButton *finish = [[JHButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height-40, self.view.frame.size.width, 40)];
    [finish setNormalColor:[UIColor colorWithRed:(30.0/255.0) green:(50.0/255.0) blue:(65.0/255.0) alpha:1]];
    [finish setHighlightedColor:[UIColor colorWithRed:(15.0/255.0) green:(40.0/255.0) blue:(55.0/255.0) alpha:1]];
    [finish addTarget:self action:@selector(finishSuggestions) forControlEvents:UIControlEventTouchUpInside];
    [((UIWindow *)[[UIApplication sharedApplication] windows][0]) addSubview:finish];
    
    UILabel *finishText = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    finishText.backgroundColor = [UIColor clearColor];
    finishText.textColor = [UIColor whiteColor];
    finishText.textAlignment = NSTextAlignmentCenter;
    finishText.numberOfLines = 0;
    finishText.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
    finishText.text = @"Zeig mir Vorschläge!";
    [finish addSubview:finishText];


}

- (void)finishSuggestions {
    
    // TODO (macht Finn)
    JHSuggestionsViewController *suggestionsVC = [[JHSuggestionsViewController alloc] init];
    [self.navigationController pushViewController:suggestionsVC animated:YES];
    
    // explanation: The new view gets pushed and the app downloads the info in the background (async) and when it's ready, the new view displays the new info
    
    self.budget = (int)self.budgetSegmentedControl.selectedSegmentIndex+1;
    NSNumber *intensityNumber = [NSNumber numberWithFloat:[self.intensitySlider value]];
    self.intensity = [intensityNumber intValue];
    
    [JHCommunicator getSuggestionsFrom:[NSDate new] until:[NSDate new] visitedCount:self.visitCount budgetClass:self.budget visitIntensity:self.intensity finish:^(NSDictionary *response){
    
        [suggestionsVC loadData:response];
    
    }];
    
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    [manager stopUpdatingLocation];
    [self.currentLocationActivityIndicator stopAnimating];
    
    self.userLocation = locations[0];
    self.locationTextfield.text = [NSString stringWithFormat:@"%f, %f",self.userLocation.coordinate.latitude,self.userLocation.coordinate.longitude];
}


-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{

    NSLog(@"Location error %@",error.description);

}
- (IBAction)stepperChanged:(UIStepper *)sender {
    self.stepLabel.text = [NSString stringWithFormat:@"%.f",sender.value];
    
    NSNumber *stepperValue = [NSNumber numberWithDouble:sender.value];
    self.visitCount = (int)[stepperValue integerValue];
}

@end
