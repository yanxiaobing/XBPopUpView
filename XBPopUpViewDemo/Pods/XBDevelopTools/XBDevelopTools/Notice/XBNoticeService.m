//
//  XBNoticeService.m
//  XBDevelopToolsDemo
//
//  Created by xbingo on 2019/10/16.
//  Copyright © 2019 xbingo. All rights reserved.
//

#import "XBNoticeService.h"

@interface XBNoticeService()

@property (nonatomic ,strong) NSMutableDictionary *blockMap;

@end

@implementation XBNoticeService

XBSingletonM(shared)

- (instancetype)init
{
    self = [super init];
    if (self) {
        _blockMap = [NSMutableDictionary new];
    }
    return self;
}

-(void)post:(nonnull NSString *)noticeName{
    [self post:noticeName object:nil userInfo:nil];
}

-(void)post:(nonnull NSString *)noticeName
     object:(nullable id)anObject{
    [self post:noticeName object:anObject userInfo:nil];
}

-(void)post:(nonnull NSString *)noticeName
     object:(nullable id)anObject
   userInfo:(nullable NSDictionary *)aUserInfo{
    [[NSNotificationCenter defaultCenter] postNotificationName:noticeName object:anObject userInfo:aUserInfo];
}

-(void)observer:(nonnull NSObject *)target
     noticeName:(nonnull NSString *)noticeName
          block:(nonnull XBNoticeBlock)block{
    
    NSMutableArray *blockList = [[NSMutableArray alloc]initWithArray:_blockMap[noticeName]];
    
    if (!blockList) {
        blockList = [NSMutableArray new];
    }
    
    __block BOOL exists = NO;
    
    [blockList enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj.allKeys containsObject:target.objectIdentifier]) {
            exists = YES;
            *stop = YES;
        }
    }];
    
    if (!exists) {
        [blockList addObject:@{target.objectIdentifier:block}];
    }
    
    [_blockMap setObject:blockList forKey:noticeName];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealWithNotice:) name:noticeName object:nil];
    
}

-(void)dealWithNotice:(NSNotification *)notification{
    
    NSArray *blockList = _blockMap[notification.name];
    
    [blockList enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        XBNoticeBlock block = obj.allValues.firstObject;
        if (block) {
            if ([NSThread isMainThread]) {
                block(notification.object,notification.userInfo);
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    block(notification.object,notification.userInfo);
                });
            }
        }
    }];
}

-(void)removeObserver:(nullable NSObject *)target{
    
    NSDictionary<NSString *,NSArray<NSDictionary<NSString *,id> *>*> *blockMap = [[NSDictionary alloc] initWithDictionary:_blockMap];;
    
    [blockMap enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, NSArray<NSDictionary<NSString *,id> *> * _Nonnull blockList, BOOL * _Nonnull stop) {
        
        [blockList enumerateObjectsUsingBlock:^(NSDictionary<NSString *,id> * _Nonnull blockDic, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([blockDic.allKeys.lastObject isEqualToString:target.objectIdentifier]) {
                NSMutableArray *temBlockList = self.blockMap[key];
                [temBlockList removeObjectAtIndex:idx];
                if (temBlockList.count > 0) {
                    self.blockMap[key] = temBlockList;
                }else{
                    [self.blockMap removeObjectForKey:key];
                    [[NSNotificationCenter defaultCenter] removeObserver:self name:key object:nil];
                }
            }
        }];
    }];
}

@end
