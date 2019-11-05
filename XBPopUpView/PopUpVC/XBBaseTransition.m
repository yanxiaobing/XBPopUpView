//
//  XBBaseTransition.m
//  XBPopUpViewDemo
//
//  Created by xbingo on 2019/11/4.
//  Copyright © 2019 xbingo. All rights reserved.
//

#import "XBBaseTransition.h"
#import "XBBasePopViewController.h"

@interface XBBaseTransition()

@end

@implementation XBBaseTransition

+ (instancetype)presentTransition{
    return [self new];
}

+ (instancetype)dismissTransition{
    XBBaseTransition *transition = [self new];
    transition.dismiss = YES;
    return transition;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _minScale = 0.85f;
        _maxScale = 1.0f;
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    if (_dismiss) {
        
        UINavigationController *navigationController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        XBBasePopViewController *popUpViewController = navigationController.viewControllers.firstObject;
        
        [UIView animateWithDuration:duration
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
            navigationController.view.alpha = 0;
            popUpViewController.popUpContentView.transform = CGAffineTransformMakeScale(self.minScale, self.minScale);
        } completion:^(BOOL finished) {
            [navigationController.view removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
        
    } else {
        
        UINavigationController *navigationController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        XBBasePopViewController *popUpViewController = navigationController.viewControllers.firstObject;
        
        UIView *containerView = [transitionContext containerView];
        [containerView addSubview:navigationController.view];
        
        navigationController.view.alpha = 0.0;
        popUpViewController.popUpContentView.transform = CGAffineTransformMakeScale(self.minScale, self.minScale);
        [UIView animateWithDuration:duration
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
            navigationController.view.alpha = 1.0;
            popUpViewController.popUpContentView.transform = CGAffineTransformMakeScale(self.maxScale, self.maxScale);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
}

@end
