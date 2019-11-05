//
//  XBPath.m
//  XBDevelopToolsDemo
//
//  Created by xbingo on 2018/7/20.
//  Copyright © 2018年 xbingo. All rights reserved.
//

#import "XBPath.h"

@implementation XBPath

+ (NSString *)documentPath {
    static NSString *documentPath;
    if (!documentPath) {
        documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    }
    return documentPath;
}

+ (NSString *)libraryPath{
    static NSString *libraryPath;
    if (!libraryPath) {
        libraryPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject;
    }
    return libraryPath;
}

+ (NSString *)libraryCachesPath{
    static NSString *libraryCachesPath;
    if (!libraryCachesPath) {
        libraryCachesPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    }
    return libraryCachesPath;
}

+ (NSString *)tempPath {
    return NSTemporaryDirectory();
}
@end
