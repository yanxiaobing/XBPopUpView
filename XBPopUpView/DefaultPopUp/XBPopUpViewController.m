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

@synthesize priority = _priority;
@synthesize popUpView = _popUpView;

-(instancetype)initWithPopUpView:(UIView<XBPopUpViewDelegate> *)popUpView
                emptyAreaEnabled:(BOOL)emptyAreaEnabled
                        priority:(XBPopUpPriority)priority
            presentTransitioning:(id<UIViewControllerAnimatedTransitioning>)presentTransitioning
            dismissTransitioning:(id<UIViewControllerAnimatedTransitioning>)dismissTransitioning{
    self = [super init];
    if (self) {
        _priority = priority;
        _popUpView = popUpView;
        _emptyAreaEnabled = emptyAreaEnabled;
        _presentTransitioning = presentTransitioning;
        _dismissTransitioning = dismissTransitioning;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    
    if ([_popUpView respondsToSelector:@selector(centerOffset)]) {
        _popUpView.center = CGPointMake(self.view.center.x + _popUpView.centerOffset.x, self.view.center.y + _popUpView.centerOffset.y);
    }else{
        _popUpView.center = self.view.center;
    }
    
    
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

-(void)present{

    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:self];
    
    if (_presentTransitioning || _dismissTransitioning) {
        navigationController.modalPresentationStyle = UIModalPresentationCustom;
        navigationController.transitioningDelegate = self;
    }else{
        navigationController.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        rootViewController.definesPresentationContext = YES;
    }
    [rootViewController presentViewController:navigationController animated:YES completion:nil];
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

-(void)dealloc{
    NSLog(@"%s",__func__);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
