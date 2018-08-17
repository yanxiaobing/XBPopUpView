//
//  XBPopUpProtocol.h
//  XBPopUpViewDemo
//
//  Created by xbingo on 2018/8/7.
//  Copyright © 2018年 xbingo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

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
@property (nonatomic ,copy) XBPopUpViewWillHideBlock willHideBlock;

/**
 隐藏popView之后的回调
 */
@property (nonatomic ,copy) XBPopUpViewDidHidenBlock didHidenBlock;


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

@property (nonatomic ,strong) UIView<XBPopUpViewDelegate> *popUpView;

@end

