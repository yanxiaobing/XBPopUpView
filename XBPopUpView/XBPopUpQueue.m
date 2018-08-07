//
//  XBPopUpQueue.m
//  XBPopUpViewDemo
//
//  Created by xbingo on 2018/8/6.
//  Copyright © 2018年 xbingo. All rights reserved.
//

#import "XBPopUpQueue.h"

@interface XBPopUpQueue()

@property (nonatomic ,strong) NSMutableArray *popUpQueue;

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

- (void)addView:(id<XBPopUpVCDelegate>)popUpView {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([weakSelf.popUpQueue containsObject:popUpView]) {
            return;
        }
        
        [weakSelf.popUpQueue addObject:popUpView];
        if (weakSelf.popUpQueue.count == 1) {
            if ([popUpView respondsToSelector:@selector(present)]) {
                [popUpView present];
            }
        } else {
            [weakSelf.popUpQueue sortUsingComparator:^NSComparisonResult(id<XBPopUpVCDelegate> view1, id<XBPopUpVCDelegate> view2) {
                if ([view1 priority] > [view2 priority]) {
                    return NSOrderedAscending;
                }
                if ([view1 priority] < [view2 priority]) {
                    return NSOrderedDescending;
                }
                return NSOrderedSame;
            }];
        }
    });
}

- (void)removeView:(id<XBPopUpVCDelegate>)popUpView {
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([weakSelf.popUpQueue containsObject:popUpView]) {
            [weakSelf.popUpQueue removeObject:popUpView];
            if (weakSelf.popUpQueue.count > 0) {
                id<XBPopUpVCDelegate> popUpView = weakSelf.popUpQueue.firstObject;
                if ([popUpView respondsToSelector:@selector(present)]) {
                    [popUpView present];
                }
            }
        }
    });
}

@end
