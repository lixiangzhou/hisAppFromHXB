//
//  HXBBaseViewCell_MYListCellTableViewCell.h
//  hoomxb
//
//  Created by HXB on 2017/8/7.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBBaseViewCell_MYListCellTableViewCellManager;
@interface HXBBaseViewCell_MYListCellTableViewCell : UITableViewCell

///设置值
- (void) setUPValueWithListCellManager:(HXBBaseViewCell_MYListCellTableViewCellManager *(^)(HXBBaseViewCell_MYListCellTableViewCellManager *manager))managerBlock;
@end


@interface HXBBaseViewCell_MYListCellTableViewCellManager : NSObject

///title 有可能有图片
///title 的图片 不设置说明没有图片
@property (nonatomic,copy) NSString *title_ImageName;
///title 的左边的文字
@property (nonatomic,copy) NSString *title_LeftLabelStr;
///title 右边的文字 （弧形）
@property (nonatomic,copy) NSString *title_RightLabelStr;
///最后一个的罗便的按钮
@property (nonatomic,copy) NSString *wenHaoImageName;

@property (nonatomic,strong) HXBBaseView_MoreTopBottomViewManager *bottomViewManager;
/// ---------------- loan ----------------------
/** - 收益中 -
 投资金额(元)
 待收收益(元)
 下一还款日
 */

/** - 投标中 -
 投资金额(元)
 投资进度
 平均历史年化收益
 */

/** - 转让中 -
 加入金额(元)
 已获收益(元)
 平均历史年化收益
 */


/// ----------------- plan ---------------------
/** - 持有中 -
 加入金额(元)
 已获收益(元)
 平均历史年化收益
 */


/** - 退出中 -
 加入金额(元)
 已获收益(元)
 待转出金额(元) (元后面有？号图片)
 */

/**  - 已退出 -
 加入金额(元)
 已获收益(元)
 平均历史年化收益
 */


@end
