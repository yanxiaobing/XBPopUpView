//
//  XBPopUpService.m
//  XBPopUpViewDemo
//
//  Created by xbingo on 2018/8/17.
//  Copyright © 2018年 xbingo. All rights reserved.
//

#import "XBPopUpService.h"
#import "XBPopUpViewController.h"

@implementation XBPopUpService

+ (instancetype)sharedService{
    static XBPopUpService *popUpService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        popUpService = [[XBPopUpService alloc] init];
    });
    return popUpService;
}

- (void)showDefaultCustomPopUpView:(UIView<XBPopUpViewDelegate> *)popUpView
                          priority:(XBPopUpPriority)priority
                  emptyAreaEnabled:(BOOL)emptyAreaEnabled{
    [self showCustomPopUpView:popUpView
                     priority:priority
             emptyAreaEnabled:emptyAreaEnabled
         presentTransitioning:[XBDefaultTransition presentTransition]
         dismissTransitioning:[XBDefaultTransition dismissTransition]];
}

- (void)showDefaultPresentPopUpView:(UIView<XBPopUpViewDelegate> *)popUpView
                           priority:(XBPopUpPriority)priority
                   emptyAreaEnabled:(BOOL)emptyAreaEnabled{
    [self showCustomPopUpView:popUpView
                     priority:priority
             emptyAreaEnabled:emptyAreaEnabled
         presentTransitioning:nil dismissTransitioning:nil];
}

- (void)showCustomPopUpView:(UIView<XBPopUpViewDelegate> *)popUpView
                   priority:(XBPopUpPriority)priority
           emptyAreaEnabled:(BOOL)emptyAreaEnabled
       presentTransitioning:(id<UIViewControllerAnimatedTransitioning>)presentTransitioning
       dismissTransitioning:(id<UIViewControllerAnimatedTransitioning>)dismissTransitioning{
    
    XBPopUpViewController * popUpVC = [[XBPopUpViewController alloc]initWithPopUpView:popUpView
                                                                     emptyAreaEnabled:emptyAreaEnabled
                                                                             priority:priority
                                                                 presentTransitioning:presentTransitioning
                                                                 dismissTransitioning:dismissTransitioning];
    [[XBPopUpQueue sharedService] addView:popUpVC];
}

@end
