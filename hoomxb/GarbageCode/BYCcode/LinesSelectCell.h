//
//  LinesSelectCell.h
//  LRSChartView
//
//  Created by lihaiyang on 2018/5/25.
//  Copyright © 2018年 lreson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LinesSelectCell : UITableViewCell
@property(nonatomic ,assign)CGFloat width1;

@property(nonatomic ,assign)CGFloat width2;

-(void)showTitle:(NSString *)title andTitleColor:(UIColor *)titleColor andTitleFont:(UIFont *)titleFont andDescTile:(NSString *)descTitle andDescTileColor:(UIColor *)descTileColor andDescTitleFont:(UIFont *)DescTitleFont;

@end
