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

@interface XBPopUpViewController : UIViewController<XBPopUpVCDelegate,UIViewControllerTransitioningDelegate>

@property (nonatomic ,strong) UIView<XBPopUpViewDelegate> *popUpView;
@property (nonatomic, assign) BOOL emptyAreaEnabled;
@property (nonatomic, assign) XBPopUpPriority priority;
@property (nonatomic ,strong) id<UIViewControllerAnimatedTransitioning> presentTransitioning;
@property (nonatomic ,strong) id<UIViewControllerAnimatedTransitioning> dismissTransitioning;

+ (void)showDefaultCustomPopUpView:(UIView<XBPopUpViewDelegate> *)popUpView
                  emptyAreaEnabled:(BOOL)emptyAreaEnabled
                          priority:(XBPopUpPriority)priority;

+ (void)showDefaultPresentPopUpView:(UIView<XBPopUpViewDelegate> *)popUpView
            emptyAreaEnabled:(BOOL)emptyAreaEnabled
                    priority:(XBPopUpPriority)priority;

+ (void)showCustomPopUpView:(UIView<XBPopUpViewDelegate> *)popUpView
     emptyAreaEnabled:(BOOL)emptyAreaEnabled
             priority:(XBPopUpPriority)priority
 presentTransitioning:(id<UIViewControllerAnimatedTransitioning>)presentTransitioning
 dismissTransitioning:(id<UIViewControllerAnimatedTransitioning>)dismissTransitioning;

@end
