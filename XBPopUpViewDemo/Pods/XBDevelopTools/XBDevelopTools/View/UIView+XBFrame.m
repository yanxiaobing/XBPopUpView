//
//  UIView+XBFrame.m
//  XBDevelopToolsDemo
//
//  Created by xbingo on 2018/7/20.
//  Copyright © 2018年 xbingo. All rights reserved.
//

#import "UIView+XBFrame.h"

@implementation UIView (XBFrame)

-(CGFloat)xb_width{
    return self.frame.size.width;
}

-(void)setXb_width:(CGFloat)xb_width{
    CGRect frame = self.frame;
    frame.size.width = xb_width;
    self.frame = frame;
}

-(CGFloat)xb_height{
    return self.frame.size.height;
}

-(void)setXb_height:(CGFloat)xb_height{
    CGRect frame = self.frame;
    frame.size.height = xb_height;
    self.frame = frame;
}

-(CGFloat)xb_top{
    return self.frame.origin.y;
}

-(void)setXb_top:(CGFloat)xb_top{
    CGRect frame = self.frame;
    frame.origin.y = xb_top;
    self.frame = frame;
}

- (CGFloat)xb_left{
    return self.frame.origin.x;
}

-(void)setXb_left:(CGFloat)xb_left{
    CGRect frame = self.frame;
    frame.origin.x = xb_left;
    self.frame = frame;
}

- (CGFloat)xb_bottom{
    return self.frame.origin.y + self.frame.size.height;
}

-(void)setXb_bottom:(CGFloat)xb_bottom{
    CGRect frame = self.frame;
    frame.origin.y = xb_bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)xb_right{
    return self.frame.origin.x + self.frame.size.width;
}

-(void)setXb_right:(CGFloat)xb_right{
    CGRect frame = self.frame;
    frame.origin.x = xb_right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)xb_centerX{
    return self.center.x;
}

-(void)setXb_centerX:(CGFloat)xb_centerX{
    CGPoint center = self.center;
    center.x = xb_centerX;
    self.center = center;
}

- (CGFloat)xb_centerY{
    return self.center.y;
}

- (void)setXb_centerY:(CGFloat)xb_centerY{
    CGPoint center = self.center;
    center.y = xb_centerY;
    self.center = center;
}

@end
