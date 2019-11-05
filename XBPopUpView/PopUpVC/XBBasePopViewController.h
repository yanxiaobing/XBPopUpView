//
//  XBBasePopViewController.h
//  XBPopUpViewDemo
//
//  Created by xbingo on 2019/11/1.
//  Copyright © 2019 xbingo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBPopUpQueue.h"

NS_ASSUME_NONNULL_BEGIN

@interface XBBasePopViewController : UIViewController<XBPopUpDelegate,XBPopUpViewDelegate,UIViewControllerTransitioningDelegate>
/**
 将弹窗添加进展示队列，并添加弹窗隐藏处理block
*/
-(void)showInPopUpQueue:(XBPopUpViewDidHidenBlock)didHidenBlock;

/**
弹窗内容，通常弹窗的UI都应该添加在该视图下，默认会对该视图做transform动画
*/
@property (nonatomic ,strong ,readonly) UIView *popUpContentView;

/**
YES：已展示的状态下，如果有优先级更高的弹窗，暂时隐藏自己  NO：展示状态下一定要处理完才隐藏自己  默认值：NO
*/
@property (nonatomic, assign) BOOL lowerPriorityHidden;

/**
 是否激活点击空白区域隐藏
 */
@property (nonatomic, assign) BOOL emptyAreaEnabled;

/**
当有多个的时候展示优先级
*/
@property (nonatomic, assign) XBPopUpPriority priority;

/**
通过根控制器或者当前控制器做present（仅针对控制器容器）
*/
@property (nonatomic, assign) XBPopUpFromType fromType;

/**
 自定义出场动画
 */
@property (nonatomic ,strong ,nullable) id<UIViewControllerAnimatedTransitioning> presentTransitioning;

/**
 自定义退场动画
 */
@property (nonatomic ,strong ,nullable) id<UIViewControllerAnimatedTransitioning> dismissTransitioning;

/**
 实现该方法，自定义出场效果
 */
- (void)present;

/**
 实现该方法，自定义退场效果，记得将视图移出队列
 */
- (void)dismiss;

/**
遇到优先级更高的弹窗，临时隐藏当前弹窗，并在隐藏之后把事件回调出去
*/
- (void)temporarilyDismissAnimated:(BOOL)animated completion:(void (^ __nullable)(void))completion;





/**
 /// 隐藏popView，popViewController内部赋值实现隐藏逻辑，并在适当的时机调用didHidenBlock将事件跑出去
 /// (因该block被设计为内部实现，故不再做“显式”暴露，如果确实有需要外部赋值也可以直接xxx.willHideBlock)
 @property (nonatomic ,copy) XBPopUpViewWillHideBlock _Nonnull willHideBlock;
 */

/**
 /// 隐藏popView之后的回调，在popViewController外部赋值，处理弹窗相关的操作结果
 /// (推荐使用showInPopUpQueue: api的方式赋值m，故不再做“显式”声明)
 @property (nonatomic ,copy) XBPopUpViewDidHidenBlock _Nullable didHidenBlock;
 */

@end

NS_ASSUME_NONNULL_END
