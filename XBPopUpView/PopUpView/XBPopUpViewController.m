//
//  XBPopUpViewController.m
//  XBPopUpViewDemo
//
//  Created by xbingo on 2018/8/6.
//  Copyright © 2018年 xbingo. All rights reserved.
//

#import "XBPopUpViewController.h"
#import "UIViewController+XBCurrent.h"

@interface XBPopUpViewController ()

/**
 是否激活点击空白区域隐藏
 */
@property (nonatomic, assign) BOOL emptyAreaEnabled;

/**
 自定义出场动画
 */
@property (nonatomic ,strong) id<UIViewControllerAnimatedTransitioning> presentTransitioning;

/**
 自定义退场动画
 */
@property (nonatomic ,strong) id<UIViewControllerAnimatedTransitioning> dismissTransitioning;

@end

@implementation XBPopUpViewController

@synthesize priority = _priority;
@synthesize popUpView = _popUpView;
@synthesize lowerPriorityHidden = _lowerPriorityHidden;
@synthesize fromType = _fromType;

-(instancetype)initWithPopUpView:(UIView<XBPopUpViewDelegate> *)popUpView
                emptyAreaEnabled:(BOOL)emptyAreaEnabled
                        priority:(XBPopUpPriority)priority
             lowerPriorityHidden:(BOOL)lowerPriorityHidden
                        fromType:(XBPopUpFromType)fromType
            presentTransitioning:(id<UIViewControllerAnimatedTransitioning>)presentTransitioning
            dismissTransitioning:(id<UIViewControllerAnimatedTransitioning>)dismissTransitioning{
    self = [super init];
    if (self) {
        _fromType = fromType;
        _priority = priority;
        _lowerPriorityHidden = lowerPriorityHidden;
        _popUpView = popUpView;
        _emptyAreaEnabled = emptyAreaEnabled;
        _presentTransitioning = presentTransitioning;
        _dismissTransitioning = dismissTransitioning;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    
    if ([self respondsToSelector:@selector(fromType)]) {
        if (_fromType == XBPopUpFromCurrentVC) {
            rootViewController = [UIViewController xb_currentViewController];
        }
    }
    
    UINavigationController *navigationController = [[UINavigationController alloc]initWithRootViewController:self];
    [navigationController setNavigationBarHidden:YES];
    
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

-(void)temporarilyDismissAnimated:(BOOL)animated completion:(void (^)(void))completion{
    [self dismissViewControllerAnimated:animated completion:^{
        if (completion) {
            completion();
        }
    }];
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
#if DEBUG
    NSLog(@"%s",__func__);
#endif
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
