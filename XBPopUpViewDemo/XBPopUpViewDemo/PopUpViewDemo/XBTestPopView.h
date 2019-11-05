//
//  XBTestPopView.h
//  XBPopUpViewDemo
//
//  Created by xbingo on 2018/8/6.
//  Copyright © 2018年 xbingo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBPopUpProtocol.h"

@interface XBTestPopView : UIView<XBPopUpViewDelegate>

- (instancetype)initWithSize:(CGSize)size;

@end
