//
//  XBPopUpProtocol.h
//  XBPopUpViewDemo
//
//  Created by xbingo on 2018/8/7.
//  Copyright © 2018年 xbingo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XBPopUpBaseView.h"

typedef NS_ENUM(NSInteger , XBPopUpPriority){
    XBPopUpPriorityVeryHigh = 4,
    XBPopUpPriorityHigh = 3,
    XBPopUpPriorityNormal = 2,
    XBPopUpPriorityLow = 1,
};


@protocol XBPopUpVCDelegate <NSObject>

@required

@property (nonatomic ,strong) XBPopUpBaseView *popUpView;

- (XBPopUpPriority)priority;

- (void)present;

- (void)dismiss;

@end
