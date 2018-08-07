//
//  XBPopUpView.m
//  XBPopUpViewDemo
//
//  Created by xbingo on 2018/8/7.
//  Copyright © 2018年 xbingo. All rights reserved.
//

#import "XBTestPopUpView.h"
#import "XBPopUpQueue.h"

@interface XBTestPopUpView()

@property (nonatomic ,strong) UIView *containView;

@property (nonatomic ,copy) UIButton *closeBtn;

@end

@implementation XBTestPopUpView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _containView = [[UIView alloc]initWithFrame:self.bounds];
        _containView.backgroundColor = [UIColor cyanColor];
        [self addSubview:_containView];
        
        _closeBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 40)];
        _closeBtn.backgroundColor = [UIColor redColor];
        [_closeBtn addTarget:self action:@selector(close:) forControlEvents:UIControlEventTouchUpInside];
        _closeBtn.center = self.center;
        [self addSubview:_closeBtn];
    }
    return self;
}

-(void)close:(UIButton *)sender{
    [self dismiss];
}

-(void)present{
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.alpha = 0;
    self.transform = CGAffineTransformMakeScale(0.1, 0.1);
    [UIView animateWithDuration:3 animations:^{
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        self.alpha = 1;
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
    
}

-(void)dismiss{
    [UIView animateWithDuration:4 animations:^{
        self.alpha = 0;
        self.transform = CGAffineTransformMakeScale(0.1, 0.1);
    } completion:^(BOOL finished) {
        [[XBPopUpQueue sharedService] removeView:self];
    }];
}

@end
