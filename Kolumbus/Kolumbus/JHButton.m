//
//  JHButton.m
//  Kolumbus
//
//  Created by Finn Gaida on 13.09.14.
//  Copyright (c) 2014 Jugend Hackt. All rights reserved.
//

#import "JHButton.h"

@implementation JHButton

- (id)init {
    self = [super init];
    if (self) {
        [self addTarget:self action:@selector(didTapButtonForHighlight:) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(didUnTapButtonForHighlight:) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(didUnTapButtonForHighlight:) forControlEvents:UIControlEventTouchUpOutside];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addTarget:self action:@selector(didTapButtonForHighlight:) forControlEvents:UIControlEventTouchDown];
        [self addTarget:self action:@selector(didUnTapButtonForHighlight:) forControlEvents:UIControlEventTouchUpInside];
        [self addTarget:self action:@selector(didUnTapButtonForHighlight:) forControlEvents:UIControlEventTouchUpOutside];
    }
    return self;
}

- (void)setNormalColor:(UIColor *)normalColor {
    [self setBackgroundColor:normalColor];
    _normalColor = normalColor;
}

- (void)setHighlightedColor:(UIColor *)highlightedColor {
    _highlightedColor = highlightedColor;
}

#pragma mark Actions

- (void)didTapButtonForHighlight:(UIButton *)sender {
    [self setBackgroundColor:_highlightedColor];
}

- (void)didUnTapButtonForHighlight:(UIButton *)sender {
    [self setBackgroundColor:_normalColor];
}

@end
