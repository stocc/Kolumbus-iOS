//
//  JHInputTableViewController.h
//  Kolumbus
//
//  Created by Daniel Petri on 13.09.14.
//  Copyright (c) 2014 Jugend Hackt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface JHInputTableViewController : UITableViewController
@property (strong,nonatomic) CLLocation* userLocation;
@property (nonatomic) NSInteger budget;
@property (nonatomic) NSInteger intensity;
@property (nonatomic) NSInteger visitCount;

@property (nonatomic,strong) NSDate *startDate; //NYI
@property (nonatomic,strong) NSDate *endDate;  //NYI

@end
