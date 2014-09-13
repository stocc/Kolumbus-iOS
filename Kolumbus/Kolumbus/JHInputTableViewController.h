//
//  JHInputTableViewController.h
//  Kolumbus
//
//  Created by Daniel Petri on 13.09.14.
//  Copyright (c) 2014 Jugend Hackt. All rights reserved.
//

#import "JHButton.h"
#import "JHSuggestionsViewController.h"
#import <UIKit/UIKit.h>


@class JHButton;
@interface JHInputTableViewController : UITableViewController

@property (strong,nonatomic) CLLocation* userLocation;
@property (nonatomic) int budget;
@property (nonatomic) int intensity;
@property (nonatomic) int visitCount;

@property (nonatomic,strong) NSDate *startDate;
@property (nonatomic,strong) NSDate *endDate; 

@end
