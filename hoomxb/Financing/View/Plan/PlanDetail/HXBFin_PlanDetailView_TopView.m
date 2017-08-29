//
//  HXBFin_PlanDetailView_TopView.m
//  hoomxb
//
//  Created by HXB on 2017/7/11.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_PlanDetailView_TopView.h"
#import "NSAttributedString+HxbAttributedString.h"
@interface HXBFin_PlanDetailView_TopView()
@property (nonatomic,strong) HXBBaseView_TwoLable_View *topView;//预期年化
@property (nonatomic,strong) HXBBaseView_TwoLable_View *leftView;//期限
@property (nonatomic,strong) HXBBaseView_TwoLable_View *midView;//起头
@property (nonatomic,strong) HXBBaseView_TwoLable_View *rightView;//剩余金额


@end
@implementation HXBFin_PlanDetailView_TopView
- (void)setUPValueWithManager: (HXBFin_PlanDetailView_TopViewManager *(^)(HXBFin_PlanDetailView_TopViewManager *manager))managerBlock {
    self.manager = managerBlock(self.manager);
}
- (void)setManager:(HXBFin_PlanDetailView_TopViewManager *)manager {
    _manager = manager;
    [self.topView setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
        return manager.topViewManager;
    }];
    [self.leftView setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
        return manager.leftViewManager;
    }];
    [self.midView setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
        return manager.midViewManager;
    }];
    [self.rightView setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
        return manager.rightViewManager;
    }];
    NSString *str = manager.topViewManager.leftLabelStr;
    NSRange range = NSMakeRange(str.length - _attributeStringLength, _attributeStringLength);
//    NSRange range = NSMakeRange(str.length, 0);
    UIColor *color = [UIColor whiteColor];
    UIFont *font = kHXBFont_PINGFANGSC_REGULAR(30);
    NSMutableAttributedString *attrM = [NSAttributedString setupAttributeStringWithString:str WithRange:range andAttributeColor:color andAttributeFont:font];
    self.topView.leftLabel.attributedText = attrM;
}

/**
 顶部view
 */
- (HXBBaseView_TwoLable_View *) topView {
    if (!_topView) {
        _topView = [[HXBBaseView_TwoLable_View alloc] initWithFrame:CGRectZero andSpacing:kScrAdaptationH(12)];
        [self addSubview:_topView];
    }
    return _topView;
}
- (HXBBaseView_TwoLable_View *) leftView {
    if (!_leftView) {
        _leftView = [[HXBBaseView_TwoLable_View alloc] initWithFrame:CGRectZero andSpacing:kScrAdaptationH(1)];
        [self addSubview:_leftView];
    }
    return _leftView;
}
- (HXBBaseView_TwoLable_View *) midView {
    if (!_midView) {
        _midView = [[HXBBaseView_TwoLable_View alloc] initWithFrame:CGRectZero andSpacing:kScrAdaptationH(1)];
        [self addSubview:_midView];
    }
    return _midView;
}
- (HXBBaseView_TwoLable_View *) rightView {
    if (!_rightView) {
        _rightView = [[HXBBaseView_TwoLable_View alloc] initWithFrame:CGRectZero andSpacing:kScrAdaptationH(1)];
        [self addSubview:_rightView];
    }
    return _rightView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _manager = [[HXBFin_PlanDetailView_TopViewManager alloc]init];
        [self setUP];
    }
    return self;
}
- (void)setUP {
    [self layoutIfNeeded];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(kScrAdaptationH(-100));
        make.left.right.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH(78)));
    }];

    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).offset(kScrAdaptationH(44));
        make.left.equalTo(self);
        make.width.equalTo(self.mas_width).multipliedBy(1.0/3.0);
        make.height.equalTo(@(kScrAdaptationH(42)));
    }];
    [self.midView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftView.mas_right);
        make.width.top.bottom.equalTo(self.leftView);
    }];
    [self.rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.midView.mas_right);
        make.width.top.bottom.equalTo(self.midView);
    }];
}
@end

@implementation HXBFin_PlanDetailView_TopViewManager
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUPValue];
    }
    return self;
}
- (void)setUPValue {
    self.topViewManager    = [[HXBBaseView_TwoLable_View_ViewModel alloc]init];//预期年化
    self.topViewManager.leftFont= kHXBFont_PINGFANGSC_REGULAR(50);
    self.topViewManager.rightFont= kHXBFont_PINGFANGSC_REGULAR(12);
    self.topViewManager.leftViewColor = [UIColor whiteColor];
    self.topViewManager.rightViewColor = [UIColor colorWithWhite:1 alpha:0.6];
    
    self.leftViewManager   = [[HXBBaseView_TwoLable_View_ViewModel alloc]init];//期限
    self.leftViewManager.leftFont= kHXBFont_PINGFANGSC_REGULAR(15);
    self.leftViewManager.rightFont= kHXBFont_PINGFANGSC_REGULAR(12);
    self.leftViewManager.leftViewColor = [UIColor whiteColor];
    self.leftViewManager.rightViewColor = [UIColor colorWithWhite:1 alpha:0.6];
    
    self.midViewManager    = [[HXBBaseView_TwoLable_View_ViewModel alloc]init];//起头
    self.midViewManager.leftFont= kHXBFont_PINGFANGSC_REGULAR(15);
    self.midViewManager.rightFont= kHXBFont_PINGFANGSC_REGULAR(12);
    self.midViewManager.leftViewColor = [UIColor whiteColor];
    self.midViewManager.rightViewColor = [UIColor colorWithWhite:1 alpha:0.6];
    
    self.rightViewManager  = [[HXBBaseView_TwoLable_View_ViewModel alloc]init];//剩余金额
    self.rightViewManager.leftFont= kHXBFont_PINGFANGSC_REGULAR(15);
    self.rightViewManager.rightFont= kHXBFont_PINGFANGSC_REGULAR(12);
    self.rightViewManager.leftViewColor = [UIColor whiteColor];
    self.rightViewManager.rightViewColor = [UIColor colorWithWhite:1 alpha:0.6];
}
@end
