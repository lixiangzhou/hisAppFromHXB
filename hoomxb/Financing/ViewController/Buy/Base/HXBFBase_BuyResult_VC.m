//
//  HXBFin_BuySeccess_LoanTruansferVC.m
//  hoomxb
//
//  Created by HXB on 2017/7/20.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFBase_BuyResult_VC.h"

@interface HXBFBase_BuyResult_VC ()
@property (nonatomic,strong) UIImageView *imageView;
/**
 massage
 */
@property (nonatomic,strong) UILabel * buy_titleLabel;
/**
 上下lable的View
 */
@property (nonatomic,strong) HXBBaseView_MoreTopBottomView * buy_massageLabel;
/**
 description
 */
@property (nonatomic,strong) UILabel * buy_descriptionLabel;
/**
 icon
 */
@property (nonatomic,strong) UIImageView *iconImageView;
/**
 midLabel
 */
@property (nonatomic,strong) UILabel *midLabel;
/**
 button title
 */
@property (nonatomic,strong) UIButton * buy_ButtonTitleLabel;

@property (nonatomic,assign) CGFloat massageHeight;
@property (nonatomic,copy) void(^clickButtonBlock)();
@end

@implementation HXBFBase_BuyResult_VC


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUP];
}
- (void)setUP {
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kScrAdaptationH750(130));
        make.width.equalTo(@(kScrAdaptationW750(310)));
        make.height.equalTo(@(kScrAdaptationH750(198)));
        make.centerX.equalTo(self.view);
    }];
    
    [self.buy_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.imageView.mas_bottom).offset(kScrAdaptationH750(70));
    }];
    
 
    UIView *view = self.buy_titleLabel;
    if (self.buy_massageCount) {
        [self.buy_massageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.mas_bottom).offset(kScrAdaptationH750(95));
            make.left.right.equalTo(self.view);
            make.height.equalTo(@(self.massageHeight));
        }];
        view = self.buy_massageLabel;
    }
    if (self.buy_description) {
        self.iconImageView = [[UIImageView alloc]init];
        self.iconImageView.image = [UIImage imageNamed:@"itp"];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_left);
            make.top.equalTo(view.mas_bottom).offset(kScrAdaptationH750(29));
            make.height.with.equalTo(@(kScrAdaptationH750(26)));
        }];
        view = self.iconImageView;
        [self.buy_descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(view.mas_right).offset(0);
            make.right.equalTo(self.view).offset(kScrAdaptationW750(-40));
        }];
        view = self.buy_descriptionLabel;
    }
    if(self.midStr) {
        self.midLabel = [[UILabel alloc]init];
        self.midLabel.text = self.midStr;
        self.midLabel.textColor = kHXBColor_Font0_6;
        self.midLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(26);
        [self.midLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view.mas_bottom).offset(kScrAdaptationH750(16));
            make.centerX.equalTo(view);
        }];
        view = self.midLabel;
    }
    
    [self.buy_ButtonTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom).offset(kScrAdaptationH750(100));
        make.centerX.equalTo(view);
        make.width.equalTo(@(kScrAdaptationW750(670)));
        make.height.equalTo(@(kScrAdaptationH750(82)));
    }];
    [self.buy_ButtonTitleLabel addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    kWeakSelf
    [_buy_massageLabel setUPViewManagerWithBlock:^HXBBaseView_MoreTopBottomViewManager *(HXBBaseView_MoreTopBottomViewManager *viewManager) {
        viewManager.leftStrArray = weakSelf.massage_Left_StrArray;
        viewManager.rightStrArray = weakSelf.massage_Right_StrArray;
        viewManager.leftFont = kHXBFont_PINGFANGSC_REGULAR_750(30);
        viewManager.rightFont = kHXBFont_PINGFANGSC_REGULAR_750(30);
        viewManager.leftTextColor = kHXBColor_Grey_Font0_2;
        viewManager.rightTextColor = kHXBColor_Font0_6;
        return viewManager;
    }];
}
- (void)clickButton: (UIButton *)button {
    if (self.clickButtonBlock) {
        self.clickButtonBlock();
    }
}

- (void)clickButtonWithBlock:(void(^)())clickButtonBlock {
    self.clickButtonBlock = clickButtonBlock;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        [self.view addSubview: _imageView];
        _imageView.image = [UIImage imageNamed:self.imageName];
    }
    return _imageView;
}
- (UILabel *)buy_titleLabel {
    if (!_buy_titleLabel) {
        _buy_titleLabel = [[UILabel alloc] init];
        _buy_titleLabel.text = self.buy_title;
        [self.view addSubview:self.buy_titleLabel];
        _buy_titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(38);
        _buy_titleLabel.textColor = kHXBColor_Grey_Font0_2;

    }
    return _buy_titleLabel;
}
- (HXBBaseView_MoreTopBottomView *)buy_massageLabel {
    if (!_buy_massageLabel) {
        UIEdgeInsets edge = UIEdgeInsetsMake(0, kScrAdaptationW750(40), 0, kScrAdaptationW750(40));
        _buy_massageLabel = [[HXBBaseView_MoreTopBottomView alloc]initWithFrame:CGRectZero andTopBottomViewNumber:self.buy_massageCount andViewClass:[UILabel class] andViewHeight:kScrAdaptationH750(30) andTopBottomSpace:kScrAdaptationH750(28) andLeftRightLeftProportion:0 Space:edge];
    }
    return _buy_massageLabel;
}

- (UILabel *)buy_descriptionLabel {
    if (!_buy_descriptionLabel) {
        _buy_descriptionLabel = [[UILabel alloc]init];
        _buy_descriptionLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(26);
        _buy_descriptionLabel.textColor = kHXBColor_Font0_6;
        _buy_descriptionLabel.numberOfLines = 0;
    }
    return _buy_descriptionLabel;
}
- (UIButton *) buy_ButtonTitleLabel {
    if (!_buy_ButtonTitleLabel) {
        _buy_ButtonTitleLabel = [[UIButton alloc]init];
        _buy_ButtonTitleLabel.layer.masksToBounds = true;
        _buy_ButtonTitleLabel.layer.cornerRadius = kScrAdaptationW750(5);
        _buy_ButtonTitleLabel.backgroundColor = kHXBColor_Red_090303;
        _buy_ButtonTitleLabel.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(32);
        [_buy_ButtonTitleLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    return _buy_ButtonTitleLabel;
}
- (void)setBuy_massageCount:(NSInteger)buy_massageCount {
    _buy_massageCount = buy_massageCount;
    CGFloat label_TotalHeight = _buy_massageCount * kScrAdaptationH750(30);
    CGFloat spacing_TotalHeight = (_buy_massageCount - 1) * kScrAdaptationH750(28);
    self.massageHeight = label_TotalHeight + spacing_TotalHeight;
}
- (CGFloat) massageHeight {
    CGFloat label_TotalHeight = _buy_massageCount * kScrAdaptationH750(30);
    CGFloat spacing_TotalHeight = (_buy_massageCount - 1) * kScrAdaptationH750(28);
    return label_TotalHeight + spacing_TotalHeight;
}
@end
