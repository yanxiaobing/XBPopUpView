//
//  UIColor+XBColor.m
//  XBDevelopToolsDemo
//
//  Created by xbingo on 2018/7/20.
//  Copyright © 2018年 xbingo. All rights reserved.
//

#import "UIColor+XBColor.h"

@implementation UIColor (XBColor)

+ (UIColor *)xb_randomColor{
    int r = (arc4random() % 256) ;
    int g = (arc4random() % 256) ;
    int b = (arc4random() % 256) ;
    return [self xb_colorWithRed:r green:g blue:b];
}

+ (UIColor *)xb_colorWithRed:(float)red green:(float)green blue:(float)blue {
    return [UIColor xb_colorWithRed:red green:green blue:blue alpha:1.0f];
}

+ (UIColor *)xb_colorWithRed:(float)red green:(float)green blue:(float)blue alpha:(float)alpha {
    return [UIColor colorWithRed:red/255.0f green:green/255.0f blue:blue/255.0f alpha:alpha];
}

+ (UIColor *)xb_colorWithHexString: (NSString *)color
{
    return [self xb_colorWithHexString:color alpha:1.0f];
}

+ (UIColor *)xb_colorWithHexString: (NSString *)color alpha:(float)alpha
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    // r
    NSString *rString = [cString substringWithRange:range];
    
    // g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    // b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [self xb_colorWithRed:r green:g blue:b alpha:alpha];
}

@end
