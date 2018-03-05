//
//  UIView+Layout.m
//  WatchNBA
//
//  Created by tigi on 2018. 2. 27..
//  Copyright © 2018년 tigi. All rights reserved.
//

#import "UIView+Layout.h"

@implementation UIView (Layout)


- (void)drawBoundsWithColor:(UIColor *)aColor
{
    CGContextRef sContext = UIGraphicsGetCurrentContext();
    
    CGContextSaveGState(sContext);
    CGContextSetStrokeColorWithColor(sContext, [aColor CGColor]);
    CGContextStrokeRect(sContext, [self bounds]);
    CGContextRestoreGState(sContext);
}


#pragma mark -


- (void)setPosition:(CGPoint)aPoint
{
    CGRect sFrame = [self frame];
    
    [self setFrame:CGRectMake(aPoint.x, aPoint.y, sFrame.size.width, sFrame.size.height)];
}


- (void)setYPosition:(CGFloat)aY
{
    CGRect sFrame = [self frame];
    
    [self setFrame:CGRectMake(sFrame.origin.x, aY, sFrame.size.width, sFrame.size.height)];
}


- (void)setXPosition:(CGFloat)aX
{
    CGRect sFrame = [self frame];
    
    [self setFrame:CGRectMake(aX, sFrame.origin.y, sFrame.size.width, sFrame.size.height)];
}


- (void)setSize:(CGSize)aSize
{
    CGRect sFrame = [self frame];
    
    [self setFrame:CGRectMake(sFrame.origin.x, sFrame.origin.y, aSize.width, aSize.height)];
    
}


- (void)setWidth:(CGFloat)aWidth
{
    CGRect sFrame = [self frame];
    
    [self setFrame:CGRectMake(sFrame.origin.x, sFrame.origin.y, aWidth, sFrame.size.height)];
}


- (void)setHeight:(CGFloat)aHeight
{
    CGRect sFrame = [self frame];
    
    [self setFrame:CGRectMake(sFrame.origin.x, sFrame.origin.y, sFrame.size.width, aHeight)];
}


#pragma mark -


- (void)widthToFit
{
    CGRect sFrame1 = [self frame];
    [self sizeToFit];
    
    CGRect sFrame2 = [self frame];
    sFrame2.size.width = sFrame1.size.width;
    
    [self setFrame:sFrame2];
}


- (void)heightToFit
{
    CGRect sFrame1 = [self frame];
    [self sizeToFit];
    
    CGRect sFrame2 = [self frame];
    sFrame2.size.height = sFrame1.size.height;
    
    [self setFrame:sFrame2];
}


#pragma mark -


- (void)moveToRightOf:(UIView *)aView gap:(CGFloat)aGap
{
    CGRect sFrame1 = [self frame];
    CGRect sFrame2 = [aView frame];
    
    sFrame1.origin.x = sFrame2.origin.x + sFrame2.size.width + aGap;
    
    [self setFrame:sFrame1];
}


- (void)moveToBottomOf:(UIView *)aView gap:(CGFloat)aGap
{
    CGRect sFrame1 = [self frame];
    CGRect sFrame2 = [aView frame];
    
    sFrame1.origin.y = sFrame2.origin.y + sFrame2.size.height + aGap;
    
    [self setFrame:sFrame1];
}


- (void)moveToLeftOf:(UIView *)aView gap:(CGFloat)aGap
{
    CGRect sFrame1 = [self frame];
    CGRect sFrame2 = [aView frame];
    
    sFrame1.origin.x = sFrame2.origin.x - sFrame1.size.width - aGap;
    
    [self setFrame:sFrame1];
}


- (void)moveToTopOf:(UIView *)aView gap:(CGFloat)aGap
{
    CGRect sFrame1 = [self frame];
    CGRect sFrame2 = [aView frame];
    
    sFrame1.origin.y = sFrame2.origin.y - sFrame1.size.height - aGap;
    
    [self setFrame:sFrame1];
}


