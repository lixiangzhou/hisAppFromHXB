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
@property (nonatomic,strong) HXBFin_LoanTruansfer_AddTrustworthinessView *addTrustworthiness;
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
/**
 加入按钮
 */
@property (nonatomic,strong) UIButton *addButton;
/**
 点击事件
 */
@property (nonatomic,copy) void (^clickAddButtonBlock)(UIButton *button);
@end

@implementation HXBFin_LoanTruansferDetailView
- (void)clickAddButtonBlock:(void (^)(UIButton *))clickAddButtonBlock {
    self.clickAddButtonBlock = clickAddButtonBlock;
}
- (void)setUPValueWithManager:(HXBFin_LoanTruansferDetailViewManger *(^)(HXBFin_LoanTruansferDetailViewManger *))loanTruansferDetailViewManagerBlock {
    self.manager = loanTruansferDetailViewManagerBlock(_manager);
}
- (void)setManager:(HXBFin_LoanTruansferDetailViewManger *)manager {
    _manager = manager;
    kWeakSelf
    [self.topView setUPValueWithManager:^HXBFin_LoanTruansferDetail_TopViewManager *(HXBFin_LoanTruansferDetail_TopViewManager *manager) {
        return weakSelf.manager.topViewManager;
    }];
//    self.addTrustworthiness
    [self.loanType_InterestLabel setUPViewManagerWithBlock:^HXBBaseView_MoreTopBottomViewManager *(HXBBaseView_MoreTopBottomViewManager *viewManager) {
        return weakSelf.manager.loanType_InterestLabelManager;
    }];
    self.detailTableView.tableViewCellModelArray = self.manager.detailTableViewArray;
    self.promptLabel.text = self.manager.promptLabelStr;
    [self.addButton setTitle:self.manager.addButtonStr forState:UIControlStateNormal];
    [self.addButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
}
///点击了债转的加入按钮
- (void)clickButton:(UIButton *)button {
    if (self.clickAddButtonBlock) {
        self.clickAddButtonBlock(button);
    }
    NSLog(@"点击了债转的加入按钮");
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _manager = [[HXBFin_LoanTruansferDetailViewManger alloc]init];
        [self setup];
        self.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
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
    self.promptLabel = [[UILabel alloc]init];
    self.addButton = [[UIButton alloc]init];
    
    [self addSubview:self.topView];
    [self addSubview:self.addTrustworthiness];
    [self addSubview:self.loanType_InterestLabel];
    [self addSubview:self.detailTableView];
    [self addSubview:self.promptLabel];
    [self addSubview:self.addButton];
}
- (void)setUPFrame {
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@(kScrAdaptationH(0)));
        make.height.equalTo(@(kScrAdaptationH(150)));
    }];
    [self.addTrustworthiness mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).offset(kScrAdaptationH(8));
        make.left.right.equalTo(self.topView);
        make.height.equalTo(@(kScrAdaptationH(50)));
    }];
    [self.detailTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addTrustworthiness.mas_bottom).offset(kScrAdaptationH(8));
        make.left.right.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH(80)));
    }];
    [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailTableView.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH(30)));
    }];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.promptLabel.mas_bottom).offset(kScrAdaptationH(30));
        make.centerX.equalTo(self);
        make.bottom.equalTo(self).offset(kScrAdaptationH(20));
        make.width.equalTo(@(kScrAdaptationW(50)));
    }];
}
@end
@implementation HXBFin_LoanTruansferDetailViewManger
@end
