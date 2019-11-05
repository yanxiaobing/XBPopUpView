//
//  XBBasePopViewController.m
//  XBPopUpViewDemo
//
//  Created by xbingo on 2019/11/1.
//  Copyright © 2019 xbingo. All rights reserved.
//

#import "XBBasePopViewController.h"
#import "XBBaseTransition.h"
#import "UIViewController+current.h"

@interface XBBasePopViewController ()


@end

@implementation XBBasePopViewController

@synthesize willHideBlock;
@synthesize didHidenBlock;

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _emptyAreaEnabled = YES;
        _lowerPriorityHidden = NO;
        _priority = XBPopUpPriorityNormal;
        _fromType = XBPopUpFromRoot;
        _presentTransitioning = [XBBaseTransition presentTransition];
        _dismissTransitioning = [XBBaseTransition dismissTransition];
        
        __weak typeof(self) weakSelf = self;
        willHideBlock = ^(XBPopUpViewHideType popUpViewHideType) {
            [weakSelf dismissViewControllerAnimated:YES completion:^{
                [weakSelf dismiss];
                if (weakSelf.didHidenBlock) {
                    weakSelf.didHidenBlock(popUpViewHideType);
                }
            }];
        };
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    
    _popUpContentView = [UIView new];
    [self.view addSubview:_popUpContentView];
}

-(void)showInPopUpQueue:(XBPopUpViewDidHidenBlock)didHidenBlock{
    self.didHidenBlock = didHidenBlock;
    [XBPopUpQueue.sharedService addView:self];
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
    if ([XBPopUpQueue.sharedService.popUpQueue containsObject:self]) {
       [[XBPopUpQueue sharedService] removeView:self];
    }
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
            if (weakSelf.willHideBlock) {
                weakSelf.willHideBlock(XBPopUpViewHideTypeClickEmptyArea);
            }
        }];
    }
}


-(void)dealloc{
#if DEBUG
    NSLog(@"%s",__func__);
#endif
}


@end
