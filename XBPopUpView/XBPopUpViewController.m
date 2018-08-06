//
//  XBPopUpViewController.m
//  XBPopUpViewDemo
//
//  Created by xbingo on 2018/8/6.
//  Copyright © 2018年 xbingo. All rights reserved.
//

#import "XBPopUpViewController.h"

@interface XBPopUpViewController ()

@end

@implementation XBPopUpViewController

-(void)dealloc{
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    
    _popUpView.center = self.view.center;
    [self.view addSubview:_popUpView];
    __weak typeof(self) weakSelf = self;
    __weak typeof(_popUpView) weakView = _popUpView;
    
    _popUpView.willHideBlock = ^(XBPopUpViewHideType popUpViewHideType) {
        [weakSelf dismissViewControllerAnimated:YES completion:^{
            [weakSelf dismiss];
            if (weakView.didHidenBlock) {
                weakView.didHidenBlock(popUpViewHideType);
            }
        }];
    };
}

-(instancetype)initWithPopUpView:(XBPopUpBaseView *)popUpView
                 emptyAreaEnabled:(BOOL)emptyAreaEnabled
                        priority:(XBPopUpPriority)priority
            presentTransitioning:(id<UIViewControllerAnimatedTransitioning>)presentTransitioning
            dismissTransitioning:(id<UIViewControllerAnimatedTransitioning>)dismissTransitioning{
    self = [super init];
    if (self) {
        _popUpView = popUpView;
        _emptyAreaEnabled = emptyAreaEnabled;
        _priority = priority;
        _presentTransitioning = presentTransitioning;
        _dismissTransitioning = dismissTransitioning;
    }
    return self;
}

+ (void)showDefaultCustomPopUpView:(XBPopUpBaseView *)popUpView
                  emptyAreaEnabled:(BOOL)emptyAreaEnabled
                          priority:(XBPopUpPriority)priority{
    [self showCustomPopUpView:popUpView emptyAreaEnabled:emptyAreaEnabled priority:priority presentTransitioning:[XBDefaultTransition presentTransition] dismissTransitioning:[XBDefaultTransition dismissTransition]];
}

+ (void)showDefaultPresentPopUpView:(XBPopUpBaseView *)popUpView
                   emptyAreaEnabled:(BOOL)emptyAreaEnabled
                           priority:(XBPopUpPriority)priority{
    [self showCustomPopUpView:popUpView emptyAreaEnabled:emptyAreaEnabled priority:priority presentTransitioning:nil dismissTransitioning:nil];
}

+ (void)showCustomPopUpView:(XBPopUpBaseView *)popUpView
           emptyAreaEnabled:(BOOL)emptyAreaEnabled
                   priority:(XBPopUpPriority)priority
       presentTransitioning:(id<UIViewControllerAnimatedTransitioning>)presentTransitioning
       dismissTransitioning:(id<UIViewControllerAnimatedTransitioning>)dismissTransitioning{
    
    XBPopUpViewController * popUpViewController = [[XBPopUpViewController alloc]initWithPopUpView:popUpView emptyAreaEnabled:emptyAreaEnabled priority:priority presentTransitioning:presentTransitioning dismissTransitioning:dismissTransitioning];
    [[XBPopUpQueue sharedService] addView:popUpViewController];
}


-(void)present{

    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    if (_presentTransitioning && _dismissTransitioning) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self;
    }else{
        self.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        rootViewController.definesPresentationContext = YES;
    }
    [rootViewController presentViewController:self animated:YES completion:nil];
}

-(void)dismiss{
    [[XBPopUpQueue sharedService] removeView:self];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source{
    return _presentTransitioning;
}


- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
    return _dismissTransitioning;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    __weak typeof(self) weakSelf = self;
    if (_emptyAreaEnabled) {
        [self dismissViewControllerAnimated:YES completion:^{
            [weakSelf dismiss];
            if (weakSelf.popUpView.didHidenBlock) {
                weakSelf.popUpView.didHidenBlock(XBPopUpViewHideTypeClickEmptyArea);
            }
        }];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
