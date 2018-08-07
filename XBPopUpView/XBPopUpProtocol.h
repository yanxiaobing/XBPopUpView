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

@end

@protocol XBPopUpVCDelegate <NSObject>

@required

@property (nonatomic ,strong) UIView<XBPopUpViewDelegate> *popUpView;

- (XBPopUpPriority)priority;

- (void)present;

- (void)dismiss;

@end

