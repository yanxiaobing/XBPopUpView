//
//  ViewController.m
//  XBPopUpViewDemo
//
//  Created by xbingo on 2018/8/6.
//  Copyright © 2018年 xbingo. All rights reserved.
//

#import "ViewController.h"
#import "XBPopUpService.h"
#import "XBTestPopView.h"
#import "XBPopUpViewController.h"
#import "XBDefaultTransition.h"
#import "XBTestPopUpView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}
- (IBAction)defaultPresent:(UIButton *)sender {
    
    XBTestPopView *popView = [[XBTestPopView alloc] initWithSize:CGSizeMake(300, 400)];
//    popView.centerOffset = CGPointMake(50, 100);
//    [[XBPopUpService sharedService] showDefaultPresentPopUpView:popView priority:XBPopUpPriorityNormal emptyAreaEnabled:NO];
//    [[XBPopUpService sharedService] showCustomPopUpView:popView priority:XBPopUpPriorityNormal lowerPriorityHidden:YES fromType:XBPopUpFromRoot emptyAreaEnabled:NO presentTransitioning:nil dismissTransitioning:nil];
    [[XBPopUpService sharedService] showDefaultCustomPopUpView:popView priority:XBPopUpPriorityNormal lowerPriorityHidden:YES fromType:XBPopUpFromRoot emptyAreaEnabled:NO];
}
- (IBAction)defaultCustom:(UIButton *)sender {
    XBTestPopView *popView = [[XBTestPopView alloc] initWithSize:CGSizeMake(200, 300)];
    [[XBPopUpService sharedService] showDefaultCustomPopUpView:popView priority:XBPopUpPriorityNormal emptyAreaEnabled:NO ];
}
- (IBAction)emptyEnabled:(UIButton *)sender {
    XBTestPopView *popView = [[XBTestPopView alloc] initWithSize:CGSizeMake(100, 200)];
    [[XBPopUpService sharedService] showDefaultCustomPopUpView:popView priority:XBPopUpPriorityHigh emptyAreaEnabled:YES];
}
- (IBAction)custonView:(UIButton *)sender {
    
    XBTestPopUpView *popView = [[XBTestPopUpView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    popView.priority = XBPopUpPriorityVeryHigh;
    [[XBPopUpQueue sharedService] addView:popView];
    
}
- (IBAction)showByQueue:(UIButton *)sender {
    [self defaultPresent:nil];
    [self defaultCustom:nil];
    [self emptyEnabled:nil];
    [self custonView:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
