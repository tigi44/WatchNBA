//
//  UIView+Layout.h
//  WatchNBA
//
//  Created by tigi on 2018. 2. 27..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Layout)

- (void)drawBoundsWithColor:(UIColor *)aColor;


- (void)setPosition:(CGPoint)aPoint;
- (void)setYPosition:(CGFloat)aY;
- (void)setXPosition:(CGFloat)aX;

- (void)setSize:(CGSize)aSize;
- (void)setWidth:(CGFloat)aWidth;
- (void)setHeight:(CGFloat)aHeight;


- (void)widthToFit;
- (void)heightToFit;


- (void)moveToRightOf:(UIView *)aView gap:(CGFloat)aGap;
- (void)moveToBottomOf:(UIView *)aView gap:(CGFloat)aGap;
- (void)moveToLeftOf:(UIView *)aView gap:(CGFloat)aGap;
- (void)moveToTopOf:(UIView *)aView gap:(CGFloat)aGap;
- (void)moveToCenterOf:(UIView *)aView gap:(CGFloat)aGap;
- (void)moveToMiddleOf:(UIView *)aView gap:(CGFloat)aGap;


- (void)moveToBottomWithMargin:(CGFloat)aMargin;
- (void)moveToRightWithMargin:(CGFloat)aMargin;
- (void)moveToMiddleWithMargin:(CGFloat)aMargin;
- (void)moveToCenterWithMargin:(CGFloat)aMargin;
- (void)moveToTopRightWithMargin:(CGSize)aMargin;
- (void)moveToBottomLeftWithMargin:(CGSize)aMargin;
- (void)moveToBottomRightWithMargin:(CGSize)aMargin;
- (void)moveToMiddleCenterWithMargin:(CGSize)aMargin;


- (void)moveToHorizontalCenter;
- (void)moveToVerticalCenter;


@end
