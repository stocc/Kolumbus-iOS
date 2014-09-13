//
//  FGTimelineView.m
//  Kolumbus
//
//  Created by Finn Gaida on 13.09.14.
//  Copyright (c) 2014 Jugend Hackt. All rights reserved.
//

#import "FGTimelineView.h"

@implementation FGTimelineView

- (id)initWithFrame:(CGRect)frame {
    
    self=[super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
    
}

- (id)init {
    
    self=[super init];
    if (self) {
        [self setup];
    }
    return self;
    
}

- (void)setup {
    
    UIView *connector = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width/2-2, 0, 4, self.frame.size.height)];
    connector.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:connector];
    
    UIView *topCircle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width)];
    topCircle.layer.masksToBounds = YES;
    topCircle.layer.cornerRadius = topCircle.frame.size.width/2;
    topCircle.backgroundColor = [UIColor lightGrayColor];
    topCircle.layer.borderColor = [UIColor blackColor].CGColor;
    topCircle.layer.borderWidth = topCircle.frame.size.width/10;
    [self addSubview:topCircle];
    
    UIView *bottomCircle = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-self.frame.size.width, self.frame.size.width, self.frame.size.width)];
    bottomCircle.layer.masksToBounds = YES;
    bottomCircle.layer.cornerRadius = bottomCircle.frame.size.width/2;
    bottomCircle.backgroundColor = [UIColor lightGrayColor];
    bottomCircle.layer.borderColor = [UIColor blackColor].CGColor;
    bottomCircle.layer.borderWidth = bottomCircle.frame.size.width/10;
    [self addSubview:bottomCircle];
    
}

@end
