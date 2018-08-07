//
//  XBPopUpViewController.h
//  XBPopUpViewDemo
//
//  Created by xbingo on 2018/8/6.
//  Copyright © 2018年 xbingo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBPopUpQueue.h"
#import "XBDefaultTransition.h"

@interface XBPopUpViewController : UIViewController<XBPopUpDelegate,UIViewControllerTransitioningDelegate>

#pragma mark -- XBPopUpDelegate property

/**
 弹窗视图
 */
@property (nonatomic ,strong) UIView<XBPopUpViewDelegate> *popUpView;

/**
 弹窗优先级
 */
@property (nonatomic, assign) XBPopUpPriority priority;

#pragma mark -- custom expand property

/**
 是否激活点击空白区域隐藏
 */
@property (nonatomic, assign) BOOL emptyAreaEnabled;


/**
 自定义出场动画
 */
@property (nonatomic ,strong) id<UIViewControllerAnimatedTransitioning> presentTransitioning;


/**
 自定义退场动画
 */
@property (nonatomic ,strong) id<UIViewControllerAnimatedTransitioning> dismissTransitioning;

#pragma mark -- class mehtods

/**
 默认自定义动画（背景渐变、缩放）

 @param popUpView 自定义弹窗
 @param emptyAreaEnabled 是否激活点击空白区域隐藏
 @param priority 优先级
 */
+ (void)showDefaultCustomPopUpView:(UIView<XBPopUpViewDelegate> *)popUpView
                  emptyAreaEnabled:(BOOL)emptyAreaEnabled
                          priority:(XBPopUpPriority)priority;

/**
 默认系统Present动画
 
 @param popUpView 自定义弹窗
 @param emptyAreaEnabled 是否激活点击空白区域隐藏
 @param priority 优先级
 */
+ (void)showDefaultPresentPopUpView:(UIView<XBPopUpViewDelegate> *)popUpView
            emptyAreaEnabled:(BOOL)emptyAreaEnabled
                    priority:(XBPopUpPriority)priority;


/**
 自定义出场、退场效果
 
 @param popUpView 自定义弹窗
 @param emptyAreaEnabled 是否激活点击空白区域隐藏
 @param priority 优先级
 @param presentTransitioning 出场效果
 @param dismissTransitioning 退场效果
 */
+ (void)showCustomPopUpView:(UIView<XBPopUpViewDelegate> *)popUpView
     emptyAreaEnabled:(BOOL)emptyAreaEnabled
             priority:(XBPopUpPriority)priority
 presentTransitioning:(id<UIViewControllerAnimatedTransitioning>)presentTransitioning
 dismissTransitioning:(id<UIViewControllerAnimatedTransitioning>)dismissTransitioning;

@end
