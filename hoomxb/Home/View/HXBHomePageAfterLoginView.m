//
//  HXBHomePageAfterLoginView.m
//  HongXiaoBao
//
//  Created by HXB-C on 2016/11/15.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#import "HXBHomePageAfterLoginView.h"
#import "HXB_XYTools.h"

@interface HXBHomePageAfterLoginView ()
@property (nonatomic, strong) UILabel *userTitleLabel;
@property (nonatomic, strong) UIButton *tipButton;
//@property (nonatomic, strong) UILabel *tipLabel;
//@property (nonatomic, strong) UILabel *profitLabel;
//@property (nonatomic, strong) UIButton *selectEyeButton;
//@property (nonatomic, strong) NSString *amountString;
//@property (nonatomic, strong) NSString *profitString;

@end

@implementation HXBHomePageAfterLoginView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.userTitleLabel];
        [self addSubview:self.tipButton];
//        [self addSubview:self.profitLabel];
//        [self addSubview:self.selectEyeButton];
        [self setContentFrame];
//        [self loadData];
    }
    return self;
}

- (void)setContentFrame{
    [self.userTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(@kScrAdaptationH(55));
    }];
}

//- (void)selectEyeButtonClicked:(UIButton *)sender
//{
//    UIButton *button = (UIButton*)sender;
//    button.selected = !button.selected;
//    NSString * oldStr = _tipButton.titleLabel.text;
//    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//    if (!sender.selected) {
////        _profitLabel.text = [NSString stringWithFormat:@"%.2f",[_profitModel.currentProfit doubleValue]];
//        [defaults setBool:NO forKey:@"hideProfit"];
//        
//        [defaults synchronize];
//    }else{
//    
//        [defaults setBool:YES forKey:@"hideProfit"];
//        [defaults synchronize];
//        NSString *string = [_tipButton.titleLabel.text substringWithRange:NSMakeRange(0,oldStr.length)];
//        _tipButton.titleLabel.text = [oldStr stringByReplacingOccurrencesOfString:string withString:@"****"];
//        //字符串的替换
//        //        for (int i=0; i<oldStr.length; i++) {
//        //            NSString * hideString = @"*";
//        //            hideString = [hideString stringByAppendingString:@"%@",i*hideString];
//        //         }
//    }
//}

/**
 认证的按钮的点击
 */
- (void)tipButtonClick
{
    if (self.tipButtonClickBlock_homePageAfterLoginView) {
        self.tipButtonClickBlock_homePageAfterLoginView();
    }
}

//- (void)loadData{
////    NSString *userName = @"5层安全防护保护资金安全";
//////   _userTitleLabel.text = [NSString stringWithFormat:@"您好，%@",userName];
////    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:userName];
////    // 设置字体和设置字体的范围
////    [attrStr addAttribute:NSFontAttributeName
////                    value:[UIFont systemFontOfSize:30.0f]
////                    range:NSMakeRange(0, 1)];
////    _userTitleLabel.attributedText = attrStr;
//    self.userTitleLabel.text = self.headTipString;;
//    
//}

- (void)setHeadTipString:(NSString *)headTipString {
    _headTipString = headTipString;
    self.userTitleLabel.text = self.headTipString;;
}

- (void)setTipString:(NSString *)tipString{
    _tipString = tipString;
    [self.tipButton setTitle:tipString forState:UIControlStateNormal];
    CGFloat width = [[HXB_XYTools shareHandle] WidthWithString:_tipString labelFont:kHXBFont_PINGFANGSC_REGULAR(17) addWidth:30];
    self.tipButton.frame = CGRectMake(kScreenWidth / 2 - kScrAdaptationW(width) / 2, kScrAdaptationH(86), kScrAdaptationW(width), kScrAdaptationH(30));
}

//- (void)setAmountString:(NSString *)amountString{
//    _amountString = amountString;
//    if (_amountString.length != 0) {
//    _tipButton.titleLabel.text = amountString;
//    }
//}

//- (void)setProfitAndAmountData{
//    _amountString = @"3000.00";
//}

//- (void)setProfitString:(NSString *)profitString{
//    _profitString = profitString;
//}


- (UILabel *)userTitleLabel{
    if (!_userTitleLabel) {
        _userTitleLabel = [[UILabel alloc]init];
        _userTitleLabel.textColor = COR15;
        _userTitleLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
        _userTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _userTitleLabel;
}

//- (UILabel *)tipLabel{
//    if (!_tipLabel) {
//        _tipLabel = [[UILabel alloc]init];
//        _tipLabel.textColor = COR7;
//        _tipLabel.font = HXB_Text_Font(22);
//        _tipLabel.textAlignment = NSTextAlignmentCenter;
//    }
//    return _tipLabel;
//}

- (UIButton *)tipButton
{
    if (!_tipButton) {
        _tipButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _tipButton.frame = CGRectMake(0, 86, 10, 10);
        _tipButton.layer.borderColor = [UIColor whiteColor].CGColor;
        _tipButton.layer.borderWidth = kXYBorderWidth;
        _tipButton.layer.cornerRadius = kScrAdaptationH(15.0f);
        [_tipButton setTitleColor:COR15 forState:UIControlStateNormal];
        _tipButton.titleLabel.font =  kHXBFont_PINGFANGSC_REGULAR(17);
        _tipButton.backgroundColor = [UIColor colorWithWhite:1.0f alpha:0.07];
        [_tipButton addTarget:self action:@selector(tipButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tipButton;
}

//- (UILabel *)profitLabel{
//    if (!_profitLabel) {
//        _profitLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_userTitleLabel.frame) + 5, SCREEN_WIDTH, 15)];
//    }
//    return _profitLabel;
//}




@end
