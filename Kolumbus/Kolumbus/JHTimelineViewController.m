//
//  JHTimelineViewController.m
//  Kolumbus
//
//  Created by Finn Gaida on 13.09.14.
//  Copyright (c) 2014 Jugend Hackt. All rights reserved.
//

#import "JHTimelineViewController.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@implementation JHTimelineViewController {
    
    UITableView *tableView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
}

- (void)loadData:(NSDictionary *)data {
    
}

- (void)didReceiveMemoryWarning {[super didReceiveMemoryWarning];}



-(void)openDirectionsFromCoordinate:(CLLocationCoordinate2D)from ToCoordinate:(CLLocationCoordinate2D)to{

    //comgooglemaps://?saddr=Google+Inc,+8th+Avenue,+New+York,+NY&daddr=John+F.+Kennedy+International+Airport,+Van+Wyck+Expressway,+Jamaica,+New+York&directionsmode=transit
    
    //http://maps.apple.com/?daddr=San+Francisco,+CA&saddr=cupertino

    if ([[UIApplication sharedApplication] canOpenURL: [NSURL URLWithString:@"comgooglemaps://"]]) {
        NSString *urlString = [NSString stringWithFormat:@"comgooglemaps-x-callback://?saddr=%@&daddr=%@&directionsmode=transit&x-success=kolumbus://&x-source=Kolumbus",
                               [NSString stringWithFormat:@"%f,%f",from.latitude,from.longitude],
                               [NSString stringWithFormat:@"%f,%f",to.latitude,to.longitude]];
        
        
        
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];
    } else {
        NSString *urlString = [NSString stringWithFormat:@"http://maps.apple.com/?saddr=%@&daddr=%@",
                               [NSString stringWithFormat:@"%f,%f",from.latitude,from.longitude],
                               [NSString stringWithFormat:@"%f,%f",to.latitude,to.longitude]];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString]];

        
    }


}
@end
