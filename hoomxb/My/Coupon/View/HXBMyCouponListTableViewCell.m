//
//  HXBMyCouponListTableViewCell.m
//  hoomxb
//
//  Created by hxb on 2017/10/31.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMyCouponListTableViewCell.h"
#import "HXBMyCouponListModel.h"

@interface HXBMyCouponListTableViewCell()

@property (nonatomic, strong)  UIImageView *mainView;
@property (nonatomic, strong)  UIImageView *leftImgV;//左
@property (nonatomic, strong)  UILabel *dicountRateLab;//折扣率或者满减券多少元 "3%" “6666元”
@property (nonatomic, strong)  UILabel *allowDerateInvestLab;//“最高6666元” “满5000元使用”
@property (nonatomic, strong)  UIImageView *leftLineImgV;
@property (nonatomic, strong)  UIImageView *midBgImgV;
@property (nonatomic, strong)  UILabel *couponTypeLab; //‘抵扣券"
@property (nonatomic, strong)  UILabel *tagLab;//"贺岁大礼包"
@property (nonatomic, strong)  UILabel *termOfValidityLab;//"有效期至2017/11/30"
@property (nonatomic, strong)  UILabel *allowBusinessCategoryLab;//"散标 债转 红利计划（1/3/6/9）"
@property (nonatomic, strong)  UIImageView *rightLineImgV;
@property (nonatomic, strong)  UIImageView *rightImgV;
@property (nonatomic, strong)  UIButton *actionBtn;//"立即使用"
//@property (nonatomic, copy)    NSString *couponTypeText;

@end

@implementation HXBMyCouponListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = RGBA(244, 243, 248, 1);
        [self.contentView addSubview:self.mainView];
        [self setupSubViewFrame];
    }
    return self;
}

- (void)clickActionBtn{
    if (self.actionButtonClickBlock) {
        self.actionButtonClickBlock();
    }
}

