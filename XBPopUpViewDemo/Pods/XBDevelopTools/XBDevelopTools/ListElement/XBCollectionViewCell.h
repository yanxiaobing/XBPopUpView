//
//  XBCollectionViewCell.h
//  XBDevelopToolsDemo
//
//  Created by xbingo on 2019/10/17.
//  Copyright © 2019 xbingo. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XBCollectionViewCell : UICollectionViewCell

/**
 重用标识符
 
 @return 重用标识符
 */
+(NSString *)reuseIdentifier;

/**
 CellSize
 
 @param data 根据相关数据计算CellSize
 @return CellSize
 */
+(CGSize)cellSize:(_Nullable id)data collectionView:(UICollectionView *)collectionView;


/**
 生成可重用的Cell
 
 @param collectionView cell 父容器
 @param indexPath cell位置
 @return Cell
 */
+ (instancetype)cellInCollectionView:(UICollectionView *)collectionView
                        forIndexPath:(NSIndexPath *)indexPath;


/**
 更新cell展示数据
 
 @param data cell内容数据
 */
- (void)updateWithData:(id)data;

@end

NS_ASSUME_NONNULL_END
