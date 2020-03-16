//
//  XBPopUpQueue.m
//  XBPopUpViewDemo
//
//  Created by xbingo on 2018/8/6.
//  Copyright © 2018年 xbingo. All rights reserved.
//

#import "XBPopUpQueue.h"
#import "UIViewController+XBPopUp.h"

#define xb_no_depend_id @"xb_no_depend_id"

@interface XBPopUpQueue()

@property (nonatomic ,strong) NSMutableDictionary<NSString* ,id<XBPopUpDelegate>> *currentPopUpMap;

@property (nonatomic ,strong) NSMutableDictionary<NSString *,NSMutableArray<id<XBPopUpDelegate>> *> *popUpMap;

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
        _popUpMap = [NSMutableDictionary new];
        _currentPopUpMap = [NSMutableDictionary new];
    }
    return self;
}

- (void)addView:(id<XBPopUpDelegate>)popUpView {
    NSString *dependId = nil;
    if ([popUpView respondsToSelector:@selector(dependVCId)]) {
        dependId = popUpView.dependVCId;
    }
    if (!dependId) {
        dependId = xb_no_depend_id;
    }
    
    NSMutableArray *popList = [[NSMutableArray alloc] initWithArray:_popUpMap[dependId]];
    
    if (![popList containsObject:popUpView]) {
        
        [popList addObject:popUpView];
        
        _popUpMap[dependId] = popList;
        
        if (popList.count == 1) {
            
            [self showAndRecordPopUpViewIfNeed:popUpView];
            
        }else{
            // 优先级排序
            [self sortPopUpQueue:popList];
            
            if (self.currentPopUpMap[dependId].lowerPriorityHidden && self.currentPopUpMap[dependId] != popList.firstObject) {
                __weak typeof(self) weakSelf = self;
                if ([self.currentPopUpMap[dependId] respondsToSelector:@selector(temporarilyDismissAnimated:completion:)]) {
                    [self.currentPopUpMap[dependId] temporarilyDismissAnimated:YES completion:^{
                        
                        [self.currentPopUpMap removeObjectForKey:dependId];
                        
                        [weakSelf showAndRecordPopUpViewIfNeed:popList.firstObject];
                    }];
                }
            }
        }
    }
}

- (void)removeView:(id<XBPopUpDelegate>)popUpView {
    
    if (!popUpView) {
        return;
    }
    
    NSString *dependId = nil;
    if ([popUpView respondsToSelector:@selector(dependVCId)]) {
        dependId = popUpView.dependVCId;
    }
    if (!dependId) {
        dependId = xb_no_depend_id;
    }
    
    NSMutableArray *popList = [[NSMutableArray alloc] initWithArray:_popUpMap[dependId]];
    
    if ([popList containsObject:popUpView]) {
        
        [popList removeObject:popUpView];
        
        if (popList.count == 0) {
            
            [_popUpMap removeObjectForKey:dependId];
            [_currentPopUpMap removeObjectForKey:dependId];
            
        }else{
            
            _popUpMap[dependId] = popList;
            
            id<XBPopUpDelegate> popUpView = popList.firstObject;
            
            if ([popUpView respondsToSelector:@selector(present)]) {
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self showAndRecordPopUpViewIfNeed:popUpView];
                });
                
            }
        }
    }
}

-(void)showAndRecordPopUpViewIfNeed:(id<XBPopUpDelegate>)popUpView{
    
    if (!popUpView) {
        return;
    }
    
    NSString *dependId = nil;
    if ([popUpView respondsToSelector:@selector(dependVCId)]) {
        dependId = popUpView.dependVCId;
    }
    if (!dependId) {
        dependId = xb_no_depend_id;
    }
    
    BOOL shouldShow = NO;
    if ([dependId isEqualToString:xb_no_depend_id]) {
        shouldShow = self.currentPopUpMap[dependId] != popUpView && popUpView == self.popUpMap[dependId].firstObject;
    }else{
        BOOL matchDependId = [dependId isEqualToString:[UIViewController xb_currentViewController].xb_dependId];
        BOOL notSamePopUp = self.currentPopUpMap[dependId] != popUpView;
        
        BOOL isFirstPopUp = popUpView == self.popUpMap[dependId].firstObject;
        
        shouldShow = matchDependId && notSamePopUp && isFirstPopUp;
    }
    
    if (shouldShow) {
        if ([popUpView respondsToSelector:@selector(present)]) {
            self.currentPopUpMap[dependId] = popUpView;
            [popUpView present];
        }
    }
}

-(void)showWithDependId:(NSString *)dependId{
    
    if (!dependId) {
        return;
    }
    
    if (![_popUpMap.allKeys containsObject:dependId]) {
        [self showAndRecordPopUpViewIfNeed:_popUpMap[xb_no_depend_id].firstObject];
    }else{
        [self showAndRecordPopUpViewIfNeed:_popUpMap[dependId].firstObject];
    }
}

-(void)sortPopUpQueue:(NSMutableArray *)popList{
    [popList sortUsingComparator:^NSComparisonResult(id<XBPopUpDelegate> view1, id<XBPopUpDelegate> view2) {
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
