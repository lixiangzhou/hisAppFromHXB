//
//  HXBFin_TableViewCell_LoanTransfer.m
//  hoomxb
//
//  Created by HXB on 2017/7/1.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_TableViewCell_LoanTransfer.h"
#import "SVGKImage.h"
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
@property (nonatomic,strong) UILabel *amountTransferLabel;
/**
 消费借款
 */
@property (nonatomic,strong) UILabel *loanLable;
/**
 消费借款icon
 */
@property (nonatomic,strong) UIImageView *loanImageView;
/**
转让状态的button
*/
@property (nonatomic,strong) UIButton *stutasButton;
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
    _interestView       = [[HXBBaseView_TwoLable_View alloc] initWithFrame:CGRectZero andSpacing:kScrAdaptationH(10)];
    _remainMonthsView   = [[HXBBaseView_TwoLable_View alloc] initWithFrame:CGRectZero andSpacing:kScrAdaptationH(10)];
    _amountTransferLabel = [[UILabel alloc] init];
    _stutasButton = [[UIButton  alloc]init];
    _stutasButton.layer.cornerRadius = kScrAdaptationW(2.5);
    _stutasButton.layer.masksToBounds = true;
    _stutasButton.backgroundColor = HXBC_Red_Light;
    _stutasButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
    
    _loanLable = [[UILabel alloc]init];
    _loanImageView = [[UIImageView alloc]init];
}

- (void)setUPFrames {
    NSArray <UIView *>*array = @[
                                 _interestView,
                                 _remainMonthsView,
                                 _amountTransferLabel,
                                 _loanImageView,
                                 _loanLable,
                                 _stutasButton
                                  ];
  
    [array enumerateObjectsUsingBlock:^(UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self.contentView addSubview:obj];
    }];
    
    [self.loanImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(kScrAdaptationH(18));
        make.left.equalTo(self.contentView).offset(kScrAdaptationW(15));
        make.width.equalTo(@(kScrAdaptationW(15)));
        make.height.equalTo(@(kScrAdaptationH(15)));
    }];
    
    
    [self.loanLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.loanImageView);
        make.left.equalTo(self.loanImageView.mas_right).offset(kScrAdaptationW(7));
    }];
    [self.loanLable sizeToFit];
    self.loanLable.font = kHXBFont_PINGFANGSC_REGULAR(12);
    self.loanLable.textColor = kHXBColor_Grey_Font0_2;
    
    [self.amountTransferLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(@(kScrAdaptationW(-15)));
        make.top.bottom.equalTo(self.loanLable);
    }];
    self.amountTransferLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
    self.amountTransferLabel.textColor = kHXBColor_Font0_6;
    self.amountTransferLabel.textAlignment = NSTextAlignmentRight;
    
    [self.interestView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_centerY).offset(kScrAdaptationH(-12));
        make.left.equalTo(self.contentView).offset(kScrAdaptationW(15));
        make.width.equalTo(self.contentView.mas_width).multipliedBy(1/3.0).offset(kScrAdaptationW(10));
        make.height.equalTo(@(kScrAdaptationH(47)));
    }];
    
    [self.remainMonthsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.bottom.equalTo(self.interestView);
    }];
    
    
    [self.stutasButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(kScrAdaptationW(-15));
        make.centerY.equalTo(self.contentView);
        make.height.equalTo(@(kScrAdaptationH(30)));
        make.width.equalTo(self.remainMonthsView);
    }];
    //转让中的button
    
//    [array mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedItemLength:0 leadSpacing:0 tailSpacing:0];
//    [array mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.contentView);
//        make.bottom.equalTo(self.contentView);
//    }];
}

- (void) setLoanTruansferViewModel:(HXBFinHomePageViewModel_LoanTruansferViewModel *)LoanTruansferViewModel {
    _LoanTruansferViewModel = LoanTruansferViewModel;
    [self.interestView setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
        viewModelVM.leftLabelStr = LoanTruansferViewModel.interest;
        viewModelVM.rightLabelStr = @"年利率";
        viewModelVM.leftLabelAlignment = NSTextAlignmentLeft;
        viewModelVM.rightLabelAlignment = NSTextAlignmentLeft;
        viewModelVM.rightFont = kHXBFont_PINGFANGSC_REGULAR(13);
        viewModelVM.leftFont = kHXBFont_PINGFANGSC_REGULAR(24);
        viewModelVM.leftViewColor = HXBC_Red_Light;
        viewModelVM.rightViewColor = kHXBColor_Font0_6;
        return viewModelVM;
    }];
    [self.remainMonthsView setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
        viewModelVM.leftLabelStr = LoanTruansferViewModel.loanTruansferListModel.leftMonths;
        viewModelVM.rightLabelStr = @"剩余期限";
        viewModelVM.leftLabelAlignment = NSTextAlignmentCenter;
        viewModelVM.rightLabelAlignment = NSTextAlignmentCenter;
        viewModelVM.rightFont = kHXBFont_PINGFANGSC_REGULAR(13);
        viewModelVM.leftFont = kHXBFont_PINGFANGSC_REGULAR(24);
        viewModelVM.leftViewColor = kHXBColor_Grey_Font0_3;
        viewModelVM.rightViewColor = kHXBColor_Font0_6;
        return viewModelVM;
    }];

    self.amountTransferLabel.text = LoanTruansferViewModel.leftTransAmount_YUAN;
    self.loanLable.text = @"消费借款";
    self.loanImageView.image = [SVGKImage imageNamed:@"LoanTruansfer"].UIImage;
    
    [self.stutasButton setTitle:@"转让中" forState:UIControlStateNormal];
//    self.interestView.leftLabel.text = LoanTruansferViewModel.interest;
}
@end
