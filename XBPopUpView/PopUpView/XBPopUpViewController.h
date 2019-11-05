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

-(instancetype)initWithPopUpView:(UIView<XBPopUpViewDelegate> *)popUpView
                emptyAreaEnabled:(BOOL)emptyAreaEnabled
                        priority:(XBPopUpPriority)priority
             lowerPriorityHidden:(BOOL)lowerPriorityHidden
                        fromType:(XBPopUpFromType)fromType
            presentTransitioning:(id<UIViewControllerAnimatedTransitioning>)presentTransitioning
            dismissTransitioning:(id<UIViewControllerAnimatedTransitioning>)dismissTransitioning;

@end
