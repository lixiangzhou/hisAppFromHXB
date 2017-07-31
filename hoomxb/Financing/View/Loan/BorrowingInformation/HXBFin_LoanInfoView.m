//
//  HXBFin_LoanInfoView.m
//  hoomxb
//
//  Created by HXB on 2017/7/28.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_LoanInfoView.h"
#import "HXBLoanInstructionView.h"
#import "HXBFin_LoanPerson_Info.h"
#import "HXBFinDetailViewModel_LoanDetail.h"
@interface HXBFin_LoanInfoView ()
///借款说明
@property (nonatomic,strong) HXBLoanInstructionView *loanInstuctionView;
///借款人信息
@property (nonatomic,strong) HXBFin_LoanPerson_Info *loanPerson_infoView;
///基础信息
@property (nonatomic,strong) HXBBaseView_MoreTopBottomView *loanInfoView;
///财务信息
@property (nonatomic,strong) HXBBaseView_MoreTopBottomView *loanFinView;
///工作信息
@property (nonatomic,strong) HXBBaseView_MoreTopBottomView *workInfoView;
@end
@implementation HXBFin_LoanInfoView

-(instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUP];
    }
    return self;
}
- (void)setUP {
    [self setUPFrame];
    self.backgroundColor = kHXBColor_BackGround;
}


- (void)setLoan_finDatailModel:(HXBFinDetailViewModel_LoanDetail *)loan_finDatailModel {
    _loan_finDatailModel = loan_finDatailModel;
    /////借款说明
    self.loanInstuctionView.loanDetailViewModel = loan_finDatailModel;
    ///借款人信息(预留接口)
//    self.loanPerson_infoView
    
    [self.loanInfoView setUPViewManagerWithBlock:^HXBBaseView_MoreTopBottomViewManager *(HXBBaseView_MoreTopBottomViewManager *viewManager) {
        viewManager.leftStrArray = @[
                                     @"基础信息",
                                     @"姓名：",
                                     @"年龄：",
                                     @"婚姻：",
                                     @"身份证号：",
                                     @"学历：",
                                     @"籍贯：",
                                     ];
        viewManager.rightStrArray = @[      @"基础信息",
                                            @"姓名：",
                                            @"年龄：",
                                            @"婚姻：",
                                            @"身份证号：",
                                            @"学历：",
                                            @"籍贯：",];
        
        viewManager.leftFont = kHXBFont_PINGFANGSC_REGULAR(14);
        viewManager.rightFont = kHXBFont_PINGFANGSC_REGULAR(14);
        viewManager.leftTextColor = kHXBColor_HeightGrey_Font0_4;
        viewManager.rightTextColor = kHXBColor_Font0_6;
        return viewManager;
    }];
    
    [self.loanFinView setUPViewManagerWithBlock:^HXBBaseView_MoreTopBottomViewManager *(HXBBaseView_MoreTopBottomViewManager *viewManager) {
        viewManager.leftStrArray = @[
                                     @"财务信息",
                                     @"车产：",
                                     @"房产：",
                                     @"房贷：",
                                     @"月收入（月）："
                                     ];
        viewManager.rightStrArray = @[
                                      @"财务信息",
                                      @"车产：",
                                      @"房产：",
                                      @"房贷：",
                                      @"月收入（月）："
                                      ];
        
        viewManager.leftFont = kHXBFont_PINGFANGSC_REGULAR(14);
        viewManager.rightFont = kHXBFont_PINGFANGSC_REGULAR(14);
        viewManager.leftTextColor = kHXBColor_HeightGrey_Font0_4;
        viewManager.rightTextColor = kHXBColor_Font0_6;
        return viewManager;
    }];
    
    [self.workInfoView setUPViewManagerWithBlock:^HXBBaseView_MoreTopBottomViewManager *(HXBBaseView_MoreTopBottomViewManager *viewManager) {
        viewManager.leftStrArray = @[
                                     @"工作信息",
                                     @"公司类别：",
                                     @"职位：",
                                     @"工作行业：",
                                     @"工作城市："
                                     ];
        viewManager.rightStrArray = @[
                                      @"工作信息",
                                      @"公司类别：",
                                      @"职位：",
                                      @"工作行业：",
                                      @"工作城市："
                                      ];
        viewManager.leftFont = kHXBFont_PINGFANGSC_REGULAR(14);
        viewManager.rightFont = kHXBFont_PINGFANGSC_REGULAR(14);
        viewManager.leftTextColor = kHXBColor_HeightGrey_Font0_4;
        viewManager.rightTextColor = kHXBColor_Font0_6;
        return viewManager;
    }];
}


