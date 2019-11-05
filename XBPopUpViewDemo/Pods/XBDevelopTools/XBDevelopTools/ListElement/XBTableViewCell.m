//
//  XBTableViewCell.m
//  XBDevelopToolsDemo
//
//  Created by xbingo on 2019/10/17.
//  Copyright © 2019 xbingo. All rights reserved.
//

#import "XBTableViewCell.h"

@implementation XBTableViewCell

+(NSString *)reuseIdentifier{
    return NSStringFromClass([self class]);
}

+(CGFloat)cellHeight:(id)data{
    return 0.0;
}

+(instancetype)cellInTableView:(UITableView *)tableView forIndexPath:(NSIndexPath *)indexPath{
    return [tableView dequeueReusableCellWithIdentifier:[self reuseIdentifier] forIndexPath:indexPath];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpSubviews];
    }
    return self;
}

-(void)setUpSubviews{
    
}

-(void)updateWithData:(id)data{
    
}

@end
