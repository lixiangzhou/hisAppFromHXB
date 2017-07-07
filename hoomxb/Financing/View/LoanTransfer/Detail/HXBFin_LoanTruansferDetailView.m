//
//  HXFin_LoanTruansferDetailView.m
//  hoomxb
//
//  Created by HXB on 2017/7/7.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_LoanTruansferDetailView.h"
#import "HXBFinDetail_TableView.h"
#import "HXBFin_LoanTruansferDetail_TopView.h"
@interface HXBFin_LoanTruansferDetailView()
/**
 顶部的品字形
 */
@property (nonatomic,strong) HXBFin_LoanTruansferDetail_TopView *topView;
/**
 曾信
 */
@property (nonatomic,strong) UIView *addTrustworthiness;
/**
 还款方式
 提前还款费率
 */
@property (nonatomic,strong) HXBBaseView_MoreTopBottomView *loanType_InterestLabel;
/**
 图片- 文字- 图片 的tableView
 */
@property (nonatomic,strong) HXBFinDetail_TableView *detailTableView;
/**
 * 预期收益不代表实际收益，投资需谨慎
 */
@property (nonatomic,strong) UILabel *promptLabel;
@end

@implementation HXBFin_LoanTruansferDetailView
@end
