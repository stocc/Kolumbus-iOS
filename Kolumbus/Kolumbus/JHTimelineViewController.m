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
#import "AFNetworking.h"


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
    
    UIBarButtonItem *share = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(share)];
    self.navigationItem.rightBarButtonItem = share;

}

- (void)share {
    
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"Share" delegate:nil cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Twitter", @"Facebook", @"E-Mail", @"Nachricht", nil];
    [sheet showInView:self.view];
    
}

- (void)loadData:(NSDictionary *)data {
    
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    
    if (data[@"error"]) {
        [[[UIAlertView alloc] initWithTitle:@"Wow" message:[NSString stringWithFormat:@"You crashed it :( Error is: %@", data[@"error"]] delegate:nil cancelButtonTitle:@"Cool" otherButtonTitles:nil, nil] show];
        // DEBUG [self.navigationController popViewControllerAnimated:YES];
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
    return _suggestions.allKeys.count-1;
}

#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    
    NSDictionary *model = _suggestions[_suggestions.allKeys[indexPath.row]];
    NSDictionary *model2;
    if (_suggestions.allKeys.count>=indexPath.row+1)
        model2 = _suggestions[_suggestions.allKeys[indexPath.row+1]];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(70, 15, width-90, 30)];
    title.backgroundColor = [UIColor clearColor];
    title.textColor = [UIColor blackColor];
    title.textAlignment = NSTextAlignmentLeft;
    title.numberOfLines = 0;
    title.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
    title.text = model[@"name"];
    [cell.contentView addSubview:title];
    
    UILabel *description = [[UILabel alloc] initWithFrame:CGRectMake(70, 35, width-140, 40)];
    description.backgroundColor = [UIColor clearColor];
    description.textColor = [UIColor colorWithWhite:0 alpha:.7];
    description.textAlignment = NSTextAlignmentLeft;
    description.numberOfLines = 0;
    description.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    description.text = model[@"location"][@"hash"][@"city"];
    [cell.contentView addSubview:description];
    
    UIImageView *train = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"train22"]];
    train.frame = CGRectMake(80, 100, 36, 54);
    [cell.contentView addSubview:train];
    
    
    UILabel *trainText = [[UILabel alloc] initWithFrame:CGRectMake(150, 100, width-160, 40)];
    trainText.backgroundColor = [UIColor clearColor];
    trainText.textColor = [UIColor colorWithWhite:0 alpha:.7];
    trainText.textAlignment = NSTextAlignmentLeft;
    trainText.numberOfLines = 0;
    trainText.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    trainText.text = [self getTravelTimeForDirectionsFromCoordinate:CLLocationCoordinate2DMake([model[@"location"][@"hash"][@"coordinate"][@"latitude"] doubleValue], [model[@"location"][@"hash"][@"coordinate"][@"longitude"] doubleValue]) toCoordinate:CLLocationCoordinate2DMake([model2[@"location"][@"hash"][@"coordinate"][@"latitude"] doubleValue], [model2[@"location"][@"hash"][@"coordinate"][@"longitude"] doubleValue])];
    [cell.contentView addSubview:trainText];
    
    UILabel *title2 = [[UILabel alloc] initWithFrame:CGRectMake(70, 180, width-90, 30)];
    title2.backgroundColor = [UIColor clearColor];
    title2.textColor = [UIColor blackColor];
    title2.textAlignment = NSTextAlignmentLeft;
    title2.numberOfLines = 0;
    title2.font = [UIFont fontWithName:@"Helvetica Neue" size:20];
    title2.text = model2[@"name"];;
    [cell.contentView addSubview:title2];
    
    UILabel *description2 = [[UILabel alloc] initWithFrame:CGRectMake(70, 200, width-140, 40)];
    description2.backgroundColor = [UIColor clearColor];
    description2.textColor = [UIColor colorWithWhite:0 alpha:.7];
    description2.textAlignment = NSTextAlignmentLeft;
    description2.numberOfLines = 0;
    description2.font = [UIFont fontWithName:@"Helvetica Neue" size:15];
    description2.text = model2[@"location"][@"hash"][@"city"];
    [cell.contentView addSubview:description2];
    
    FGTimelineView *timeline = [[FGTimelineView alloc] initWithFrame:CGRectMake(25, 30, 30, 200)];
    [cell.contentView addSubview:timeline];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 260;
}

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tv deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *model = _suggestions[_suggestions.allKeys[indexPath.row]];
    NSDictionary *model2 = _suggestions[_suggestions.allKeys[indexPath.row+1]];
    
    [self openDirectionsFromCoordinate:CLLocationCoordinate2DMake([model[@"location"][@"hash"][@"coordinate"][@"latitude"] doubleValue], [model[@"location"][@"hash"][@"coordinate"][@"longitude"] doubleValue]) ToCoordinate:CLLocationCoordinate2DMake([model2[@"location"][@"hash"][@"coordinate"][@"latitude"] doubleValue], [model2[@"location"][@"hash"][@"coordinate"][@"longitude"] doubleValue])];
    
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

-(NSString *)getTravelTimeForDirectionsFromCoordinate:(CLLocationCoordinate2D)from toCoordinate:(CLLocationCoordinate2D)to{
    //TODO write completion handler so it can be passed back
    
    
    NSString *googleDirectionsKey = @"AIzaSyBxbgQLjYoh6tVtFzyso_TwaGZp-Mq9foQ";

    NSString __block *duration;
    
    //Get JSON from that URL
    AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://maps.googleapis.com/maps/api/directions/"]];

    [manager GET:@"json" parameters:@{@"origin":[NSString stringWithFormat:@"%f,%f",from.latitude,from.longitude],
                                      @"destination":[NSString stringWithFormat:@"%f,%f",to.latitude,to.longitude],
                                      @"mode":@"transit",
                                      @"departure_time":[NSString stringWithFormat:@"%.f",[[NSDate date] timeIntervalSince1970]],
                                      @"key":googleDirectionsKey}
    success:^(NSURLSessionDataTask *task, id responseObject){
        
        if ([responseObject[@"routes"] count] != 0) {
            duration = responseObject[@"routes"][0][@"legs"][0][@"duration"][@"text"];
            NSLog(@"dur %@", duration);
        }
        
    }failure:^(NSURLSessionDataTask *task, NSError *error) {
    
    }];
    
    return duration;
    
}

@end