- (void)setMyCouponListModel:(HXBMyCouponListModel *)myCouponListModel{
    _myCouponListModel = myCouponListModel;
    self.couponTypeLab.text = myCouponListModel.couponTypeText;; //‘抵扣券"还是“满减券”
    
    if ([self.couponTypeLab.text isEqualToString:@"抵扣券"]) { //判断折扣还是满减
        self.leftImgV.image = [UIImage imageNamed:@"my_couponList_dicountRateleft"];
        self.dicountRateLab.textColor = RGBA(253, 54, 54, 1);
        self.dicountRateLab.font = kHXBFont_PINGFANGSC_REGULAR_750(32);
        NSString *dicountRate = [NSString stringWithFormat:@"%@%%",myCouponListModel.dicountRate];
        NSRange range = NSMakeRange(0,dicountRate.length - 1);
        UIFont *font = kHXBFont_PINGFANGSC_REGULAR_750(58);
        NSMutableAttributedString *attrM = [NSAttributedString setupAttributeStringWithString:dicountRate WithRange:range andAttributeColor:RGBA(253, 54, 54, 1) andAttributeFont:font];
        self.dicountRateLab.attributedText = attrM;
        
        if (myCouponListModel.maxDiscountAmount && ![myCouponListModel.maxDiscountAmount isEqualToString:@""]) {
            self.allowDerateInvestLab.text = [NSString stringWithFormat:@"最高%@元",myCouponListModel.maxDiscountAmount];//“最高6666元” “满5000元使用”
            self.allowDerateInvestLab.textColor = RGBA(253, 54, 54, 1);
        }else{
            self.allowDerateInvestLab.text = @"";
        }
        
        if (myCouponListModel.forProductLimit && ([myCouponListModel.forProductLimit containsString:@"("] || [myCouponListModel.forProductLimit containsString:@"（"])) {
            NSString *str = [NSString stringWithFormat:@"%@  %@",myCouponListModel.forProductText,myCouponListModel.forProductLimit];
            NSRange range;
            if ([myCouponListModel.allowBusinessCategory containsString:@"("]) {
                range = [str rangeOfString:@"("];
            }else{
                range = [str rangeOfString:@"（"];
            }
            UIFont *font = kHXBFont_PINGFANGSC_REGULAR_750(24);
            self.allowBusinessCategoryLab.textColor = RGBA(153, 153, 153, 1);
            NSRange rangeBef = NSMakeRange(0,str.length - myCouponListModel.forProductLimit.length);
            NSMutableAttributedString *attrM = [NSAttributedString setupAttributeStringWithString:str WithRange:rangeBef andAttributeColor:RGBA(253, 54, 54, 1) andAttributeFont:font];
            self.allowBusinessCategoryLab.attributedText = attrM;
        }else{
            self.allowBusinessCategoryLab.text = myCouponListModel.forProductText;
            self.allowBusinessCategoryLab.textColor = RGBA(253, 54, 54, 1);
        }
        
        [_actionBtn setTitleColor:RGBA(253, 54, 54, 1) forState:UIControlStateNormal];
        
        [self.allowDerateInvestLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftImgV).offset(kScrAdaptationW750(18));
            make.width.equalTo(@kScrAdaptationW750(180));
            make.top.equalTo(self.dicountRateLab.mas_bottom).offset(kScrAdaptationH750(20));
            make.height.equalTo(@kScrAdaptationH750(22));
        }];
    }else if([self.couponTypeLab.text isEqualToString:@"满减券"]){
        self.leftImgV.image = [UIImage imageNamed:@"my_couponList_ allowDerateInvestleft"];
        
        self.dicountRateLab.textColor = RGBA(115, 173, 255, 1);
        self.dicountRateLab.font = kHXBFont_PINGFANGSC_REGULAR_750(32);
        NSRange range1 = [myCouponListModel.derateAmount rangeOfString:@"."];
        NSString *dicountRate = [NSString stringWithFormat:@"%@元",[myCouponListModel.derateAmount substringToIndex:range1.location]];
        NSRange range = NSMakeRange(0,dicountRate.length - 1);
        UIFont *font = kHXBFont_PINGFANGSC_REGULAR_750(60);
        NSMutableAttributedString *attrM = [NSAttributedString setupAttributeStringWithString:dicountRate WithRange:range andAttributeColor:RGBA(115, 173, 255, 1) andAttributeFont:font];
        self.dicountRateLab.attributedText = attrM;
        
        if (myCouponListModel.allowDerateInvest && ![myCouponListModel.allowDerateInvest isEqualToString:@""]) {
            NSRange range = [myCouponListModel.allowDerateInvest rangeOfString:@"."];
            self.allowDerateInvestLab.text = [NSString stringWithFormat:@"满%@元使用",[myCouponListModel.allowDerateInvest substringToIndex:range.location]];//“最高6666元” “满5000元使用”
            self.allowDerateInvestLab.textColor = RGBA(115, 173, 255, 1);
        }else{
            self.allowDerateInvestLab.text = @"";
        }
        
        if (myCouponListModel.forProductLimit && ([myCouponListModel.forProductLimit containsString:@"("] || [myCouponListModel.forProductLimit containsString:@"（"])) {
            NSString *str = [NSString stringWithFormat:@"%@  %@",myCouponListModel.forProductText,myCouponListModel.forProductLimit];
            NSRange range;
            if ([myCouponListModel.allowBusinessCategory containsString:@"("]) {
                range = [str rangeOfString:@"("];
            }else{
                range = [str rangeOfString:@"（"];
            }
            UIFont *font = kHXBFont_PINGFANGSC_REGULAR_750(24);
            self.allowBusinessCategoryLab.textColor = RGBA(153, 153, 153, 1);
            NSRange rangeBef = NSMakeRange(0,str.length - myCouponListModel.forProductLimit.length);
            NSMutableAttributedString *attrM = [NSAttributedString setupAttributeStringWithString:str WithRange:rangeBef andAttributeColor:RGBA(115, 173, 255, 1) andAttributeFont:font];
            self.allowBusinessCategoryLab.attributedText = attrM;
        }else{
            self.allowBusinessCategoryLab.text = myCouponListModel.forProductText;
            self.allowBusinessCategoryLab.textColor = RGBA(115, 173, 255, 1);
        }
        
        [_actionBtn setTitleColor:RGBA(115, 173, 255, 1) forState:UIControlStateNormal];
        
        [self.allowDerateInvestLab mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftImgV).offset(kScrAdaptationW750(18));
            make.width.equalTo(@kScrAdaptationW750(180));
            make.top.equalTo(self.dicountRateLab.mas_bottom).offset(kScrAdaptationH750(11));
            make.height.equalTo(@kScrAdaptationH750(22));
        }];
    }else{
        self.leftImgV.image = [UIImage imageNamed:@"my_couponList_dicountRateleftDef"];
        self.dicountRateLab.text = @"";
        self.allowDerateInvestLab.text = @"";
        self.couponTypeLab.text = @"";
        self.tagLab.text = @"";
        self.termOfValidityLab.text = @"";
        self.allowBusinessCategoryLab.text = @"";
        [self.actionBtn setTitle:@"" forState:UIControlStateNormal];
    }
    if (myCouponListModel.tag) {
        self.tagLab.text = [NSString stringWithFormat:@"(%@)",myCouponListModel.tag];//"(贺岁大礼包)"
    }
    
    //时间戳转化成时间
    NSDateFormatter *stampFormatter = [[NSDateFormatter alloc] init];
    [stampFormatter setDateFormat:@"YYYY/MM/dd"];
    //以 1970/01/01 GMT为基准，然后过了secs秒的时间
    NSDate *stampDate = [NSDate dateWithTimeIntervalSince1970:myCouponListModel.expireTime / 1000];
    self.termOfValidityLab.text = [NSString stringWithFormat:@"有效期至%@",[stampFormatter stringFromDate:stampDate]];//"有效期至2017/11/30"
}

