//
//  JHButton.h
//  Kolumbus
//
//  Created by Finn Gaida on 13.09.14.
//  Copyright (c) 2014 Jugend Hackt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JHButton : UIButton

@property (nonatomic, strong, readonly) UIColor *normalColor;
@property (nonatomic, strong, readonly) UIColor *highlightedColor;

- (void)setNormalColor:(UIColor *)normalColor;
- (void)setHighlightedColor:(UIColor *)highlightedColor;

@end
