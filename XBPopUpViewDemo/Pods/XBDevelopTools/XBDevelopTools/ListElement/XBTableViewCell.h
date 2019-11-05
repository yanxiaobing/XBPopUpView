//
//  XBTableViewCell.h
//  XBDevelopToolsDemo
//
//  Created by xbingo on 2019/10/17.
//  Copyright © 2019 xbingo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XBTableViewCell : UITableViewCell

/**
 重用标识符
 
 @return 重用标识符
 */
+(NSString *)reuseIdentifier;

/**
 CellHeight
 
 @param data 根据相关数据计算CellHeight
 @return CellHeight
 */
+(CGFloat)cellHeight:(id)data;


/**
 生成可重用的Cell
 
 @param tableView cell 父容器
 @param indexPath cell位置
 @return Cell
 */
+ (instancetype)cellInTableView:(UITableView *)tableView
                        forIndexPath:(NSIndexPath *)indexPath;


/**
 设置子视图
 */
-(void)setUpSubviews;

/**
 更新cell展示数据
 
 @param data cell内容数据
 */
- (void)updateWithData:(id)data;

@end

NS_ASSUME_NONNULL_END
