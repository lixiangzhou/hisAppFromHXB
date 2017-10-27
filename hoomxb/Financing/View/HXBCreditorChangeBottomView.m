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
@property (nonatomic, strong) HXBFinBaseNegotiateView *bottomLabel;
/** 点击按钮 */
@property (nonatomic, strong) UIButton *addBtn;

@end

@implementation HXBCreditorChangeBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    [self addSubview:self.bottomLabel];
    [self addSubview:self.addBtn];
    [_bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kScrAdaptationH750(10));
        make.left.equalTo(self);
        make.width.offset(kScreenWidth - 2 * kScrAdaptationW(15));
        make.height.offset(kScrAdaptationH(35));
    }];
    [_addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bottomLabel.mas_bottom).offset(kScrAdaptationH750(80));
        make.left.equalTo(self).offset(kScrAdaptationH750(40));
        make.right.equalTo(self).offset(kScrAdaptationH750(-40));
        make.height.offset(kScrAdaptationH750(90));
    }];
    
}

- (HXBFinBaseNegotiateView *)bottomLabel {
    if (!_bottomLabel) {
        _bottomLabel = [[HXBFinBaseNegotiateView alloc] init];
        _bottomLabel.type = @"购买页";
    }
    kWeakSelf
    _bottomLabel.block = ^(NSInteger type) {
        if (type == 1) {
            if (weakSelf.delegateBlock) {
                weakSelf.delegateBlock(1);
            }
        } else {
//            if (weakSelf.delegateBlock) {
//                weakSelf.delegateBlock(2);
//            }
        }
    };
    [_bottomLabel clickCheckMarkWithBlock:^(BOOL isSelected) {
        if (isSelected) {
            [self isClickWithStatus:1];
        } else {
            [self isClickWithStatus:2];
        }
    }];
    return _bottomLabel;
}

- (void)setDelegateLabel:(NSString *)delegateLabel {
    _delegateLabel = delegateLabel;
    _bottomLabel.negotiateStr = delegateLabel;
}


- (void)setClickBtnStr:(NSString *)clickBtnStr {
    _clickBtnStr = clickBtnStr;
    [_addBtn setTitle:clickBtnStr forState:(UIControlStateNormal)];
}

// 按钮是否可以点击
- (void)isClickWithStatus:(int)status { // 1 可以点击 2 不可点击
    if (status == 1) {
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
