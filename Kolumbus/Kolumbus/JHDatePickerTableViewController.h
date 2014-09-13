//
//  JHDatePickerTableViewController.h
//  Kolumbus
//
//  Created by Daniel Petri on 13.09.14.
//  Copyright (c) 2014 Jugend Hackt. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JHDatePickerTableViewController;

@protocol JHDatePickerDelegate <NSObject>
-(void)didFinishPickingDate:(NSDate *)date;
-(void)didNotPickDate;

@end

@interface JHDatePickerTableViewController : UITableViewController
@property (weak,nonatomic)id<JHDatePickerDelegate> delegate;
@end
