//
//  JHInputTableViewController.m
//  Kolumbus
//
//  Created by Daniel Petri on 13.09.14.
//  Copyright (c) 2014 Jugend Hackt. All rights reserved.
//

#import "JHInputTableViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "JHDatePickerTableViewController.h"
#import "JHAboutViewController.h"
@interface JHInputTableViewController ()<CLLocationManagerDelegate, JHDatePickerDelegate, JHABoutVCDelegate> {
    JHButton *finish;
}

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *currentLocationActivityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *locationTextfield;
@property (strong,nonatomic) CLLocationManager *locationManager;
@property (weak, nonatomic) IBOutlet UISegmentedControl *budgetSegmentedControl;
@property (weak, nonatomic) IBOutlet UISlider *intensitySlider;
@property (weak, nonatomic) IBOutlet UILabel *stepLabel;
@property (strong, nonatomic) NSString *currentlyEditing;
@property (weak, nonatomic) IBOutlet UILabel *startDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *endDateLabel;
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
    finish = [[JHButton alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-108, self.view.frame.size.width, 44)];
    [finish setNormalColor:[UIColor colorWithRed:(255.0/255.0) green:(142.0/255.0) blue:(7.0/255.0) alpha:1]];
    [finish setHighlightedColor:[UIColor colorWithRed:(255.0/255.0) green:(105.0/255.0) blue:(47.0/255.0) alpha:1]];
    [finish addTarget:self action:@selector(finishSuggestions) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:finish];
    
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
    
    [JHCommunicator getSuggestionsFrom:self.startDate until:self.endDate visitedCount:self.visitCount budgetClass:self.budget visitIntensity:self.intensity finish:^(NSDictionary *response){
    
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


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"about"]) {
        JHAboutViewController *aboutVC = (JHAboutViewController *)segue.destinationViewController;
        aboutVC.delegate = self;
    }else if ([segue.identifier rangeOfString:@"pickDateFor"].length != 0){
    
        UINavigationController *navCon = (UINavigationController *)segue.destinationViewController;
        JHDatePickerTableViewController *datePicker = (JHDatePickerTableViewController *)navCon.viewControllers[0];
        datePicker.delegate = self;
        
        if ([segue.identifier rangeOfString:@"Start"].length != 0) {
            self.currentlyEditing = @"start";
        }else{
            self.currentlyEditing = @"end";
        }
        
    }
}

-(void)hideMe{
    [self dismissViewControllerAnimated:YES completion:^{}];
}


-(void)didFinishPickingDate:(NSDate *)date{
    if ([self.currentlyEditing isEqualToString:@"start"]) {
        self.startDate = date;
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"d.M.Y"];
        self.startDateLabel.text = [formatter stringFromDate:date];
    }else{
        self.endDate = date;
        NSLog(@"%@",date);
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"d.M.Y"];
        self.endDateLabel.text = [formatter stringFromDate:date];
    }
    self.currentlyEditing = @"";
    [self dismissViewControllerAnimated:YES completion:^{}];
}
-(void)didNotPickDate{
    [self dismissViewControllerAnimated:YES completion:^{}];
}
@end
