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
    [self addSubview:self.bottomLabel];
    [self addSubview:self.addBtn];
    [_protocolView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kScrAdaptationH750(10));
        make.left.equalTo(self);
        make.width.offset(kScreenWidth - 2 * kScrAdaptationW(15));
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

- (HXBFinBaseNegotiateView *)bottomLabel {
    if (!_protocolView) {
        _protocolView = [[HXBFinBaseNegotiateView alloc] init];
        _protocolView.type = @"购买页";
    }
    kWeakSelf
    _protocolView.block = ^(NSInteger type) {
        if (type == 1) {
            if (weakSelf.delegateBlock) {
                weakSelf.delegateBlock(1);
            }
        } else {
            if (weakSelf.delegateBlock) {
                weakSelf.delegateBlock(2);
            }
        }
    };
    [_protocolView clickCheckMarkWithBlock:^(BOOL isSelected) {
        _isSelectDelegate = isSelected;
        if (isSelected && _addBtnIsUseable) {
            [self isClickWithAble:YES];
        } else {
            [self isClickWithAble:NO];
        }
    }];
    return _protocolView;
}

- (void)setDelegateLabel:(NSString *)delegateLabel {
    _delegateLabel = delegateLabel;
    _protocolView.negotiateStr = delegateLabel;
}


- (void)setClickBtnStr:(NSString *)clickBtnStr {
    _clickBtnStr = clickBtnStr;
    [_addBtn setTitle:clickBtnStr forState:(UIControlStateNormal)];
}

// 按钮是否可以点击
- (void)isClickWithAble:(BOOL)able { // 1 可以点击 2 不可点击
    if (able) {
        _addBtn.userInteractionEnabled = YES;
        _addBtn.backgroundColor = COR29;
    } else {
        _addBtn.userInteractionEnabled = NO;
        _addBtn.backgroundColor = COR12;
    }
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
    self.addBlock(button.titleLabel.text);
}



@end
