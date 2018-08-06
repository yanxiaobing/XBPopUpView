//
//  XBPopUpBaseView.h
//  XBPopUpViewDemo
//
//  Created by xbingo on 2018/8/6.
//  Copyright © 2018年 xbingo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger , XBPopUpViewHideType){
    XBPopUpViewHideTypeClickEmptyArea = 0, // 点击空白区域
    XBPopUpViewHideTypeAfterSelected, // 选中了相应的内容之后隐藏popView
    XBPopUpViewHideTypeClickCloseBtn, // 点击了关闭的相关控件（如关闭按钮等）
};

typedef void(^XBPopUpViewWillHideBlock)(XBPopUpViewHideType popUpViewHideType);

typedef void(^XBPopUpViewDidHidenBlock)(XBPopUpViewHideType popUpViewHideType);

@interface XBPopUpBaseView : UIView

/**
 隐藏popView
 */
@property (nonatomic ,copy) XBPopUpViewWillHideBlock willHideBlock;


/**
 隐藏popView之后的回调
 */
@property (nonatomic ,copy) XBPopUpViewDidHidenBlock didHidenBlock;

@end
