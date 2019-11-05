//
//  XBTestPopView.m
//  XBPopUpViewDemo
//
//  Created by xbingo on 2018/8/6.
//  Copyright © 2018年 xbingo. All rights reserved.
//

#import "XBTestPopView.h"

@interface XBTestPopView()

@property (nonatomic ,strong) UIButton *actionBtn;

@property (nonatomic ,strong) UIButton *closeBtn;

@end

@implementation XBTestPopView

@synthesize willHideBlock;
@synthesize didHidenBlock;
@synthesize centerOffset;

- (instancetype)initWithSize:(CGSize)size
{
    self = [super initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    if (self) {
        _actionBtn = [UIButton new];
        _actionBtn.backgroundColor = [UIColor redColor];
        _actionBtn.frame = CGRectMake(0, 0, CGRectGetMaxX(self.bounds), CGRectGetMaxX(self.bounds));
        [_actionBtn setTitle:@"自己看源码/README吧，我不想写demo了" forState:UIControlStateNormal];
        [_actionBtn addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_actionBtn];
        
        _closeBtn = [UIButton new];
        _closeBtn.backgroundColor = [UIColor blueColor];
        _closeBtn.frame = CGRectMake(0, CGRectGetMaxX(self.bounds), CGRectGetMaxX(self.bounds), CGRectGetMaxY(self.bounds) - CGRectGetMaxX(self.bounds));
        [_closeBtn setTitle:@"关闭" forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_closeBtn];
    }
    return self;
}


-(void)action:(UIButton *)sender{
    if (self.willHideBlock) {
        self.willHideBlock(XBPopUpViewHideTypeAfterSelected);
    }
}

-(void)close:(UIButton *)sender{
    
    if (self.willHideBlock) {
        self.willHideBlock(XBPopUpViewHideTypeClickCloseBtn);
    }
    
}

@end
