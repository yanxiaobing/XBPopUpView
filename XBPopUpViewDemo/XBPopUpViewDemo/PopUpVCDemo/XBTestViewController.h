//
//  XBTestViewController.h
//  XBPopUpViewDemo
//
//  Created by xbingo on 2019/11/4.
//  Copyright © 2019 xbingo. All rights reserved.
//

#import "XBBasePopViewController.h"
#import "XBTestTransition.h"

NS_ASSUME_NONNULL_BEGIN

@interface XBTestViewController : XBBasePopViewController

@property (nonatomic ,copy) NSString *des;

@property (nonatomic ,strong) UIButton *testBtn;

@end

NS_ASSUME_NONNULL_END
