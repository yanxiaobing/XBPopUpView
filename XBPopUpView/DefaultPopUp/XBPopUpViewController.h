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

-(instancetype)initWithPopUpView:(UIView<XBPopUpViewDelegate> *)popUpView
                emptyAreaEnabled:(BOOL)emptyAreaEnabled
                        priority:(XBPopUpPriority)priority
            presentTransitioning:(id<UIViewControllerAnimatedTransitioning>)presentTransitioning
            dismissTransitioning:(id<UIViewControllerAnimatedTransitioning>)dismissTransitioning;

@end
