//
//  XBBaseTransition.h
//  XBPopUpViewDemo
//
//  Created by xbingo on 2019/11/4.
//  Copyright © 2019 xbingo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XBBasePopViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface XBBaseTransition : NSObject<UIViewControllerAnimatedTransitioning>

+(instancetype)presentTransition;

+(instancetype)dismissTransition;

@property (nonatomic, assign) BOOL dismiss;

@property (nonatomic, assign) CGFloat minScale;
@property (nonatomic, assign) CGFloat maxScale;

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext;

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext;

@end

NS_ASSUME_NONNULL_END
