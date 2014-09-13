//
//  JHLocationPickerTableViewController.h
//  Kolumbus
//
//  Created by Daniel Petri on 13.09.14.
//  Copyright (c) 2014 Jugend Hackt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@class JHLocationPickerTableViewController;

@protocol JHLocationPickerDelegate <NSObject>
-(void)didSelectLocation:(CLLocation *)location WithName:(NSString *)name;
-(void)didNotSelectLocation;
@end
@interface JHLocationPickerTableViewController : UITableViewController
@property (nonatomic,strong) CLLocation *userLocation;
@property (nonatomic,weak) id<JHLocationPickerDelegate> delegate;

@end
