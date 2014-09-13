//
//  JHSuggestionsViewController.h
//  Kolumbus
//
//  Created by Finn Gaida on 12.09.14.
//  Copyright (c) 2014 Jugend Hackt. All rights reserved.
//

#import "AFNetworking.h"
#import <UIKit/UIKit.h>

static const NSString* url = @"niklas-mbp.local:3000/v1/";

@interface JHSuggestionsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@end
