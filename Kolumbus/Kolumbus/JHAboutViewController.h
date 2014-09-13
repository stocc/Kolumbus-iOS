//
//  JHAboutViewController.h
//  Kolumbus
//
//  Created by Daniel Petri on 13.09.14.
//  Copyright (c) 2014 Jugend Hackt. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JHAboutViewController;

@protocol JHABoutVCDelegate <NSObject>

-(void)hideMe;
-(void)hideBtn;

@end
@interface JHAboutViewController : UIViewController
@property(weak,nonatomic)id<JHABoutVCDelegate> delegate;
@end
