//
//  XBNoticeService.h
//  XBDevelopToolsDemo
//
//  Created by xbingo on 2019/10/16.
//  Copyright © 2019 xbingo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+Property.h"
#import "XBSingleton.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^XBNoticeBlock)(id _Nullable object , NSDictionary *_Nullable userInfo);

@interface XBNoticeService : NSObject

XBSingletonH(shared)

-(void)post:(nonnull NSString *)noticeName;

-(void)post:(nonnull NSString *)noticeName
     object:(nullable id)anObject;
/**
 发送通知

 @param noticeName 通知名
 @param anObject anObject
 @param aUserInfo aUserInfo
 */
-(void)post:(nonnull NSString *)noticeName
     object:(nullable id)anObject
   userInfo:(nullable NSDictionary *)aUserInfo;


/**
 注册通知

 @param target 实例
 @param noticeName 通知名
 @param block 回调
 */
-(void)observer:(nonnull NSObject *)target
         noticeName:(nonnull NSString *)noticeName
          block:(nonnull XBNoticeBlock)block;


/**
 移除通知

 @param target 实例标识
 */
-(void)removeObserver:(nullable NSObject *)target;

@end

NS_ASSUME_NONNULL_END
