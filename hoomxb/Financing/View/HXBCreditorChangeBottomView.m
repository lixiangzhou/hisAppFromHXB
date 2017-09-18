//
//  HXBCreditorChangeBottomView.m
//  hoomxb
//
//  Created by 肖扬 on 2017/9/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
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
        make.top.equalTo(_bottomLabel.mas_bottom).offset(kScrAdaptationH750(100));
        make.left.equalTo(self).offset(kScrAdaptationH750(40));
        make.right.equalTo(self).offset(kScrAdaptationH750(-40));
        make.height.offset(kScrAdaptationH750(90));
    }];
    
}

- (HXBFinBaseNegotiateView *)bottomLabel {
    if (!_bottomLabel) {
        _bottomLabel = [[HXBFinBaseNegotiateView alloc] init];
        _bottomLabel.negotiateStr = @"债权转让及受让协议》《风险提示";
    }
    [_bottomLabel clickNegotiateWithBlock:^{
        NSLog(@"点击了协议");
    }];
    [_bottomLabel clickCheckMarkWithBlock:^(BOOL isSelected) {
        NSLog(@"点击了对勾");
    }];
    return _bottomLabel;
}

- (UIButton *)addBtn {
    if (!_addBtn) {
        _addBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        _addBtn.backgroundColor = COR29;
        _addBtn.layer.cornerRadius = 5.0f;;
        _addBtn.layer.masksToBounds = YES;
        [_addBtn setTitle:@"立即转让" forState:(UIControlStateNormal)];
        [_addBtn addTarget:self action:@selector(clickBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _addBtn;
}

- (void)clickBtn:(UIButton *)button {
    self.addBlock(button.titleLabel.text);
}



@end
