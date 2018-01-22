//
//  HXBCreditorChangeBottomView.m
//  hoomxb
//
//  Created by 肖扬 on 2017/9/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBCreditorChangeBottomView.h"
#import "HXBFinBaseNegotiateView.h"

@interface HXBCreditorChangeBottomView ()

/** 富文本 */
@property (nonatomic, strong) HXBFinBaseNegotiateView *protocolView;
/** 风险富文本 */
@property (nonatomic, strong) HXBFinBaseNegotiateView *riskView;
/** 点击按钮 */
@property (nonatomic, strong) UIButton *addBtn;
/** 是否选中协议 */
@property (nonatomic, assign) BOOL isSelectDelegate;
/** 是否选中风险 */
@property (nonatomic, assign) BOOL isSelectRiskDelegate;

@end

@implementation HXBCreditorChangeBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self buildUI];
        _isSelectDelegate = YES;
        _isSelectRiskDelegate = NO;
    }
    return self;
}

- (void)buildUI {
    [self addSubview:self.protocolView];
    [self addSubview:self.riskView];
    [self addSubview:self.addBtn];
    
    kWeakSelf
    
    [_riskView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(kScrAdaptationH750(10));
        make.left.equalTo(weakSelf);
        make.width.offset(kScreenWidth);
        make.height.offset(kScrAdaptationH(20));
    }];
    [_protocolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.riskView.mas_bottom);
        make.left.equalTo(weakSelf);
        make.width.offset(kScreenWidth);
        make.height.offset(kScrAdaptationH(20));
    }];
    
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_protocolView.mas_bottom).offset(kScrAdaptationH750(80));
        make.left.equalTo(weakSelf).offset(kScrAdaptationH750(40));
        make.right.equalTo(weakSelf).offset(kScrAdaptationH750(-40));
        make.height.offset(kScrAdaptationH750(90));
    }];
}

- (void)setAddBtnIsUseable:(BOOL)addBtnIsUseable {
    _addBtnIsUseable = addBtnIsUseable;
    if (addBtnIsUseable && _isSelectDelegate) {
        if (_isShowRiskView) {
            [self isClickWithAble:_isSelectRiskDelegate];
        } else {
            [self isClickWithAble:YES];
        }
    } else {
        [self isClickWithAble:NO];
    }
}

- (void)setIsShowRiskView:(BOOL)isShowRiskView {
    _isShowRiskView = isShowRiskView;
    _riskView.hidden = !_isShowRiskView;
    kWeakSelf
    if (_isShowRiskView) {
        [_protocolView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf.riskView.mas_bottom);
        }];
    } else {
        [_protocolView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf).offset(kScrAdaptationH750(10));
        }];
    }
}

- (HXBFinBaseNegotiateView *)protocolView {
    if (!_protocolView) {
        _protocolView = [[HXBFinBaseNegotiateView alloc] init];
        _protocolView.type = @"购买页";
    }
    kWeakSelf
    _protocolView.block = ^(NSInteger type) {
        if (weakSelf.delegateBlock) {
            weakSelf.delegateBlock(type);
        }
    };
    [_protocolView clickCheckMarkWithBlock:^(BOOL isSelected) {
        NSLog(@"_protocolView = %d", isSelected);
        _isSelectDelegate = isSelected;
        [self isClickWithAble:(isSelected && _addBtnIsUseable)];
    }];
    return _protocolView;
}

- (HXBFinBaseNegotiateView *)riskView {
    if (!_riskView) {
        _riskView = [[HXBFinBaseNegotiateView alloc] initWithFrame:CGRectZero];
        _riskView.type = @"riskDelegate";
        _riskView.negotiateStr = @"我同意向超出我风险承受能力的标的出借资金";
    }
    kWeakSelf
    [_riskView clickCheckMarkWithBlock:^(BOOL isSelected) {
        NSLog(@"_riskView = %d", isSelected);
        _isSelectRiskDelegate = isSelected;
        [self isClickWithAble:(_isSelectDelegate && _addBtnIsUseable && isSelected)];
        if (weakSelf.riskBlock) {
            weakSelf.riskBlock(isSelected);
        }
    }];
    return _riskView;
}

- (void)setDelegateLabelText:(NSString *)delegateLabelText {
    _delegateLabelText = delegateLabelText;
    _protocolView.negotiateStr = delegateLabelText;
}


- (void)setClickBtnStr:(NSString *)clickBtnStr {
    _clickBtnStr = clickBtnStr;
    [_addBtn setTitle:clickBtnStr forState:(UIControlStateNormal)];
}

// 按钮是否可以点击
- (void)isClickWithAble:(BOOL)able {
    _addBtn.userInteractionEnabled = able;
    _addBtn.backgroundColor = able ? COR29 : COR12;
}

- (UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _addBtn.backgroundColor = COR29;
        _addBtn.layer.cornerRadius = 5.0f;;
        _addBtn.layer.masksToBounds = YES;
        [_addBtn addTarget:self action:@selector(clickBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _addBtn;
}

- (void)clickBtn:(UIButton *)button {
    if (self.addBlock) {
        self.addBlock(button.titleLabel.text);
    }
}



@end
