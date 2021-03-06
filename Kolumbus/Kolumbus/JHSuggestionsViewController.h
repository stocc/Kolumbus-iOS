//
//  JHSuggestionsViewController.h
//  Kolumbus
//
//  Created by Finn Gaida on 12.09.14.
//  Copyright (c) 2014 Jugend Hackt. All rights reserved.
//

#import "JHCommunicator.h"
#import "JHButton.h"
#import "JHMapViewController.h"
#import "UIImageView+WebCache.h"
#import "JHTimelineViewController.h"
#import "MBProgressHUD.h"
#import "JSFavStarControl.h"
#import <UIKit/UIKit.h>

@interface JHSuggestionsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

- (void)loadData:(NSDictionary *)data;

@end
