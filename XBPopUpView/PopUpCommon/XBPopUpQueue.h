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

-(void)showWithDependId:(NSString *)dependId;

/**
 弹窗队列单例方法

 @return 弹窗队列
 */
+ (instancetype)sharedService;

/**
 添加弹窗视图到队列中

 @param popUpView 弹窗视图
 */
- (void)addView:(id<XBPopUpDelegate>)popUpView;

/**
 从队列中移出弹窗视图

 @param popUpView 弹窗视图
 */
- (void)removeView:(id<XBPopUpDelegate>)popUpView;

@end
