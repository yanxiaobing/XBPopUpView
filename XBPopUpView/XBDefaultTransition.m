//
//  XBDefaultTransition.m
//  XBPopUpViewDemo
//
//  Created by xbingo on 2018/8/6.
//  Copyright © 2018年 xbingo. All rights reserved.
//

#import "XBDefaultTransition.h"

@implementation XBDefaultTransition

+ (instancetype)presentTransition{
    return [XBDefaultTransition new];
}

+ (instancetype)dismissTransition{
    XBDefaultTransition *transition = [XBDefaultTransition new];
    transition.dismiss = YES;
    return transition;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    if (_dismiss) {
        
        XBPopUpViewController *popUpViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            popUpViewController.view.alpha = 0;
            popUpViewController.popUpView.transform = CGAffineTransformMakeScale(0.85, 0.85);
        } completion:^(BOOL finished) {
            [popUpViewController.view removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
        
    } else {
        
        XBPopUpViewController *popUpViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        UIView *containerView = [transitionContext containerView];
        popUpViewController.view.frame = containerView.bounds;
        [containerView addSubview:popUpViewController.view];
        
        popUpViewController.view.alpha = 0.0;
        popUpViewController.popUpView.transform = CGAffineTransformMakeScale(0.85, 0.85);
        
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            popUpViewController.view.alpha = 1.0;
            popUpViewController.popUpView.transform = CGAffineTransformMakeScale(1.0, 1.0);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
}

@end
