//
//  HXBFinBaseNegotiateView.m
//  hoomxb
//
//  Created by HXB on 2017/7/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinBaseNegotiateView.h"
@interface HXBFinBaseNegotiateView ()
///点击了协议
@property (nonatomic,copy) void(^clickNegotiateBlock)();
///点击了对勾
@property (nonatomic,copy)void(^clickCheckMarkBlock)(BOOL isSelected);
///服务协议的Image
@property (nonatomic,strong) UIImageView *negotiateImageView;
///服务协议image后的北京视图
@property (nonatomic,strong) UIButton *negotiateImageViewBackgroundButton;
///服务协议
@property (nonatomic,strong) UILabel *negotiateLabel;
///服务协议 button
@property (nonatomic,strong) UIButton *negotiateButton;
@property (nonatomic,strong) UIButton *negotiateButton1;

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
    self.negotiateButton1 = [[UIButton alloc]init];
    self.negotiateLabel = [[UILabel alloc]init];
    self.negotiateButton1.hidden = YES;
    //协议
    [self addSubview:self.negotiateImageViewBackgroundButton];
    [self.negotiateImageViewBackgroundButton addSubview:self.negotiateImageView];
    [self addSubview:self.negotiateLabel];
    [self addSubview:self.negotiateButton];
    [self addSubview:self.negotiateButton1];
}

- (void)setUPViewsFrame {
    //协议
    [self.negotiateImageViewBackgroundButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(kScrAdaptationW750(30));
        make.height.width.equalTo(@(kScrAdaptationW750(28)));
    }];
    [self.negotiateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.negotiateImageViewBackgroundButton);
        make.height.width.equalTo(@(kScrAdaptationW750(28)));
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
    [self.negotiateButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.negotiateButton.mas_right).offset(0);
        make.height.bottom.equalTo(self.negotiateLabel);
    }];
    
    self.negotiateImageViewBackgroundButton.backgroundColor = [UIColor whiteColor];
    self.negotiateImageViewBackgroundButton.layer.borderColor = kHXBColor_Blue040610.CGColor;
    self.negotiateImageViewBackgroundButton.layer.borderWidth = kXYBorderWidth;
    self.negotiateImageViewBackgroundButton.layer.cornerRadius = kScrAdaptationH750(6);
    self.negotiateImageViewBackgroundButton.layer.masksToBounds = true;
    self.negotiateImageView.image = [UIImage imageNamed:@"duigou"];
    self.negotiateLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(26);
    self.negotiateButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(26);
    self.negotiateButton1.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(26);
    self.negotiateLabel.textColor = kHXBColor_Font0_6;
}

- (void)setUPViews {
    [self.negotiateButton setTitleColor:kHXBColor_Blue040610 forState:UIControlStateNormal];
    [self.negotiateButton1 setTitleColor:kHXBColor_Blue040610 forState:UIControlStateNormal];
    [self.negotiateButton addTarget:self action:@selector(clickNegotiateButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.negotiateButton1 addTarget:self action:@selector(clickNegotiateButton1:) forControlEvents:UIControlEventTouchUpInside];
    self.negotiateLabel.text = @"我已阅读并同意";///@"我已阅读并同意";
    
    [self.negotiateImageViewBackgroundButton addTarget:self action:@selector(clickNegotiateImageViewBackgroundButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)clickNegotiateImageViewBackgroundButton: (UIButton *)button {
    NSLog(@"点击了协议确认对勾%@",self);
    button.selected = !button.selected;
//    self.negotiateImageView.hidden = button.selected;
    if (button.selected) {
        self.negotiateImageView.image = [UIImage imageNamed:@"Rectangle"];
    }else
    {
        self.negotiateImageView.image = [UIImage imageNamed:@"duigou"];
        
    }
    if (self.clickCheckMarkBlock) {
        self.clickCheckMarkBlock(!button.selected);
    }
}

- (void)clickNegotiateButton: (UIButton *)button {
    if (self.block) {
        self.block(1);
    }
    if (self.clickNegotiateBlock) {
        self.clickNegotiateBlock();
    }
}
- (void)clickCheckMarkWithBlock:(void(^)(BOOL isSelected))clickCheckMarkBlock {
    self.clickCheckMarkBlock = clickCheckMarkBlock;
}
- (void)setNegotiateStr:(NSString *)negotiateStr {
    _negotiateStr = negotiateStr;
    if (![negotiateStr containsString:@"《》"]) {
        _negotiateStr = [NSString stringWithFormat:@"《%@》",negotiateStr];
    }
    [self.negotiateButton setTitle:_negotiateStr  forState: UIControlStateNormal];
    if ([_type isEqualToString:@"购买页"]) {
        NSArray *negotiateArray = [_negotiateStr componentsSeparatedByString:@"》,《"];
        if (negotiateArray.count > 1) {
            self.negotiateButton1.hidden = YES;
            [self.negotiateButton setTitle:[NSString stringWithFormat:@"%@》", negotiateArray[0]]  forState: UIControlStateNormal];
            [self.negotiateButton1 setTitle:[NSString stringWithFormat:@"《%@", negotiateArray[1]]  forState: UIControlStateNormal];
        }
    }
}

- (void)clickNegotiateWithBlock:(void (^)())clickNegotiateBlock {
    self.clickNegotiateBlock = clickNegotiateBlock;
}

- (void)clickNegotiateButton1:(UIButton *)button {
    if (self.block) {
        _block(2);
    }
}

@end
