//
//  XBDefaultTransition.h
//  XBPopUpViewDemo
//
//  Created by xbingo on 2018/8/6.
//  Copyright © 2018年 xbingo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XBPopUpViewController.h"

@interface XBDefaultTransition : NSObject<UIViewControllerAnimatedTransitioning>

+(instancetype)presentTransition;

+(instancetype)dismissTransition;

@property (nonatomic, assign) BOOL dismiss;
@end
