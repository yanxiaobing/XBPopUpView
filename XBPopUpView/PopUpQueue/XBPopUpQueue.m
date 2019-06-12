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
        [self.popUpQueue addObject:popUpView];
        if (self.popUpQueue.count == 1) {
            [self showAndRecordPopUpViewIfNeed:popUpView];
        } else {
            
            [self sortPopUpQueue];
            
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

@end
