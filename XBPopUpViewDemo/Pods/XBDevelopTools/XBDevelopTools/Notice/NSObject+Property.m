//
//  NSObject+Property.m
//  XBDevelopToolsDemo
//
//  Created by xbingo on 2019/10/16.
//  Copyright © 2019 xbingo. All rights reserved.
//

#import "NSObject+Property.h"
#import <objc/runtime.h>

@implementation NSObject (Property)

-(void)setObjectIdentifier:(NSString *)objectIdentifier{
    objc_setAssociatedObject(self, @selector(objectIdentifier), objectIdentifier, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSString *)objectIdentifier{
    NSString *identifier = objc_getAssociatedObject(self, @selector(objectIdentifier));
    if (!identifier) {
        NSString *udid = [[NSUUID UUID].UUIDString stringByReplacingOccurrencesOfString:@"-" withString:@""];
        NSString *time = [NSObject.noticeDateFormatter stringFromDate:[NSDate date]];
        identifier = [NSString stringWithFormat:@"%@%@", udid, time];
        [self setObjectIdentifier:identifier];
    }
    return identifier;
}

+(NSDateFormatter *)noticeDateFormatter{
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [NSDateFormatter new];
        dateFormatter.dateFormat = @"yyyyMMddHHmmssSSS";
    });
    return dateFormatter;
}

@end
