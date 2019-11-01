//
//  XBPopUpQueue.m
//  XBPopUpViewDemo
//
//  Created by xbingo on 2018/8/6.
//  Copyright © 2018年 xbingo. All rights reserved.
//

#import "XBPopUpQueue.h"

@interface XBPopUpQueue()

@property (nonatomic ,strong) id<XBPopUpDelegate> currentPopUpView;

@end

@implementation XBPopUpQueue

+ (instancetype)sharedService{
    static XBPopUpQueue *popUpQueue = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        popUpQueue = [[XBPopUpQueue alloc] init];
    });
    return popUpQueue;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _popUpQueue = [NSMutableArray new];
    }
    return self;
}

- (void)addView:(id<XBPopUpDelegate>)popUpView {
    if ([self.popUpQueue containsObject:popUpView]) {
        return;
    }
    // 将弹窗添加到队列
    [self.popUpQueue addObject:popUpView];
    // 队列中只有一个弹窗
    if (self.popUpQueue.count == 1) {
        // 展示弹窗，如果lowerPriorityHidden == YES，则赋值给currentPopUpView
        [self showAndRecordPopUpViewIfNeed:popUpView];
    }
    // 队列中有多个弹窗
    else {
        // 根据优先级对弹窗进行排序
        [self sortPopUpQueue];
        // 队列中有多个弹窗表示目前肯定有弹窗展示着
        // 如果当前展示的弹窗支持临时隐藏，且当前弹窗非当前队列中第一个弹窗（优先级最高最先添加进来的）
        if (self.currentPopUpView.lowerPriorityHidden && self.currentPopUpView != self.popUpQueue.firstObject) {
            __weak typeof(self) weakSelf = self;
            if ([self.currentPopUpView respondsToSelector:@selector(temporarilyDismissAnimated:completion:)]) {
                [self.currentPopUpView temporarilyDismissAnimated:NO completion:^{
                    [weakSelf showAndRecordPopUpViewIfNeed:weakSelf.popUpQueue.firstObject];
                }];
            }
        }
    }
}

- (void)removeView:(id<XBPopUpDelegate>)popUpView {
        if ([self.popUpQueue containsObject:popUpView]) {
            [self.popUpQueue removeObject:popUpView];
            if (self.popUpQueue.count > 0) {
                id<XBPopUpDelegate> popUpView = self.popUpQueue.firstObject;
                if ([popUpView respondsToSelector:@selector(present)]) {
                    [popUpView present];
                }
            }else{
                self.currentPopUpView = nil;
            }
        }
}

-(void)showAndRecordPopUpViewIfNeed:(id<XBPopUpDelegate>)popUpView{
    
    if ([popUpView respondsToSelector:@selector(present)]) {
        [popUpView present];
        if (popUpView.lowerPriorityHidden) {
            self.currentPopUpView = popUpView;
        }
    }
}

-(void)sortPopUpQueue{
    [self.popUpQueue sortUsingComparator:^NSComparisonResult(id<XBPopUpDelegate> view1, id<XBPopUpDelegate> view2) {
        if (view1.priority > view2.priority) {
            return NSOrderedAscending;
        }
        if (view1.priority < view2.priority) {
            return NSOrderedDescending;
        }
        return NSOrderedSame;
    }];
}

@end
