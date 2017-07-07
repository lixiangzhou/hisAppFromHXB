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
#import "HXBFin_LoanTruansfer_AddTrustworthinessView.h"//曾信
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
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    [self creatViews];
}

- (void) creatViews {
    self.topView = [[HXBFin_LoanTruansferDetail_TopView alloc]init];
    self.addTrustworthiness = [[HXBFin_LoanTruansfer_AddTrustworthinessView alloc]init];
    self.loanType_InterestLabel = [[HXBBaseView_MoreTopBottomView alloc]initWithFrame:CGRectZero andTopBottomViewNumber:2 andViewClass:[UILabel class] andViewHeight:30 andTopBottomSpace:10 andLeftRightLeftProportion:0.5];
    self.detailTableView = [[HXBFinDetail_TableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
}

@end
