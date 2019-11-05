//
//  XBTableViewHeaderFooterView.h
//  XBDevelopToolsDemo
//
//  Created by xbingo on 2019/10/17.
//  Copyright © 2019 xbingo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XBTableViewHeaderFooterView : UITableViewHeaderFooterView

+ (NSString *)viewIdentifier;

+ (CGFloat)viewHeight:(id)data;

+ (instancetype)viewInTableView:(UITableView *)tableView
                 withIdentifier:(NSString *)identifier;

-(void)setUpSubviews;
-(void)updateView:(id)data;

@end

NS_ASSUME_NONNULL_END