- (void)setupSubViewFrame
{
    [self.mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(kScrAdaptationW750(30));
        make.width.equalTo(@kScrAdaptationW750(750-60));
        make.top.equalTo(self.contentView).offset(kScrAdaptationH750(15));
        make.height.equalTo(@kScrAdaptationH750(240));
    }];
    [self.leftImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.mainView);
        make.width.equalTo(@kScrAdaptationW750(212));
    }];
    [self.dicountRateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImgV).offset(kScrAdaptationW750(18));
        make.width.equalTo(@kScrAdaptationW750(180));
        make.top.equalTo(self.leftImgV).offset(kScrAdaptationH750(62));
        make.height.equalTo(@kScrAdaptationH750(84));
    }];
    [self.allowDerateInvestLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.leftImgV).offset(kScrAdaptationW750(18));
        make.width.equalTo(@kScrAdaptationW750(180));
        make.top.equalTo(self.dicountRateLab.mas_bottom).offset(kScrAdaptationH750(11));
        make.height.equalTo(@kScrAdaptationH750(22));
    }];
    [self.leftLineImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@kScrAdaptationW750(212));
        make.width.equalTo(@kScrAdaptationW750(2));
        make.top.equalTo(@kScrAdaptationH750(14));
        make.height.equalTo(@kScrAdaptationH750(212));
    }];
    [self.midBgImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@kScrAdaptationW750(212));
        make.top.equalTo(@kScrAdaptationH750(0));
        make.width.equalTo(@kScrAdaptationW750(392));
        make.height.equalTo(@kScrAdaptationH750(240));
    }];
    [self.couponTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@kScrAdaptationW750(40));
        make.width.equalTo(@kScrAdaptationW750(100));
        make.top.equalTo(@kScrAdaptationH750(40));
        make.height.equalTo(@kScrAdaptationH750(34));
    }];
    [self.tagLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@kScrAdaptationW750(140));
        make.width.equalTo(@kScrAdaptationW750(200));
        make.top.equalTo(@kScrAdaptationH750(40));
        make.height.equalTo(@kScrAdaptationH750(34));
    }];
    [self.termOfValidityLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@kScrAdaptationW750(40));
        make.width.equalTo(@kScrAdaptationW750(300));
        make.top.equalTo(@kScrAdaptationH750(104));
        make.height.equalTo(@kScrAdaptationH750(32));
    }];
    [self.allowBusinessCategoryLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@kScrAdaptationW750(40));
        make.width.equalTo(@kScrAdaptationW750(300));
        make.top.equalTo(@kScrAdaptationH750(136));
        make.height.equalTo(@kScrAdaptationH750(64));
    }];
    [self.rightLineImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@kScrAdaptationW750(606));
        make.width.equalTo(@kScrAdaptationW750(2));
        make.top.equalTo(@kScrAdaptationH750(0));
        make.height.equalTo(@kScrAdaptationH750(240));
    }];
    [self.rightImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@kScrAdaptationW750(604));
        make.width.equalTo(@kScrAdaptationW750(84));
        make.top.equalTo(@kScrAdaptationH750(0));
        make.height.equalTo(@kScrAdaptationH750(240));
    }];
    [self.actionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.top.equalTo(self.rightImgV);
    }];
}

