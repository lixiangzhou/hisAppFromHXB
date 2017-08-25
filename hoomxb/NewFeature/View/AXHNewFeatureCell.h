//
//  AXHNewFeatureCell.h
//  爱心汇
//
//  Created by kys-4 on 15/12/3.
//  Copyright © 2015年 kys-4. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AXHNewFeatureCell : UICollectionViewCell

@property (nonatomic, strong) UIImage *image;

// 判断是否是最后一页
- (void)setIndexPath:(int)indexPath count:(int)count;

@end
