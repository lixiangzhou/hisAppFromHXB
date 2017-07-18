//
//  HXBFinBaseNegotiateView.m
//  hoomxb
//
//  Created by HXB on 2017/7/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinBaseNegotiateView.h"
@interface HXBFinBaseNegotiateView ()
///点击了协议
@property (nonatomic,copy) void(^clickNegotiateBlock)();
///服务协议的Image
@property (nonatomic,strong) UIImageView *negotiateImageView;
///服务协议image后的北京视图
@property (nonatomic,strong) UIButton *negotiateImageViewBackgroundButton;
///服务协议
@property (nonatomic,strong) UILabel *negotiateLabel;
///服务协议 button
@property (nonatomic,strong) UIButton *negotiateButton;
@end
@implementation HXBFinBaseNegotiateView
- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUP];
    }
    return self;
}
- (void)setUP {
    [self creatViews];
    [self setUPViews];
    [self setUPViewsFrame];
}

- (void)creatViews {
    self.negotiateImageViewBackgroundButton = [[UIButton alloc]init];
    self.negotiateImageView = [[UIImageView alloc]init];
    self.negotiateButton = [[UIButton alloc]init];
    self.negotiateLabel = [[UILabel alloc]init];
    //协议
    [self addSubview:self.negotiateImageViewBackgroundButton];
    [self.negotiateImageViewBackgroundButton addSubview:self.negotiateImageView];
    [self addSubview:self.negotiateLabel];
    [self addSubview:self.negotiateButton];
}

- (void)setUPViewsFrame {
    //协议
    [self.negotiateImageViewBackgroundButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(kScrAdaptationW750(30));
        make.height.width.equalTo(@(kScrAdaptationW750(28)));
    }];
    [self.negotiateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self.negotiateImageViewBackgroundButton).offset(kScrAdaptationW750(3));
        make.bottom.right.equalTo(self.negotiateImageViewBackgroundButton).offset(kScrAdaptationW750(-3));
    }];
    [self.negotiateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.negotiateImageViewBackgroundButton.mas_right).offset(kScrAdaptationW750(10));
        make.height.equalTo(@(kScrAdaptationH750(26)));
        make.centerY.equalTo(self);
    }];
    [self.negotiateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.negotiateLabel.mas_right).offset(0);
        make.height.bottom.equalTo(self.negotiateLabel);
    }];
    self.negotiateImageViewBackgroundButton.layer.borderColor = kHXBColor_Blue040610.CGColor;
    self.negotiateImageViewBackgroundButton.layer.borderWidth = kScrAdaptationW750(1);
    self.negotiateLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(26);
    self.negotiateButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(26);
    self.negotiateLabel.textColor = kHXBColor_Font0_6;
}

- (void)setUPViews {
    [self.negotiateButton setTitleColor:kHXBColor_Blue040610 forState:UIControlStateNormal];
    [self.negotiateButton addTarget:self action:@selector(clickNegotiateButton:) forControlEvents:UIControlEventTouchUpInside];
    self.negotiateLabel.text = @"我已阅读并同意";///@"我已阅读并同意";
    
    [self.negotiateImageViewBackgroundButton addTarget:self action:@selector(clickNegotiateImageViewBackgroundButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickNegotiateImageViewBackgroundButton: (UIButton *)button {
    NSLog(@"点击了协议确认对勾%@",self);
    button.selected = !button.selected;
    self.negotiateImageView.hidden = button.selected;
}

- (void)clickNegotiateButton: (UIButton *)button {
    NSLog(@"点击了服务协议%@",self);
    if (self.clickNegotiateBlock) {
        self.clickNegotiateBlock();
    }
}

- (void)setNegotiateStr:(NSString *)negotiateStr {
    _negotiateStr = negotiateStr;
    if (![negotiateStr containsString:@"《》"]) {
        _negotiateStr = [NSString stringWithFormat:@"《%@》",negotiateStr];
    }
    [self.negotiateButton setTitle:_negotiateStr  forState: UIControlStateNormal];
}

- (void)clickNegotiateWithBlock:(void (^)())clickNegotiateBlock {
    self.clickNegotiateBlock = clickNegotiateBlock;
}
@end
