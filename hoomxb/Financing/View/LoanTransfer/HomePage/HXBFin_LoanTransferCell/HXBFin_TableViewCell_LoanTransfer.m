//
//  HXBFin_TableViewCell_LoanTransfer.m
//  hoomxb
//
//  Created by HXB on 2017/7/1.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_TableViewCell_LoanTransfer.h"
#import "HXBFinHomePageViewModel_LoanTruansferViewModel.h"
@interface HXBFin_TableViewCell_LoanTransfer ()
/**
 年利率的View
 */
@property (nonatomic,strong) HXBBaseView_TwoLable_View *interestView;
/**
 剩余期限
 */
@property (nonatomic,strong) HXBBaseView_TwoLable_View *remainMonthsView;
/**
 待转金额
 */
@property (nonatomic,strong) HXBBaseView_TwoLable_View *amountTransferView;
/**
 消费借款
 */
@property (nonatomic,strong) UILabel *loanLable;
/**
 消费借款icon
 */
@property (nonatomic,strong) UIImageView *loanImageView;

@property (nonatomic,strong) HXBFinHomePageViewModel_LoanTruansferViewModel *manager;

@property (nonatomic,copy) void (^clickCellBlock)(NSIndexPath *index, id model);
@end
@implementation HXBFin_TableViewCell_LoanTransfer

- (void)clickCellWithBlock:(void (^)(id, NSIndexPath *))clickCellBlock {
    self.clickCellBlock = clickCellBlock;
}
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setUP];
    }
    return self;
}

- (void) setUP {
    [self creatViews];
    [self setUPFrames];
  }

- (void)creatViews {
    _interestView       = [[HXBBaseView_TwoLable_View alloc] initWithFrame:CGRectZero];
    _remainMonthsView   = [[HXBBaseView_TwoLable_View alloc] initWithFrame:CGRectZero];
    _amountTransferView = [[HXBBaseView_TwoLable_View alloc] initWithFrame:CGRectZero];
    _loanLable = [[UILabel alloc]init];
    _loanImageView = [[UIImageView alloc]init];
}

- (void)setUPFrames {
    NSArray <UIView *>*array = @[ _interestView,
                        _remainMonthsView,
                        _amountTransferView];
  
    [array enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.contentView addSubview:obj];
    }];
    [self.contentView addSubview: self.loanImageView];
    [self.contentView addSubview: self.loanLable];
    [self.loanLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.contentView).offset(kScrAdaptationH(10));
        make.height.equalTo(@(kScrAdaptationH(20)));
    }];
    [self.loanLable sizeToFit];
    [self.loanImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.loanLable);
        make.left.equalTo(self.loanLable.mas_right);
        make.width.equalTo(self.loanLable.mas_height);
    }];
    [self.interestView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.loanLable.mas_bottom);
        make.bottom.left.equalTo(self.contentView);
        make.width.equalTo(self.contentView.mas_width).multipliedBy(1/3.0);
    }];
    [self.remainMonthsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.interestView.mas_right);
        make.top.bottom.equalTo(self.interestView);
        make.width.equalTo(self.interestView);
    }];
    [self.amountTransferView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.remainMonthsView.mas_right);
        make.top.bottom.equalTo(self.remainMonthsView);
        make.width.equalTo(self.remainMonthsView);
    }];
//    
//    [array mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:0 leadSpacing:0 tailSpacing:0];
//    [array mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.contentView);
//        make.bottom.equalTo(self.contentView);
//    }];
}

- (void) setLoanTruansferViewModel:(HXBFinHomePageViewModel_LoanTruansferViewModel *)LoanTruansferViewModel {
    _LoanTruansferViewModel = LoanTruansferViewModel;
    [self.interestView setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
//        viewModelVM.leftLabelStr = LoanTruansferViewModel.interest;
        viewModelVM.rightLabelStr = @"年利率";
        viewModelVM.leftLabelAlignment = NSTextAlignmentCenter;
        viewModelVM.rightLabelAlignment = NSTextAlignmentCenter;
        return viewModelVM;
    }];
    [self.remainMonthsView setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
        viewModelVM.leftLabelStr = LoanTruansferViewModel.leftMonths;
        viewModelVM.rightLabelStr = @"剩余期限";
        viewModelVM.leftLabelAlignment = NSTextAlignmentCenter;
        viewModelVM.rightLabelAlignment = NSTextAlignmentCenter;
        return viewModelVM;
    }];
    [self.amountTransferView setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
        viewModelVM.leftLabelStr = LoanTruansferViewModel.leftTransAmount;
        viewModelVM.rightLabelStr = @"待转让金额(元)";
        viewModelVM.leftLabelAlignment = NSTextAlignmentCenter;
        viewModelVM.rightLabelAlignment = NSTextAlignmentCenter;
        return viewModelVM;
    }];
    self.loanLable.text = @"000000000";
    self.loanImageView.image = [UIImage imageNamed:@"1"];
    self.interestView.leftLabel.attributedText = LoanTruansferViewModel.interest;
}
@end