- (void)moveToCenterOf:(UIView *)aView gap:(CGFloat)aGap
{
    CGRect sFrame1 = [self frame];
    CGRect sFrame2 = [aView frame];
    
    sFrame1.origin.x = (NSInteger)(sFrame2.origin.x + (sFrame2.size.width - sFrame1.size.width) / 2 + aGap);
    
    [self setFrame:sFrame1];
}


- (void)moveToMiddleOf:(UIView *)aView gap:(CGFloat)aGap
{
    CGRect sFrame1 = [self frame];
    CGRect sFrame2 = [aView frame];
    
    sFrame1.origin.y = (NSInteger)(sFrame2.origin.y + (sFrame2.size.height - sFrame1.size.height) / 2 + aGap);
    
    [self setFrame:sFrame1];
}


#pragma mark -


- (void)moveToBottomWithMargin:(CGFloat)aMargin
{
    NSAssert([self superview], @"");
    
    CGRect sFrame = [self frame];
    
    sFrame.origin.y = [[self superview] bounds].size.height - sFrame.size.height - aMargin;
    [self setFrame:sFrame];
}


- (void)moveToRightWithMargin:(CGFloat)aMargin
{
    NSAssert([self superview], @"");
    
    CGRect sFrame = [self frame];
    
    sFrame.origin.x = [[self superview] bounds].size.width - sFrame.size.width - aMargin;
    [self setFrame:sFrame];
}


- (void)moveToMiddleWithMargin:(CGFloat)aMargin
{
    NSAssert([self superview], @"");
    
    CGRect sFrame = [self frame];
    
    sFrame.origin.y = (NSInteger)(([[self superview] bounds].size.height - sFrame.size.height) / 2 - aMargin);
    [self setFrame:sFrame];
}


- (void)moveToCenterWithMargin:(CGFloat)aMargin
{
    NSAssert([self superview], @"");
    
    CGRect sFrame = [self frame];
    
    sFrame.origin.x = (NSInteger)(([[self superview] bounds].size.width - sFrame.size.width) / 2 - aMargin);
    [self setFrame:sFrame];
}


- (void)moveToTopRightWithMargin:(CGSize)aMargin
{
    NSAssert([self superview], @"");
    
    CGRect sFrame = [self frame];
    
    sFrame.origin.x = [[self superview] bounds].size.width - sFrame.size.width - aMargin.width;
    sFrame.origin.y = aMargin.height;
    [self setFrame:sFrame];
}


- (void)moveToBottomLeftWithMargin:(CGSize)aMargin
{
    NSAssert([self superview], @"");
    
    CGRect sFrame = [self frame];
    
    sFrame.origin.x = aMargin.width;
    sFrame.origin.y = [[self superview] bounds].size.height - sFrame.size.height - aMargin.height;
    [self setFrame:sFrame];
}


- (void)moveToBottomRightWithMargin:(CGSize)aMargin
{
    NSAssert([self superview], @"");
    
    CGRect sFrame = [self frame];
    
    sFrame.origin.x = [[self superview] bounds].size.width - sFrame.size.width - aMargin.width;
    sFrame.origin.y = [[self superview] bounds].size.height - sFrame.size.height - aMargin.height;
    [self setFrame:sFrame];
}


- (void)moveToMiddleCenterWithMargin:(CGSize)aMargin
{
    NSAssert([self superview], @"");
    
    CGRect sFrame = [self frame];
    
    sFrame.origin.x = (NSInteger)(([[self superview] bounds].size.width - sFrame.size.width) / 2 - aMargin.width);
    sFrame.origin.y = (NSInteger)(([[self superview] bounds].size.height - sFrame.size.height) / 2 - aMargin.height);
    [self setFrame:sFrame];
}


#pragma mark -


- (void)moveToHorizontalCenter
{
    NSAssert([self superview], @"");
    
    CGRect sFrame = [self frame];
    
    sFrame.origin.x = (NSInteger)(([[self superview] bounds].size.width - sFrame.size.width) / 2);
    [self setFrame:sFrame];
}


- (void)moveToVerticalCenter
{
    NSAssert([self superview], @"");
    
    CGRect sFrame = [self frame];
    
    sFrame.origin.y = (NSInteger)(([[self superview] bounds].size.height - sFrame.size.height) / 2);
    [self setFrame:sFrame];
}

@end
