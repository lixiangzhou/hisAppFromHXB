//
//  HXBFin_creditorChange_TableViewCell.h
//  hoomxb
//
//  Created by 肖扬 on 2017/9/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBFin_creditorChange_TableViewCell : UITableViewCell

/** 是否隐藏横线 */
@property (nonatomic, assign)  BOOL isHeddenHine;

/** title数据源 */
@property (nonatomic, strong)  NSString *titleStr;
/** detail数据源 */
@property (nonatomic, strong)  NSString *detailStr;
/** 第一行是否置灰显示 */
@property (nonatomic, assign)  BOOL isDiscountRow;
/** 是否富文本展示 */
@property (nonatomic, assign) BOOL isAttributeShow;

@end
