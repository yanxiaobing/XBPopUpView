//
//  UIViewController+XBCurrent.m
//  XBPopUpViewDemo
//
//  Created by xbingo on 2019/11/5.
//  Copyright © 2019 xbingo. All rights reserved.
//

#import "UIViewController+XBPopUp.h"
#import <objc/runtime.h>
#import "XBPopUpQueue.h"
#import "XBPopUpProtocol.h"

@implementation UIViewController (XBPopUp)

+(void)load{
    Method m1 = class_getInstanceMethod([self class], @selector(viewWillAppear:));
    Method m2 = class_getInstanceMethod([self class], @selector(xb_viewWillAppear:));
    method_exchangeImplementations(m1, m2);
}

-(void)xb_viewWillAppear:(BOOL)animated{
    [self xb_viewWillAppear:animated];
    
    [XBPopUpQueue.sharedService showWithDependId:[NSString stringWithFormat:@"%p",self]];
}

- (NSString *)xb_dependId{
    return [NSString stringWithFormat:@"%p",self];
}

+ (UIViewController*)xb_currentViewController {
    UIViewController* rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    return [self xb_currentViewControllerFrom:rootViewController];
}

// 通过递归拿到当前控制器
+ (UIViewController*)xb_currentViewControllerFrom:(UIViewController*)viewController {
    
    if ([viewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController *)viewController;
        return [self xb_currentViewControllerFrom:navigationController.viewControllers.lastObject];
    } // 如果传入的控制器是导航控制器,则返回最后一个
    else if([viewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController *)viewController;
        return [self xb_currentViewControllerFrom:tabBarController.selectedViewController];
    } // 如果传入的控制器是tabBar控制器,则返回选中的那个
    else if(viewController.presentedViewController != nil) {
        return [self xb_currentViewControllerFrom:viewController.presentedViewController];
    } // 如果传入的控制器发生了modal,则就可以拿到modal的那个控制器
    else {
        return viewController;
    }
}

@end
