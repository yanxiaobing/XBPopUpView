//
//  ViewController.m
//  XBPopUpViewDemo
//
//  Created by xbingo on 2018/8/6.
//  Copyright © 2018年 xbingo. All rights reserved.
//

#import "ViewController.h"
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
    [XBPopUpViewController showDefaultPresentPopUpView:popView emptyAreaEnabled:NO priority:XBPopUpPriorityNormal];
}
- (IBAction)defaultCustom:(UIButton *)sender {
    XBTestPopView *popView = [[XBTestPopView alloc] initWithSize:CGSizeMake(200, 300)];
    [XBPopUpViewController showDefaultCustomPopUpView:popView emptyAreaEnabled:NO priority:XBPopUpPriorityNormal];
}
- (IBAction)emptyEnabled:(UIButton *)sender {
    XBTestPopView *popView = [[XBTestPopView alloc] initWithSize:CGSizeMake(100, 200)];
    [XBPopUpViewController showDefaultCustomPopUpView:popView emptyAreaEnabled:YES priority:XBPopUpPriorityHigh];
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
