//
//  UIViewController+XBPopUp.h
//  XBPopUpViewDemo
//
//  Created by xbingo on 2019/11/5.
//  Copyright © 2019 xbingo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (XBPopUp)

+(void)load;

// 获取UIViewController的内存地址
@property (nonatomic ,copy ,readonly) NSString *xb_dependId;


+ (UIViewController*)xb_currentViewController;

// 通过递归拿到当前控制器
+ (UIViewController*)xb_currentViewControllerFrom:(UIViewController*)viewController;

@end

NS_ASSUME_NONNULL_END
