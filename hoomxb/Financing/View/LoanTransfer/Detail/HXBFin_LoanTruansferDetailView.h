//
//  HXFin_LoanTruansferDetailView.h
//  hoomxb
//
//  Created by HXB on 2017/7/7.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXBFin_LoanTruansferDetail_TopView.h"
#import "HXBFin_LoanTruansfer_AddTrustworthinessView.h"
@class
HXBFin_LoanTruansferDetailViewManger,
HXBFinDetail_TableViewCellModel;

@interface HXBFin_LoanTruansferDetailView : UIView
/**
 点击事件
 */
- (void)clickAddButtonBlock:(void(^)(UIButton *button))clickAddButtonBlock;

@property (nonatomic,strong) HXBFin_LoanTruansferDetailViewManger *manager;

- (void)setUPValueWithManager: (HXBFin_LoanTruansferDetailViewManger *(^)(HXBFin_LoanTruansferDetailViewManger *manager))loanTruansferDetailViewManagerBlock;

///底部的tableView的模型数组
@property (nonatomic,strong) NSArray <HXBFinDetail_TableViewCellModel *>* modelArray;

///点击了 详情页底部的tableView的cell
- (void)clickBottomTableViewCellBloakFunc: (void(^)(NSIndexPath *index, HXBFinDetail_TableViewCellModel *model))clickBottomTabelViewCellBlock;

/// 点击了立即加入的button
- (void) clickAddButtonFunc: (void(^)())clickAddButtonBlock;
///点击了增信
- (void)clickAddTrustWithBlock:(void(^)())clickAddTrustBlock;
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
///addbutton可否被点击
@property (nonatomic,assign) BOOL isAddButtonClick;
/// 加入按钮的颜色
@property (nonatomic,strong) UIColor *addButtonBackgroundColor;
///加入按钮的字体颜色
@property (nonatomic,strong) UIColor *addButtonTitleColor;
///addbutton 边缘的颜色
@property (nonatomic,strong) UIColor *addButtonBorderColor;
@end
