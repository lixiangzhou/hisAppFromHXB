//
//  HXBAgreementView.m
//  hoomxb
//
//  Created by HXB-C on 2017/8/4.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBAgreementView.h"
#import "CJLabel.h"
@interface HXBAgreementView ()

@property (nonatomic, strong) UIButton *agreeBtn;

@property (nonatomic, strong) CJLabel *negotiateView;

/**
 需要添加点击事件的富文本
 */
@property (nonatomic, copy) NSMutableAttributedString *attributedString;

@end

@implementation HXBAgreementView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.agreeBtn];
        [self addSubview:self.negotiateView];
        [self setupSubViewFrame];
    }
    return self;
}

- (void)setupSubViewFrame
{
    [self.agreeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(2);
        make.width.height.offset(kScrAdaptationW(12));
    }];
    [self.negotiateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.agreeBtn.mas_right).offset(kScrAdaptationW(7));
        make.top.equalTo(self);
        make.right.equalTo(self);
    }];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.negotiateView.mas_top);
        make.bottom.equalTo(self.negotiateView.mas_bottom);
    }];
}

+ (NSMutableAttributedString *)configureLinkAttributedString:(NSAttributedString *)attrStr
                                                  withString:(NSString *)withString
                                            sameStringEnable:(BOOL)sameStringEnable
                                              linkAttributes:(NSDictionary *)linkAttributes
                                        activeLinkAttributes:(NSDictionary *)activeLinkAttributes
                                                   parameter:(id)parameter
                                              clickLinkBlock:(void(^)())clickLinkBlock
{
    NSMutableAttributedString *attributedString = [CJLabel configureLinkAttributedString:attrStr
                                withString:withString
                          sameStringEnable:sameStringEnable
                            linkAttributes:linkAttributes
                      activeLinkAttributes:activeLinkAttributes
                                 parameter:parameter
                            clickLinkBlock:^(CJLabelLinkModel *linkModel){
                                //点击事件
                                clickLinkBlock();
                            }longPressBlock:^(CJLabelLinkModel *linkModel){
                                //点击事件
                                clickLinkBlock();
                            }];
    return attributedString;
}


- (void)setText:(id)text
{
    _text = text;
    self.negotiateView.text = text;
}

#pragma mark - 懒加载
- (UIButton *)agreeBtn
{
    if (!_agreeBtn) {
        _agreeBtn = [[UIButton alloc] init];
        _agreeBtn.backgroundColor = [UIColor whiteColor];
//        _agreeBtn.layer.borderColor = COR10.CGColor;
//        _agreeBtn.layer.borderWidth = kXYBorderWidth;
//        _agreeBtn.layer.cornerRadius = kScrAdaptationW(3);
//        _agreeBtn.layer.masksToBounds = YES;
        _agreeBtn.selected = YES;
        _agreeBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [_agreeBtn setImage:[UIImage imageNamed:@"duigou"] forState:UIControlStateSelected];
        [_agreeBtn setImage:[UIImage imageNamed:@"Rectangle"] forState:(UIControlStateNormal)];
        [_agreeBtn addTarget:self action:@selector(agreeBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _agreeBtn;
}

- (void)agreeBtnClick
{
    self.agreeBtn.selected = !self.agreeBtn.selected;
    if (self.agreeBtnBlock) {
        self.agreeBtnBlock(self.agreeBtn.selected);
    }
}

- (CJLabel *)negotiateView
{
    if (!_negotiateView) {
        _negotiateView = [[CJLabel alloc] initWithFrame:CGRectZero];
        _negotiateView.numberOfLines = 0;
    }
    return _negotiateView;
}

@end
