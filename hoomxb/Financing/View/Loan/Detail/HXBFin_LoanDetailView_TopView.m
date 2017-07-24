
//
//  HXBFin_LoanDetailView_TopView.m
//  hoomxb
//
//  Created by HXB on 2017/7/12.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_LoanDetailView_TopView.h"
@interface HXBFin_LoanDetailView_TopView ()
@property (nonatomic,strong) HXBBaseView_TwoLable_View *topView;//年利率
@property (nonatomic,strong) HXBBaseView_TwoLable_View *leftView;//期限
@property (nonatomic,strong) HXBBaseView_TwoLable_View *rightView;//剩余金额
@property (nonatomic,strong) HXBFin_LoanDetailView_TopViewManager *manager;
@end


@implementation HXBFin_LoanDetailView_TopView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _manager = [[HXBFin_LoanDetailView_TopViewManager alloc]init];
        [self setUP];
    }
    return self;
}
- (void)setUP {
    [self layoutIfNeeded];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kScrAdaptationH(42));
        make.left.right.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH(72)));
    }];
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).offset(kScrAdaptationH(24));
        make.left.equalTo(self);
        make.width.equalTo(self.mas_width).multipliedBy(1.0/3.0);
        make.height.equalTo(@(kScrAdaptationH(42)));
    }];

    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.self.mas_right);
        make.width.top.bottom.equalTo(self.leftView);
    }];
}
- (void)setUPValueWithManager: (HXBFin_LoanDetailView_TopViewManager *(^)(HXBFin_LoanDetailView_TopViewManager *manager))managerBlock {
    self.manager = managerBlock(self.manager);
}
- (void)setManager:(HXBFin_LoanDetailView_TopViewManager *)manager {
    _manager = manager;
    
    [self.topView setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
        return manager.topViewManager;
    }];
    [self.leftView setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
        return manager.leftViewManager;
    }];
    [self.rightView setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
        return manager.rightViewManager;
    }];
    NSString *str = manager.topViewManager.leftLabelStr;
    NSRange range = NSMakeRange(str.length - 1, 1);
    UIColor *color = [UIColor whiteColor];
    UIFont *font = kHXBFont_PINGFANGSC_REGULAR(20);
    NSMutableAttributedString *attrM = [NSAttributedString setupAttributeStringWithString:str WithRange:range andAttributeColor:color andAttributeFont:font];
    self.topView.leftLabel.attributedText = attrM;
}

/**
 顶部view
 */
- (HXBBaseView_TwoLable_View *) topView {
    if (!_topView) {
        _topView = [[HXBBaseView_TwoLable_View alloc] initWithFrame:CGRectZero andSpacing:kScrAdaptationH(15)];
        [self addSubview:_topView];
    }
    return _topView;
}
- (HXBBaseView_TwoLable_View *) leftView {
    if (!_leftView) {
        _leftView = [[HXBBaseView_TwoLable_View alloc] initWithFrame:CGRectZero andSpacing:kScrAdaptationH(3)];
        [self addSubview:_leftView];
    }
    return _leftView;
}
- (HXBBaseView_TwoLable_View *) rightView {
    if (!_rightView) {
        _rightView = [[HXBBaseView_TwoLable_View alloc] initWithFrame:CGRectZero andSpacing:kScrAdaptationH(3)];
        [self addSubview:_rightView];
    }
    return _rightView;
}
@end


@implementation HXBFin_LoanDetailView_TopViewManager
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUP];
    }
    return self;
}
- (void)setUP {
    self.topViewManager    = [[HXBBaseView_TwoLable_View_ViewModel alloc]init];//预期年化
    self.topViewManager.leftFont= kHXBFont_PINGFANGSC_REGULAR(45);
    self.topViewManager.rightFont= kHXBFont_PINGFANGSC_REGULAR(12);
    self.topViewManager.leftViewColor = [UIColor whiteColor];
    self.topViewManager.rightViewColor = [UIColor colorWithWhite:1 alpha:0.6];

    self.leftViewManager   = [[HXBBaseView_TwoLable_View_ViewModel alloc]init];//期限
    self.leftViewManager.leftFont= kHXBFont_PINGFANGSC_REGULAR(15);
    self.leftViewManager.rightFont= kHXBFont_PINGFANGSC_REGULAR(12);
    self.leftViewManager.leftViewColor = [UIColor whiteColor];
    self.leftViewManager.rightViewColor = [UIColor colorWithWhite:1 alpha:0.6];

    self.rightViewManager  = [[HXBBaseView_TwoLable_View_ViewModel alloc]init];//剩余金额
    self.rightViewManager.leftFont= kHXBFont_PINGFANGSC_REGULAR(15);
    self.rightViewManager.rightFont= kHXBFont_PINGFANGSC_REGULAR(12);
    self.rightViewManager.leftViewColor = [UIColor whiteColor];
    self.rightViewManager.rightViewColor = [UIColor colorWithWhite:1 alpha:0.6];
}
@end
