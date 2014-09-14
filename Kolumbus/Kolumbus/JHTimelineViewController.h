//
//  JHTimelineViewController.h
//  Kolumbus
//
//  Created by Finn Gaida on 13.09.14.
//  Copyright (c) 2014 Jugend Hackt. All rights reserved.
//

#import "FGTimelineView.h"
#import "MBProgressHUD.h"
#import <UIKit/UIKit.h>

@interface JHTimelineViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) NSDictionary *suggestions;

- (void)loadData:(NSDictionary *)data;

@end
