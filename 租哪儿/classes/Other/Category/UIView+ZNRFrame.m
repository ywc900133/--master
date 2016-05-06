//
//  UIView+ZNRFrame.m
//  租哪儿
//
//  Created by yuan on 16/4/7.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import "UIView+ZNRFrame.h"

@implementation UIView (ZNRFrame)
- (void)setYwc_centerX:(CGFloat)ywc_centerX
{
    CGPoint center = self.center;
    center.x = ywc_centerX;
    self.center = center;
}

- (CGFloat)ywc_centerX
{
    return self.center.x;
    
}

- (void)setYwc_centerY:(CGFloat)ywc_centerY
{
    CGPoint center = self.center;
    center.x = ywc_centerY;
    self.center = center;
}
- (CGFloat)ywc_centerY
{
    return self.center.y;
    
}

- (CGFloat)width
{
    return self.bounds.size.width;
    
}
- (CGFloat)height
{
    return self.bounds.size.height;
    
}
- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
    
}
- (CGFloat)x
{
    return self.frame.origin.x;
}
- (CGFloat)y
{
    return self.frame.origin.y;
    
}
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
    
}
- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

@end