- (void)setUPFrame {
    [self.loanInstuctionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kScrAdaptationH(15)));
        make.left.right.equalTo(self);
    }];
    [self.loanPerson_infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(kScrAdaptationH(140)));
        make.right.left.equalTo(self);
        make.top.equalTo(self.loanInstuctionView.mas_bottom).offset(kScrAdaptationH(10));
    }];
    UIView *lienView = [self lienViewWithView:self.loanPerson_infoView];
    [self.loanInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lienView.mas_bottom).offset(0);
        make.left.right.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH(230)));
    }];
    
    UIView *lienView1 = [self lienViewWithView:self.loanInfoView];
    
    [self.loanFinView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lienView1.mas_bottom).offset(1);
        make.left.right.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH(201)));
    }];
    
    UIView *lineView2 = [self lienViewWithView:self.loanFinView];
    
    [self.workInfoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView2.mas_bottom).offset(1);
        make.left.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
}

- (UIView *)lienViewWithView:(UIView *)view {
    UIView *lienView = [[UIView alloc]init];
    [self addSubview:lienView];
    [lienView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom).offset(0);
        make.left.equalTo(self).offset(kScrAdaptationW(15));
        make.right.equalTo(self).offset(kScrAdaptationW(-15));
        make.height.equalTo(@(1));
    }];
    lienView.backgroundColor = kHXBColor_Grey093;
    return lienView;
}

///借款说明
- (HXBLoanInstructionView *)loanInstuctionView {
    if (!_loanInstuctionView) {
        _loanInstuctionView = [[HXBLoanInstructionView alloc]initWithFrame:CGRectZero];
        [self addSubview:_loanInstuctionView];
    }
    return _loanInstuctionView;
}

///借款人信息
- (HXBFin_LoanPerson_Info *)loanPerson_infoView {
    if (!_loanPerson_infoView) {
        _loanPerson_infoView = [[HXBFin_LoanPerson_Info alloc]initWithFrame:CGRectZero];
        [self addSubview:_loanPerson_infoView];
    }
    return _loanPerson_infoView;
}

///基础信息
- (HXBBaseView_MoreTopBottomView *)loanInfoView {
    if (!_loanInfoView) {
        UIEdgeInsets insets = UIEdgeInsetsMake(kScrAdaptationW(15), kScrAdaptationW(15), kScrAdaptationW(15), kScrAdaptationW(15));
        _loanInfoView = [[HXBBaseView_MoreTopBottomView alloc]initWithFrame:CGRectZero andTopBottomViewNumber:7 andViewClass:[UILabel class] andViewHeight:kScrAdaptationH(20) andTopBottomSpace:kScrAdaptationH(10) andLeftRightLeftProportion:kScrAdaptationW(5) Space:insets];
        _loanInfoView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_loanInfoView];
    }
    return _loanInfoView;
}

/// 财务信息
- (HXBBaseView_MoreTopBottomView *)loanFinView {
    if (!_loanFinView) {
         UIEdgeInsets insets = UIEdgeInsetsMake(kScrAdaptationW(15), kScrAdaptationW(15), kScrAdaptationW(15), kScrAdaptationW(15));
        _loanFinView = [[HXBBaseView_MoreTopBottomView alloc]initWithFrame:CGRectZero andTopBottomViewNumber:5 andViewClass:[UILabel class] andViewHeight:kScrAdaptationH(20) andTopBottomSpace:kScrAdaptationH(10) andLeftRightLeftProportion:kScrAdaptationW(5) Space:insets];
        _loanFinView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_loanFinView];
    }
    return _loanFinView;
}
- (HXBBaseView_MoreTopBottomView *)workInfoView {
    if (_workInfoView) {
        UIEdgeInsets insets = UIEdgeInsetsMake(kScrAdaptationW(15), kScrAdaptationW(15), kScrAdaptationW(15), kScrAdaptationW(15));
        _workInfoView = [[HXBBaseView_MoreTopBottomView alloc] initWithFrame:CGRectZero andTopBottomViewNumber:5 andViewClass:[UILabel class] andViewHeight:kScrAdaptationH(20) andTopBottomSpace:kScrAdaptationH(10) andLeftRightLeftProportion:kScrAdaptationW(5) Space:insets];
        _workInfoView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_workInfoView];
    }
    return _workInfoView;
}
@end
