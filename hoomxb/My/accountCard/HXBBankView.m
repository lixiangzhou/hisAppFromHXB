//
//  HXBBankView.m
//  hoomxb
//
//  Created by HXB-C on 2017/8/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBankView.h"
#import "HXBBankCardViewModel.h"

@interface HXBBankView ()

@property (nonatomic, strong) UIImageView *backImageView;

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *bankName;

@property (nonatomic, strong) UILabel *realName;

@property (nonatomic, strong) UILabel *bankNum;

@property (nonatomic, strong) UILabel *bankTip;


@property (nonatomic, strong) HXBBankCardViewModel *viewModel;

@end

@implementation HXBBankView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScrAdaptationW(345), kScrAdaptationH(170))];
        self.backImageView.image = [UIImage imageNamed:@"hxb_card_bg"];
        [self addSubview:self.backImageView];

        [self.backImageView addSubview:self.iconView];
        [self.backImageView addSubview:self.bankName];
        [self.backImageView addSubview:self.realName];
        [self.backImageView addSubview:self.bankNum];
        [self.backImageView addSubview:self.bankTip];
        [self setupSubViewFrame];
        [self loadBankData];
    }
    return self;
}

- (void)setupSubViewFrame
{
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kScrAdaptationW(30));
        make.top.equalTo(self).offset(kScrAdaptationH(20));
        make.width.offset(kScrAdaptationW(40));
        make.height.offset(kScrAdaptationW(40));
    }];
    [self.bankName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).offset(kScrAdaptationW(15));
        make.top.equalTo(self.iconView);
        make.height.offset(kScrAdaptationH(20));
    }];
    [self.realName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bankName.mas_left);
        make.top.equalTo(self.bankName.mas_bottom).offset(kScrAdaptationH(4));
        make.height.offset(kScrAdaptationH(16));
    }];
    [self.bankNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_left);
        make.right.equalTo(self).offset(-kScrAdaptationH(30));
        make.top.equalTo(self.iconView.mas_bottom).offset(kScrAdaptationH(20));
        make.height.offset(kScrAdaptationH(31));
    }];
    [self.bankTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_left);
        make.top.equalTo(self.bankNum.mas_bottom).offset(kScrAdaptationH(20));
        make.right.equalTo(self).offset(-kScrAdaptationH(30));
        make.height.offset(kScrAdaptationH(16));
    }];
}

- (void)loadBankData
{
    kWeakSelf
    [self.viewModel requestBankDataResultBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            //设置绑卡信息
            weakSelf.iconView.svgImageString = weakSelf.viewModel.bankCardModel.bankCode;
            weakSelf.bankName.text = weakSelf.viewModel.bankCardModel.bankType;
            weakSelf.realName.text = [NSString stringWithFormat:@"持卡人：%@",[weakSelf.viewModel.bankCardModel.name replaceStringWithStartLocation:0 lenght:weakSelf.viewModel.bankCardModel.name.length - 1]];
            if (weakSelf.viewModel.bankCardModel.name.length > 4) {
                weakSelf.realName.text = [NSString stringWithFormat:@"持卡人：***%@",[weakSelf.viewModel.bankCardModel.name substringFromIndex:weakSelf.viewModel.bankCardModel.name.length - 1]];
            }
            weakSelf.bankNum.textAlignment = NSTextAlignmentCenter;
            NSString *str = [weakSelf.viewModel.bankCardModel.cardId stringByReplacingOccurrencesOfString:[weakSelf.viewModel.bankCardModel.cardId substringWithRange:NSMakeRange(0,weakSelf.viewModel.bankCardModel.cardId.length - 4)]withString:@"****  ****  ****  "];
            NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
            [style setLineBreakMode:NSLineBreakByCharWrapping];
            NSDictionary *attribute = @{NSFontAttributeName: kHXBFont_PINGFANGSC_REGULAR(24),NSParagraphStyleAttributeName:style};
            CGSize size = [str boundingRectWithSize:CGSizeMake(weakSelf.bankNum.bounds.size.width, kScrAdaptationH(31)) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
            float width = weakSelf.bankNum.bounds.size.width - ceil(size.width);
            float space = width / (str.length-1);
            weakSelf.bankNum.text = str;
            [weakSelf changeWordSpaceForLabel:weakSelf.bankNum WithSpace:space];
            weakSelf.bankTip.text = weakSelf.viewModel.bankCardModel.quota;
            
            if (weakSelf.unbundBankBlock) {
                weakSelf.unbundBankBlock(weakSelf.viewModel.bankCardModel);
            }
        } 
    }];
}

- (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    NSString *labelText = label.text;
    if (labelText) {
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName:@(space)}];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
        label.attributedText = attributedString;
        [label sizeToFit];
    }
    
}

#pragma mark - 懒加载
- (HXBBankCardViewModel *)viewModel {
    if (!_viewModel) {
        kWeakSelf
        _viewModel = [[HXBBankCardViewModel alloc] initWithBlock:^UIView *{
            return weakSelf;
        }];
    }
    return _viewModel;
}

- (UIImageView *)iconView
{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconView;
}

- (UILabel *)bankName
{
    if (!_bankName) {
        _bankName = [[UILabel alloc] init];
        _bankName.font = kHXBFont_PINGFANGSC_REGULAR(15);
        _bankName.textColor = COR7;
    }
    return _bankName;
}

- (UILabel *)realName
{
    if (!_realName) {
        _realName = [[UILabel alloc] init];
        _realName.font = kHXBFont_PINGFANGSC_REGULAR(12);
        _realName.textColor = COR7;
    }
    return _realName;
}

- (UILabel *)bankNum
{
    if (!_bankNum) {
        _bankNum = [[UILabel alloc] init];
        _bankNum.font = kHXBFont_PINGFANGSC_REGULAR(24);
        _bankNum.numberOfLines = 1;
        _bankNum.textColor = COR29;
    }
    return _bankNum;
}

- (UILabel *)bankTip
{
    if (!_bankTip) {
        _bankTip = [[UILabel alloc] init];
        _bankTip.font = kHXBFont_PINGFANGSC_REGULAR(12);
        _bankTip.textColor = COR10;
    }
    return _bankTip;
}

@end
