//
//  XBPopUpService.h
//  XBPopUpViewDemo
//
//  Created by xbingo on 2018/8/17.
//  Copyright © 2018年 xbingo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XBPopUpProtocol.h"

@interface XBPopUpService : NSObject

+ (instancetype)sharedService;

/**
 默认自定义动画（背景渐变、缩放）
 
 @param popUpView 自定义弹窗
 @param priority 优先级
 @param emptyAreaEnabled 是否激活点击空白区域隐藏

 */
- (void)showDefaultCustomPopUpView:(UIView<XBPopUpViewDelegate> *)popUpView
                          priority:(XBPopUpPriority)priority
                  emptyAreaEnabled:(BOOL)emptyAreaEnabled;


/**
 默认系统Present动画
 
 @param popUpView 自定义弹窗
 @param priority 优先级
 @param emptyAreaEnabled 是否激活点击空白区域隐藏
 */
- (void)showDefaultPresentPopUpView:(UIView<XBPopUpViewDelegate> *)popUpView
                           priority:(XBPopUpPriority)priority
                   emptyAreaEnabled:(BOOL)emptyAreaEnabled;


/**
 自定义出场、退场效果
 
 @param popUpView 自定义弹窗
 @param priority 优先级
 @param emptyAreaEnabled 是否激活点击空白区域隐藏
 @param presentTransitioning 出场效果
 @param dismissTransitioning 退场效果
 */
- (void)showCustomPopUpView:(UIView<XBPopUpViewDelegate> *)popUpView
                   priority:(XBPopUpPriority)priority
           emptyAreaEnabled:(BOOL)emptyAreaEnabled
       presentTransitioning:(id<UIViewControllerAnimatedTransitioning>)presentTransitioning
       dismissTransitioning:(id<UIViewControllerAnimatedTransitioning>)dismissTransitioning;

@end
