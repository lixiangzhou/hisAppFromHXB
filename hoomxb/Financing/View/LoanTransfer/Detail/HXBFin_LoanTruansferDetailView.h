//
//  HXFin_LoanTruansferDetailView.h
//  hoomxb
//
//  Created by HXB on 2017/7/7.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class
HXBFin_LoanTruansferDetailViewManger,
HXBFin_LoanTruansfer_AddTrustworthinessView,
HXBFin_LoanTruansferDetail_TopViewManager,
HXBFinDetail_TableViewCellModel;

@interface HXBFin_LoanTruansferDetailView : UIView
/**
 点击事件
 */
- (void)clickAddButtonBlock:(void(^)(UIButton *button))clickAddButtonBlock;

@property (nonatomic,strong) HXBFin_LoanTruansferDetailViewManger *manager;

- (void)setUPValueWithManager: (HXBFin_LoanTruansferDetailViewManger *(^)(HXBFin_LoanTruansferDetailViewManger *manager))loanTruansferDetailViewManagerBlock;
@end


@interface HXBFin_LoanTruansferDetailViewManger : NSObject
/**
 顶部的品字形
 */
@property (nonatomic,strong) HXBFin_LoanTruansferDetail_TopViewManager      *topViewManager;
/**
 曾信
 */
@property (nonatomic,strong) HXBFin_LoanTruansfer_AddTrustworthinessView    *addTrustworthinessManager;
/**
 还款方式
 提前还款费率
 */
@property (nonatomic,strong) HXBBaseView_MoreTopBottomViewManager           *loanType_InterestLabelManager;
/**
 图片- 文字- 图片 的tableView
 */
@property (nonatomic,strong) NSArray <HXBFinDetail_TableViewCellModel *>    *detailTableViewArray;
/**
 * 预期收益不代表实际收益，投资需谨慎
 */
@property (nonatomic,copy) NSString *promptLabelStr;
/**
 加入按钮
 */
@property (nonatomic,copy) NSString *addButtonStr;

@end
