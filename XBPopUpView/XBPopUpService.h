//
//  XBPopUpService.h
//  XBPopUpViewDemo
//
//  Created by xbingo on 2018/8/17.
//  Copyright © 2018年 xbingo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XBPopUpProtocol.h"
#import "XBPopUpQueue.h"

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
 默认自定义动画（背景渐变、缩放）
 
 @param popUpView 自定义弹窗
 @param priority 优先级
 @param lowerPriorityHidden 已经展示时，如果有更高优先级的则暂时隐藏
 @param fromType 通过根控制器或者当前控制器做present（仅针对控制器容器）
 @param emptyAreaEnabled 是否激活点击空白区域隐藏
 
 */
- (void)showDefaultCustomPopUpView:(UIView<XBPopUpViewDelegate> *)popUpView
                          priority:(XBPopUpPriority)priority
               lowerPriorityHidden:(BOOL)lowerPriorityHidden
                          fromType:(XBPopUpFromType)fromType
                  emptyAreaEnabled:(BOOL)emptyAreaEnabled;


/**
 默认系统Present动画
 
 @param popUpView 自定义弹窗
 @param priority 优先级
 @param lowerPriorityHidden 已经展示时，如果有更高优先级的则暂时隐藏
 @param fromType 通过根控制器或者当前控制器做present（仅针对控制器容器）
 @param emptyAreaEnabled 是否激活点击空白区域隐藏
 */
- (void)showDefaultPresentPopUpView:(UIView<XBPopUpViewDelegate> *)popUpView
                           priority:(XBPopUpPriority)priority
                lowerPriorityHidden:(BOOL)lowerPriorityHidden
                           fromType:(XBPopUpFromType)fromType
                   emptyAreaEnabled:(BOOL)emptyAreaEnabled;


/**
 自定义出场、退场效果
 
 @param popUpView 自定义弹窗
 @param priority 优先级
 @param lowerPriorityHidden 已经展示时，如果有更高优先级的则暂时隐藏
 @param fromType 通过根控制器或者当前控制器做present（仅针对控制器容器）
 @param emptyAreaEnabled 是否激活点击空白区域隐藏
 @param presentTransitioning 出场效果
 @param dismissTransitioning 退场效果
 */
- (void)showCustomPopUpView:(UIView<XBPopUpViewDelegate> *)popUpView
                   priority:(XBPopUpPriority)priority
        lowerPriorityHidden:(BOOL)lowerPriorityHidden
                   fromType:(XBPopUpFromType)fromType
           emptyAreaEnabled:(BOOL)emptyAreaEnabled
       presentTransitioning:(id<UIViewControllerAnimatedTransitioning>)presentTransitioning
       dismissTransitioning:(id<UIViewControllerAnimatedTransitioning>)dismissTransitioning;

@end
