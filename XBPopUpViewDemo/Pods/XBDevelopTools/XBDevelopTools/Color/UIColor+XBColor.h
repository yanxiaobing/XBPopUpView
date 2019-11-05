//
//  UIColor+XBColor.h
//  XBDevelopToolsDemo
//
//  Created by xbingo on 2018/7/20.
//  Copyright © 2018年 xbingo. All rights reserved.
//

#import <UIKit/UIKit.h>

#define XBRandomColor [UIColor xb_randomColor]

#define XBHexAlphaColor(hex,a) [UIColor xb_colorWithHexString:hex alpha:a]
#define XBHexColor(hex) XBHexAlphaColor(hex,1.0f)

#define XBRGBAColor(r,g,b,a) [UIColor xb_colorWithRed:r green:g blue:b alpha:a]
#define XBRGBColor(r,g,b) XBRGBAColor(r,g,b,1.0f)

@interface UIColor (XBColor)

+ (UIColor *)xb_randomColor;

+ (UIColor *)xb_colorWithHexString:(NSString *)color;

+ (UIColor *)xb_colorWithHexString:(NSString *)color
                             alpha:(float)alpha;

+ (UIColor *)xb_colorWithRed:(float)red
                       green:(float)green
                        blue:(float)blue;

+ (UIColor *)xb_colorWithRed:(float)red
                       green:(float)green
                        blue:(float)blue
                       alpha:(float)alpha;

@end
