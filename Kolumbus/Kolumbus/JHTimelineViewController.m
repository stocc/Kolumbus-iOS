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
    CGFloat width;
    CGFloat height;
    
    NSDictionary *input;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Kolumbus";
    
    input = [NSDictionary new];
    width = self.view.frame.size.width;
    height = self.view.frame.size.height;
    
    tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
    /*/ loading spinner
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = @"Loading";         //*/
    
}

- (void)loadData:(NSDictionary *)data {
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    if (data[@"error"]) {
        [[[UIAlertView alloc] initWithTitle:@"Wow" message:[NSString stringWithFormat:@"You crashed it :( Error is: %@", data[@"error"]] delegate:nil cancelButtonTitle:@"Cool" otherButtonTitles:nil, nil] show];
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        
        input = data;
        [tableView reloadData];
        
    }
    
}

#pragma mark Table View delegates
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (input.allKeys.count != 0) {
        return [input[input.allKeys[0]] allKeys].count;
    } else {
        return 1;
    }
}

#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    NSDictionary *model;
    
    if (input.allKeys.count != 0) {
        model = input[input.allKeys[0]][[input[input.allKeys[0]] allKeys][indexPath.row]];
    }
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(70, 15, width-90, 30)];
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor blackColor];
    title.textAlignment = NSTextAlignmentLeft;
    title.numberOfLines = 0;
    title.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
    title.text = @"Berlin Hbf";
    [cell.contentView addSubview:title];
    
    UILabel *description = [[UILabel alloc] initWithFrame:CGRectMake(70, 35, width-140, 40)];
    description.backgroundColor = [UIColor clearColor];
    description.textColor = [UIColor colorWithWhite:0 alpha:.7];
    description.textAlignment = NSTextAlignmentLeft;
    description.numberOfLines = 0;
    description.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    description.text = @"Dies ist ein Beispieltext!";
    [cell.contentView addSubview:description];
    
    UILabel *title2 = [[UILabel alloc] initWithFrame:CGRectMake(70, 180, width-90, 30)];
    title2.backgroundColor = [UIColor clearColor];
    title2.textColor = [UIColor blackColor];
    title2.textAlignment = NSTextAlignmentLeft;
    title2.numberOfLines = 0;
    title2.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
    title2.text = @"Alexanderplatz";
    [cell.contentView addSubview:title2];
    
    UILabel *description2 = [[UILabel alloc] initWithFrame:CGRectMake(70, 200, width-140, 40)];
    description2.backgroundColor = [UIColor clearColor];
    description2.textColor = [UIColor colorWithWhite:0 alpha:.7];
    description2.textAlignment = NSTextAlignmentLeft;
    description2.numberOfLines = 0;
    description2.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    description2.text = @"Das hier ist ja auch einer! :O";
    [cell.contentView addSubview:description2];
    
    FGTimelineView *timeline = [[FGTimelineView alloc] initWithFrame:CGRectMake(25, 30, 30, 200)];
    [cell.contentView addSubview:timeline];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 260;
}

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
