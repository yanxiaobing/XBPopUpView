//
//  XBTableViewHeaderFooterView.m
//  XBDevelopToolsDemo
//
//  Created by xbingo on 2019/10/17.
//  Copyright © 2019 xbingo. All rights reserved.
//

#import "XBTableViewHeaderFooterView.h"

@implementation XBTableViewHeaderFooterView

+ (NSString *)viewIdentifier{
    return NSStringFromClass([self class]);
}

+ (CGFloat)viewHeight:(id)data{
    return 0;
}

+ (instancetype)viewInTableView:(UITableView *)tableView
                 withIdentifier:(NSString *)identifier{
    return [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
}

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setUpSubviews];
    }
    return self;
}

-(void)setUpSubviews{}

-(void)updateView:(id)data{}

@end
