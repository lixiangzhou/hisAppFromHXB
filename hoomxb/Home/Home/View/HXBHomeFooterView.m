//
//  HXBHomeFooterView.m
//  hoomxb
//
//  Created by HXB-C on 2018/3/1.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBHomeFooterView.h"
#import "HXBHomeVCViewModel.h"
#import "HXBHomeBaseModel.h"
#import "HXBHomeTitleModel.h"
#import "HXBHomePlatformIntroductionModel.h"
#import <UIImageView+WebCache.h>
#import "UIButton+WebCache.h"
@interface HXBHomeFooterView()

@property (nonatomic, strong) UILabel *footerLabel;

@property (nonatomic, strong) UIButton *messageBtn;

@property (nonatomic, strong) UIButton *dataBtn;

@property (nonatomic, assign) CGFloat btnwith;

@end

@implementation HXBHomeFooterView

#pragma mark - Life Cycle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.messageBtn];
        [self addSubview:self.dataBtn];
        [self addSubview:self.footerLabel];
        self.btnwith = (kScreenW - 3 * kHXBSpacing_20) * 0.5;
        [self setUI];
    }
    return self;
}

- (void)setUI {
    kWeakSelf
    [self.messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.left.equalTo(weakSelf).offset(kHXBSpacing_20);
        make.height.offset(kScrAdaptationH750(170));
        make.width.offset(weakSelf.btnwith);
    }];
    [self.dataBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf);
        make.right.equalTo(weakSelf).offset(-kHXBSpacing_20);
        make.height.offset(kScrAdaptationH750(170));
        make.width.offset(weakSelf.btnwith);
    }];
    [self.footerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.messageBtn.mas_bottom).offset(kScrAdaptationH750(38));
        make.centerX.equalTo(weakSelf);
    }];
}

- (void)setHomeBaseViewModel:(HXBHomeVCViewModel *)homeBaseViewModel {
    _homeBaseViewModel = homeBaseViewModel;
    if (homeBaseViewModel.homeBaseModel.homeTitle.baseTitle.length) {
        self.footerLabel.text = [NSString stringWithFormat:@"- %@ -",homeBaseViewModel.homeBaseModel.homeTitle.baseTitle];
    }
    if (homeBaseViewModel.homeBaseModel.homePlatformIntroduction.count) {
        NSLog(@"%@",homeBaseViewModel.homeBaseModel.homePlatformIntroduction.firstObject.url);
        [self.messageBtn sd_setImageWithURL:[NSURL URLWithString:homeBaseViewModel.homeBaseModel.homePlatformIntroduction.firstObject.image] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"bannerplaceholder"]];
        
        [self.dataBtn sd_setImageWithURL:[NSURL URLWithString:homeBaseViewModel.homeBaseModel.homePlatformIntroduction.lastObject.image] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"bannerplaceholder"]];
    }
    else {
        self.messageBtn.hidden = YES;
        self.dataBtn.hidden = YES;
        kWeakSelf
        [self.footerLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(weakSelf);
            make.centerX.equalTo(weakSelf);
        }];
    }
    
}

#pragma mark - Action
- (void)messageBtnClick {
    if (self.homePlatformIntroduction) {
        self.homePlatformIntroduction(self.homeBaseViewModel.homeBaseModel.homePlatformIntroduction.firstObject);
    }
}

- (void)dataBtnClick {
    if (self.homePlatformIntroduction) {
        self.homePlatformIntroduction(self.homeBaseViewModel.homeBaseModel.homePlatformIntroduction.lastObject);
    }
}

#pragma mark - Setter / Getter / Lazy
- (UILabel *)footerLabel {
    if (!_footerLabel) {
        _footerLabel = [UILabel new];
        _footerLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
        _footerLabel.textColor = kHXBColor_999999_100;
    }
    return _footerLabel;
}

- (UIButton *)messageBtn {
    if (!_messageBtn) {
        _messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_messageBtn addTarget:self action:@selector(messageBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _messageBtn;
}

- (UIButton *)dataBtn {
    if (!_dataBtn) {
        _dataBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_dataBtn addTarget:self action:@selector(dataBtnClick) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _dataBtn;
}

@end
