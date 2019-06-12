//
//  XBPopUpProtocol.h
//  XBPopUpViewDemo
//
//  Created by xbingo on 2018/8/7.
//  Copyright © 2018年 xbingo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , XBPopUpFromType){
    XBPopUpFromRoot,
    XBPopUpFromCurrentVC
};

typedef NS_ENUM(NSInteger , XBPopUpPriority){
    XBPopUpPriorityVeryHigh = 4,
    XBPopUpPriorityHigh = 3,
    XBPopUpPriorityNormal = 2,
    XBPopUpPriorityLow = 1,
};

typedef NS_ENUM(NSInteger , XBPopUpViewHideType){
    XBPopUpViewHideTypeClickEmptyArea = 0, // 点击空白区域
    XBPopUpViewHideTypeAfterSelected, // 选中了相应的内容之后隐藏popView
    XBPopUpViewHideTypeClickCloseBtn, // 点击了关闭的相关控件（如关闭按钮等）
};

typedef void(^XBPopUpViewWillHideBlock)(XBPopUpViewHideType popUpViewHideType);

typedef void(^XBPopUpViewDidHidenBlock)(XBPopUpViewHideType popUpViewHideType);

/*************************XBPopUpViewDelegate****************************/

@protocol XBPopUpViewDelegate <NSObject>

@required

/**
 隐藏popView
 */
@property (nonatomic ,copy) XBPopUpViewWillHideBlock _Nonnull willHideBlock;

/**
 隐藏popView之后的回调
 */
@property (nonatomic ,copy) XBPopUpViewDidHidenBlock _Nullable didHidenBlock;


@optional
/**
 弹窗相对中心位置的偏移
 */
@property (nonatomic, assign) CGPoint centerOffset;

@end

/*************************XBPopUpDelegate****************************/

@protocol XBPopUpDelegate <NSObject>

@required

/**
 当有多个的时候展示优先级
 */
@property (nonatomic, assign) XBPopUpPriority priority;

/**
 实现该方法，自定义出场效果
 */
- (void)present;

/**
 实现该方法，自定义退场效果，记得将视图移出队列
 */
- (void)dismiss;

@optional

@property (nonatomic ,strong) UIView<XBPopUpViewDelegate> * _Nullable popUpView;

/**
 通过根控制器或者当前控制器做present（仅针对控制器容器）
 */
@property (nonatomic, assign) XBPopUpFromType fromType;

/**
 YES：已展示的状态下，如果有优先级更高的弹窗，暂时隐藏自己  NO：展示状态下一定要处理完才隐藏自己  默认值：NO
 */
@property (nonatomic, assign) BOOL lowerPriorityHidden;

/**
 临时隐藏弹窗，但是不移出队列
 
 @param animated 是否动画
 @param completion 隐藏动画完成回调
 */
- (void)temporarilyDismissAnimated:(BOOL)animated completion:(void (^ __nullable)(void))completion;



@end

