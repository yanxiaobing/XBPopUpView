//
//  XBTestTransition.m
//  XBPopUpViewDemo
//
//  Created by xbingo on 2019/11/4.
//  Copyright © 2019 xbingo. All rights reserved.
//

#import "XBTestTransition.h"
#import "XBTestViewController.h"

@implementation XBTestTransition

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext{
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    if (self.dismiss) {
        
        UINavigationController *navigationController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        XBTestViewController *popUpViewController = navigationController.viewControllers.firstObject;
        
        [UIView animateWithDuration:duration
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
            navigationController.view.alpha = 0;
            popUpViewController.popUpContentView.transform = CGAffineTransformMakeScale(self.minScale, self.minScale);
            popUpViewController.testBtn.transform = CGAffineTransformMakeScale(self.maxScale, self.maxScale);
        } completion:^(BOOL finished) {
            [navigationController.view removeFromSuperview];
            [transitionContext completeTransition:YES];
        }];
        
    } else {
        
        UINavigationController *navigationController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        XBTestViewController *popUpViewController = navigationController.viewControllers.firstObject;
        
        UIView *containerView = [transitionContext containerView];
        [containerView addSubview:navigationController.view];
        
        
        
        navigationController.view.alpha = 0.0;
        popUpViewController.popUpContentView.transform = CGAffineTransformMakeScale(self.minScale, self.minScale);
        popUpViewController.testBtn.transform = CGAffineTransformMakeScale(self.maxScale, self.maxScale);
        [UIView animateWithDuration:duration
                              delay:0
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
            navigationController.view.alpha = 1.0;
            popUpViewController.popUpContentView.transform = CGAffineTransformMakeScale(self.maxScale, self.maxScale);
            popUpViewController.testBtn.transform = CGAffineTransformMakeScale(0.5, 0.5);
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
}

@end
