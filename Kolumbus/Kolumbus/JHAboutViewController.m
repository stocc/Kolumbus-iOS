//
//  JHAboutViewController.m
//  Kolumbus
//
//  Created by Daniel Petri on 13.09.14.
//  Copyright (c) 2014 Jugend Hackt. All rights reserved.
//

#import "JHAboutViewController.h"

@implementation JHAboutViewController

- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (IBAction)done:(id)sender {
    [self.delegate hideMe];
}
@end
