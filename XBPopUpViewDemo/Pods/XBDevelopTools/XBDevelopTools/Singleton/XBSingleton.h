//
//  XBSingleton.h
//  XBDevelopToolsDemo
//
//  Created by xbingo on 2018/7/20.
//  Copyright © 2018年 xbingo. All rights reserved.
//

#ifndef XBSingleton_h
#define XBSingleton_h

#define XBSingletonH(methodName) + (instancetype)methodName;
// .m文件
#define XBSingletonM(methodName) \
static id _instance; \
\
+ (instancetype)allocWithZone:(struct _NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
\
+ (instancetype)methodName \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return _instance; \
}

#endif /* XBSingleton_h */

