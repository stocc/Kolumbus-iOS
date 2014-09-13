//
//  JHDatePickerTableViewController.m
//  Kolumbus
//
//  Created by Daniel Petri on 13.09.14.
//  Copyright (c) 2014 Jugend Hackt. All rights reserved.
//

#import "JHDatePickerTableViewController.h"

@interface JHDatePickerTableViewController ()
@property (strong,nonatomic) NSDate *chosenDate;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@end

@implementation JHDatePickerTableViewController
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    self.chosenDate = self.datePicker.date;

}
- (IBAction)changedDate:(id)sender {
    self.chosenDate = self.datePicker.date;
}
- (IBAction)done:(id)sender {
    [self.delegate didFinishPickingDate:self.chosenDate];
}
- (IBAction)cancel:(id)sender {
    [self.delegate didNotPickDate];
}

@end
