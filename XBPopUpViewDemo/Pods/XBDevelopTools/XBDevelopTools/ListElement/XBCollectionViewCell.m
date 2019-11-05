//
//  XBCollectionViewCell.m
//  XBDevelopToolsDemo
//
//  Created by xbingo on 2019/10/17.
//  Copyright © 2019 xbingo. All rights reserved.
//

#import "XBCollectionViewCell.h"

@implementation XBCollectionViewCell

+(NSString *)reuseIdentifier{
    return NSStringFromClass([self class]);
}

+(CGSize)cellSize:(id)data collectionView:(UICollectionView *)collectionView{
    return CGSizeZero;
}

+ (instancetype)cellInCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath{
    return [collectionView dequeueReusableCellWithReuseIdentifier:[self reuseIdentifier] forIndexPath:indexPath];
}

-(void)updateWithData:(id)data{}

@end
