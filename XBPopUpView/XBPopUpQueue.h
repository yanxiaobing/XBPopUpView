//
//  XBPopUpQueue.h
//  XBPopUpViewDemo
//
//  Created by xbingo on 2018/8/6.
//  Copyright © 2018年 xbingo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XBPopUpProtocol.h"

@interface XBPopUpQueue : NSObject

+ (instancetype)sharedService;

- (void)addView:(id<XBPopUpDelegate>)popUpView;
- (void)removeView:(id<XBPopUpDelegate>)popUpView;

@end