- (UIView *)mainView{
    if (!_mainView) {
        _mainView = [[UIImageView alloc]initWithFrame:CGRectMake(kScrAdaptationW750(30), 15, kScrAdaptationW750(690), kScrAdaptationH750(240))];
        _mainView.backgroundColor = RGBA(244, 243, 248, 1);
        _mainView.userInteractionEnabled = YES;
        [_mainView addSubview:self.leftImgV];
        [_mainView addSubview:self.midBgImgV];
        [_mainView addSubview:self.rightImgV];
        [_mainView addSubview:self.leftLineImgV];
        [_mainView addSubview:self.rightLineImgV];
    }
    return _mainView;
}

- (UIButton *)actionBtn{
    if (!_actionBtn) {
        _actionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _actionBtn.frame = _rightImgV.bounds;
        [_actionBtn.titleLabel setFont:kHXBFont_PINGFANGSC_REGULAR_750(24)];
         _actionBtn.titleLabel.numberOfLines = 0;
        [_actionBtn setTitle:@"立\n即\n使\n用" forState:UIControlStateNormal];
        [_actionBtn setTitleColor:RGBA(153, 153, 153, 1) forState:UIControlStateHighlighted];
        _actionBtn.userInteractionEnabled = YES;
        [_actionBtn addTarget:self action:@selector(clickActionBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _actionBtn;
}

- (UIImageView *)rightImgV{
    if (!_rightImgV) {
        _rightImgV = [[UIImageView alloc]initWithFrame:CGRectMake(kScrAdaptationW750(606), 0, kScrAdaptationW750(82), kScrAdaptationH750(240))];
        _rightImgV.userInteractionEnabled = YES;
        _rightImgV.image = [UIImage imageNamed:@"my_couponList_rightbg"];
        [_rightImgV addSubview:self.actionBtn];
    }
    return _rightImgV;
}

- (UIImageView *)rightLineImgV{
    if (!_rightLineImgV) {
        _rightLineImgV = [[UIImageView alloc]initWithFrame:CGRectMake(kScrAdaptationW750(606), kScrAdaptationH750(0), kScrAdaptationW750(2), kScrAdaptationH750(240))];
        _rightLineImgV.image = [UIImageView imageWithVerticalLineWithImageView:_rightLineImgV];
        _rightLineImgV.backgroundColor = [UIColor whiteColor];
    }
    return _rightLineImgV;
}

- (UILabel *)couponTypeLab{
    if (!_couponTypeLab) {
        _couponTypeLab = [[UILabel alloc]initWithFrame:CGRectMake(kScrAdaptationW750(40), kScrAdaptationH750(40), kScrAdaptationW750(100), kScrAdaptationH750(34))];
        _couponTypeLab.textAlignment = NSTextAlignmentLeft;
        _couponTypeLab.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
        _couponTypeLab.textColor = RGBA(21, 21, 21, 1);
    }
    return _couponTypeLab;
}

- (UILabel *)tagLab{
    if (!_tagLab) {
        _tagLab = [[UILabel alloc]initWithFrame:CGRectMake(kScrAdaptationW750(140), kScrAdaptationH750(40), kScrAdaptationW750(200), kScrAdaptationH750(34))];
        _tagLab.textAlignment = NSTextAlignmentLeft;
        _tagLab.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
        _tagLab.textColor = RGBA(21, 21, 21, 1);
    }
    return _tagLab;
}

- (UILabel *)termOfValidityLab{
    if (!_termOfValidityLab) {
        _termOfValidityLab = [[UILabel alloc]initWithFrame:CGRectMake(kScrAdaptationW750(40), kScrAdaptationH750(94), kScrAdaptationW750(300), kScrAdaptationH750(32))];
        _termOfValidityLab.textAlignment = NSTextAlignmentLeft;
        _termOfValidityLab.textColor = RGBA(153, 153, 153, 1);
        _termOfValidityLab.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
    }
    return _termOfValidityLab;
}

- (UILabel *)allowBusinessCategoryLab{
    if (!_allowBusinessCategoryLab) {
        _allowBusinessCategoryLab = [[UILabel alloc]initWithFrame:CGRectMake(kScrAdaptationW750(40), kScrAdaptationH750(136), kScrAdaptationW750(300), kScrAdaptationH750(64))];
        _allowBusinessCategoryLab.numberOfLines = 0;
        _allowBusinessCategoryLab.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
    }
    return _allowBusinessCategoryLab;
}

-(UIImageView *)midBgImgV{
    if (!_midBgImgV) {
        _midBgImgV = [[UIImageView alloc]initWithFrame:CGRectMake(kScrAdaptationW750(214), kScrAdaptationH750(0), kScrAdaptationW750(390), kScrAdaptationH750(240))];
        _midBgImgV.image = [UIImage imageNamed:@"my_couponList_mid"];
        [_midBgImgV addSubview:self.couponTypeLab];
        [_midBgImgV addSubview:self.tagLab];
        [_midBgImgV addSubview:self.termOfValidityLab];
        [_midBgImgV addSubview:self.allowBusinessCategoryLab];
    }
    return _midBgImgV;
}

- (UIImageView *)leftLineImgV{
    if (!_leftLineImgV) {
        _leftLineImgV = [[UIImageView alloc]initWithFrame:CGRectMake(kScrAdaptationW750(212), kScrAdaptationH750(14), kScrAdaptationW750(2), kScrAdaptationH750(212))];
        _leftLineImgV.image = [UIImageView imageWithVerticalLineWithImageView:_leftLineImgV];
    }
    return _leftLineImgV;
}

- (UILabel *)allowDerateInvestLab{
    if (!_allowDerateInvestLab) {
        _allowDerateInvestLab = [[UILabel alloc]initWithFrame:CGRectMake(kScrAdaptationW750(28), kScrAdaptationH750(157), kScrAdaptationW750(160), kScrAdaptationH750(22))];
        _allowDerateInvestLab.textAlignment = NSTextAlignmentCenter;
        _allowDerateInvestLab.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
    }
    return _allowDerateInvestLab;
}

- (UILabel *)dicountRateLab{
    if (!_dicountRateLab) {
        _dicountRateLab = [[UILabel alloc]initWithFrame:CGRectMake(kScrAdaptationW750(18), kScrAdaptationH750(62), kScrAdaptationW750(176), kScrAdaptationH750(84))];
        _dicountRateLab.textAlignment = NSTextAlignmentCenter;
    }
    return _dicountRateLab;
}

- (UIImageView *)leftImgV{
    if (!_leftImgV) {
        _leftImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScrAdaptationW750(212), kScrAdaptationW750(240))];
        _leftImgV.image = [UIImage imageNamed:@"my_couponList_dicountRateleftDef"];
        [_leftImgV addSubview:self.dicountRateLab];
        [_leftImgV addSubview:self.allowDerateInvestLab];
    }
    return _leftImgV;
}

@end
