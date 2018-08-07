//
//  XBDefaultTransition.m
//  XBPopUpViewDemo
//
//  Created by xbingo on 2018/8/6.
//  Copyright © 2018年 xbingo. All rights reserved.
//

#import "XBDefaultTransition.h"

static CGFloat const kMinScale = 0.85;
static CGFloat const kMaxScale = 1.0;

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
        
        UINavigationController *navigationController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        id<XBPopUpDelegate> popUpViewController = navigationController.viewControllers.firstObject;
        
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            navigationController.view.alpha = 0;
            popUpViewController.popUpView.transform = CGAffineTransformMakeScale(kMinScale, kMinScale);
        } completion:^(BOOL finished) {
            [navigationController.view removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
        
    } else {
        
        UINavigationController *navigationController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        id<XBPopUpDelegate> popUpViewController = navigationController.viewControllers.firstObject;
        
        UIView *containerView = [transitionContext containerView];
        [containerView addSubview:navigationController.view];
        
        navigationController.view.alpha = 0.0;
        popUpViewController.popUpView.transform = CGAffineTransformMakeScale(kMinScale, kMinScale);
        [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            navigationController.view.alpha = 1.0;
            popUpViewController.popUpView.transform = CGAffineTransformMakeScale(kMaxScale, kMaxScale);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
}

@end
