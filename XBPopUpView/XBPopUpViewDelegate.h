//
//  XBPopUpViewDelegate.h
//  XBPopUpViewDemo
//
//  Created by xbingo on 2018/8/6.
//  Copyright © 2018年 xbingo. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger , XBPopUpPriority){
    XBPopUpPriorityVeryHigh = 4,
    XBPopUpPriorityHigh = 3,
    XBPopUpPriorityNormal = 2,
    XBPopUpPriorityLow = 1,
};


@protocol XBPopUpViewDelegate <NSObject>
@required
- (XBPopUpPriority)priority;
@optional

- (void)present;

- (void)dismiss;

@end


