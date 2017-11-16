//
//  HXBNoDataView.m
//  hoomxb
//
//  Created by HXB on 2017/7/14.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBNoDataView.h"
#import "CJLabel.h"

@interface HXBNoDataView ()
@property (nonatomic,strong) UIImageView *notDataImageView;
@property (nonatomic,strong) CJLabel *noDataLabel;
@property (nonatomic,strong) UILabel *downPULabel;
@end
@implementation HXBNoDataView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUP];
    }
    return self;
}
- (void)setUP {//179
    [self.notDataImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH(101)));
        make.width.equalTo(@(kScrAdaptationW(128)));
    }];
    [self.noDataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.notDataImageView.mas_bottom).offset(kScrAdaptationH(35));
        make.height.equalTo(@(kScrAdaptationH(19)));
        make.centerX.equalTo(self.notDataImageView);
        make.width.equalTo(self);
    }];
    [self.downPULabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.noDataLabel.mas_bottom).offset(kScrAdaptationH(14));
        make.centerX.equalTo(self.noDataLabel);
        make.height.equalTo(@(kScrAdaptationH(15)));
    }];
}

- (CJLabel *)noDataLabel {
    if (!_noDataLabel) {
        _noDataLabel = [[CJLabel alloc] initWithFrame:CGRectZero];
        _noDataLabel.font = kHXBFont_PINGFANGSC_REGULAR(66);
        _noDataLabel.textColor = kHXBColor_Grey_Font0_2;
        _noDataLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview: _noDataLabel];
    }
    return _noDataLabel;
}
- (UILabel *)downPULabel {
    if (!_downPULabel) {
        _downPULabel = [[UILabel alloc]initWithFrame:CGRectZero];
        [self addSubview:_downPULabel];
        _downPULabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
        _downPULabel.textColor = kHXBColor_Font0_6;
        _noDataLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _downPULabel;
}

- (UIImageView *)notDataImageView {
    if (!_notDataImageView) {
        _notDataImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        [self addSubview:_notDataImageView];
        _notDataImageView.contentMode = UIViewContentModeScaleAspectFit;    
    }
    return _notDataImageView;
}
- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    self.notDataImageView.image = [UIImage imageNamed:self.imageName];
    if (!_notDataImageView.image) {
        _notDataImageView.image = [UIImage imageNamed: self.imageName];
    }
}
- (void)setNoDataMassage:(NSString *)noDataMassage {
    _noDataMassage = noDataMassage;
    NSDictionary *textAttributes = @{
                                     NSForegroundColorAttributeName:COR6,
                                     NSFontAttributeName:kHXBFont_PINGFANGSC_REGULAR(18)
                                     };
    NSDictionary *linkAttributes = @{
                                     NSForegroundColorAttributeName:kHXBColor_Blue040610,
                                     NSFontAttributeName:kHXBFont_PINGFANGSC_REGULAR(18)
                                     };
    NSAttributedString *message = [[NSAttributedString alloc] initWithString:noDataMassage attributes:textAttributes];
    NSMutableAttributedString *dataMessage = [CJLabel configureLinkAttributedString:message
                                                                         withString:@"立即获取"
                                                                   sameStringEnable:NO
                                                                     linkAttributes:linkAttributes
                                                               activeLinkAttributes:linkAttributes
                                                                          parameter:nil
                                                                     clickLinkBlock:^(CJLabelLinkModel *linkModel){
                                                                         if (_clickBlock) {
                                                                             _clickBlock();
                                                                         }
                                                                     }longPressBlock:nil];
    self.noDataLabel.text = dataMessage;
}

- (void)setDownPULLMassage:(NSString *)downPULLMassage {
    _downPULLMassage = downPULLMassage;
    self.downPULabel.text = downPULLMassage;
}
@end
