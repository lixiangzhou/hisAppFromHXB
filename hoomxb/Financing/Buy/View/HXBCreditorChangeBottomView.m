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
/** 点击按钮 */
@property (nonatomic, strong) UIButton *addBtn;
/** 是否选中协议 */
@property (nonatomic, assign) BOOL isSelectDelegate;
@end

@implementation HXBCreditorChangeBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self buildUI];
        _isSelectDelegate = YES;
    }
    return self;
}

- (void)buildUI {
    [self addSubview:self.protocolView];
    [self addSubview:self.addBtn];
    [_protocolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kScrAdaptationH750(10));
        make.left.equalTo(self);
        make.width.offset(kScreenWidth);
        make.height.offset(kScrAdaptationH(35));
    }];
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_protocolView.mas_bottom).offset(kScrAdaptationH750(80));
        make.left.equalTo(self).offset(kScrAdaptationH750(40));
        make.right.equalTo(self).offset(kScrAdaptationH750(-40));
        make.height.offset(kScrAdaptationH750(90));
    }];
}

- (void)setAddBtnIsUseable:(BOOL)addBtnIsUseable {
    _addBtnIsUseable = addBtnIsUseable;
    if (addBtnIsUseable && _isSelectDelegate) {
        [self isClickWithAble:YES];
    } else {
        [self isClickWithAble:NO];
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
        _isSelectDelegate = isSelected;
        [self isClickWithAble:(isSelected && _addBtnIsUseable)];
    }];
    return _protocolView;
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
