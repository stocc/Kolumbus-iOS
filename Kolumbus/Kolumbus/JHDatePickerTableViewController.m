//
//  JHDatePickerTableViewController.m
//  Kolumbus
//
//  Created by Daniel Petri on 13.09.14.
//  Copyright (c) 2014 Jugend Hackt. All rights reserved.
//

#import "JHInputTableViewController.h"
#import "JHDatePickerTableViewController.h"

@interface JHDatePickerTableViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@end

@implementation JHDatePickerTableViewController
- (IBAction)done:(id)sender {
    [self.delegate didFinishPickingDate:self.datePicker.date];
}
- (IBAction)cancel:(id)sender {
    [self.delegate didNotPickDate];
}

@end
