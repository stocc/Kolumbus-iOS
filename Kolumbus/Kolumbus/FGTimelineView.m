//
//  FGTimelineView.m
//  Kolumbus
//
//  Created by Finn Gaida on 13.09.14.
//  Copyright (c) 2014 Jugend Hackt. All rights reserved.
//

#import "FGTimelineView.h"

@implementation FGTimelineView {
    int cache;
}

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
    
    cache = 0;
    
    UIView *connector = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width/2-2, 0, 4, self.frame.size.height)];
    connector.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:connector];
    
    UIView *topCircle = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.width)];
    topCircle.layer.masksToBounds = YES;
    topCircle.layer.cornerRadius = topCircle.frame.size.width/2;
    topCircle.backgroundColor = [self randColor];
    topCircle.layer.borderColor = [UIColor blackColor].CGColor;
    topCircle.layer.borderWidth = topCircle.frame.size.width/10;
    [self addSubview:topCircle];
    
    UIView *bottomCircle = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-self.frame.size.width, self.frame.size.width, self.frame.size.width)];
    bottomCircle.layer.masksToBounds = YES;
    bottomCircle.layer.cornerRadius = bottomCircle.frame.size.width/2;
    bottomCircle.backgroundColor = [self randColor];
    bottomCircle.layer.borderColor = [UIColor blackColor].CGColor;
    bottomCircle.layer.borderWidth = bottomCircle.frame.size.width/10;
    [self addSubview:bottomCircle];
    
}

- (UIColor *)randColor {
    
    NSArray *colors = @[[UIColor colorWithRed:(255.0/255.0) green:(64.0/255.0) blue:(84.0/255.0) alpha:1], [UIColor colorWithRed:(255.0/255.0) green:(188.0/255.0) blue:(59.0/255.0) alpha:1], [UIColor colorWithRed:(255.0/255.0) green:(55.0/255.0) blue:(69.0/255.0) alpha:1], [UIColor colorWithRed:(10.0/255.0) green:(160.0/255.0) blue:(240.0/255.0) alpha:1], [UIColor colorWithRed:(68.0/255.0) green:(219.0/255.0) blue:(222.0/255.0) alpha:1]];
    
    int rand = arc4random() % 5;
    if (rand==cache) {
        rand = arc4random() % 5;
    }
    cache = rand;
    
    return colors[rand];
}

@end
