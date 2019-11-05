//
//  XBBaseTransition.h
//  XBPopUpViewDemo
//
//  Created by xbingo on 2019/11/4.
//  Copyright © 2019 xbingo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XBBaseTransition : NSObject<UIViewControllerAnimatedTransitioning>

/// present动画实例
+(instancetype)presentTransition;

/// dismiss动画实例
+(instancetype)dismissTransition;

/// 自定义动画，主要重写该方法！！！！！！！！！！
/// 动画的具体实现
/// @param transitionContext 动画上下文
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext;

/// 动画时长（默认0.25s）
/// @param transitionContext 动画上下文
- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext;

/// 区分present还是dismiss，dismiss == YES 则为dismiss，默认dismiss == NO
@property (nonatomic, assign) BOOL dismiss;

/// popUpContentView transform scale 最小值（默认0.85）
@property (nonatomic, assign) CGFloat minScale;

/// popUpContentView transform scale 最大值（默认1.0）
@property (nonatomic, assign) CGFloat maxScale;

@end

NS_ASSUME_NONNULL_END
