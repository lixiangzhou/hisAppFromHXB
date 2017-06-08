//
//  HXBHomePageAfterLoginView.m
//  HongXiaoBao
//
//  Created by HXB-C on 2016/11/15.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#import "HXBHomePageAfterLoginView.h"
@interface HXBHomePageAfterLoginView ()
@property (nonatomic, strong) UILabel *userTitleLabel;
//@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIButton *tipButton;
@property (nonatomic, strong) UILabel *profitLabel;
@property (nonatomic, strong) UIButton *selectEyeButton;
@property (nonatomic, strong) NSString *amountString;
@property (nonatomic, strong) NSString *profitString;

@end

@implementation HXBHomePageAfterLoginView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.userTitleLabel];
        [self addSubview:self.tipButton];
        [self addSubview:self.profitLabel];
        [self addSubview:self.selectEyeButton];
        [self setContentFrame];
        [self loadData];
    }
    return self;
}

- (void)setContentFrame{
    [self.userTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self).offset(HxbMarginBig + 10);
        make.right.equalTo(self);
        make.height.equalTo(@11);
    }];
    
//    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self);
//        make.bottom.equalTo(self).offset(-10);
//        make.right.equalTo(self);
//        make.height.equalTo(@25);
//    }];
    
    [self.tipButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-10);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(kScrAdaptationH(170), 25));
//        make.right.equalTo(self);
//        make.left.equalTo(self);
//        make.height.equalTo(@25);
//        make.width.equalTo(@90);
    }];
    
    [self.selectEyeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-8);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
}

- (void)selectEyeButtonClicked:(UIButton *)sender
{
    UIButton *button = (UIButton*)sender;
    button.selected = !button.selected;
    NSString * oldStr = _tipButton.titleLabel.text;
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (!sender.selected) {
//        _profitLabel.text = [NSString stringWithFormat:@"%.2f",[_profitModel.currentProfit doubleValue]];
        [defaults setBool:NO forKey:@"hideProfit"];
        
        [defaults synchronize];
    }else{
    
        [defaults setBool:YES forKey:@"hideProfit"];
        [defaults synchronize];
        NSString *string = [_tipButton.titleLabel.text substringWithRange:NSMakeRange(0,oldStr.length)];
        _tipButton.titleLabel.text = [oldStr stringByReplacingOccurrencesOfString:string withString:@"****"];
        //字符串的替换
        //        for (int i=0; i<oldStr.length; i++) {
        //            NSString * hideString = @"*";
        //            hideString = [hideString stringByAppendingString:@"%@",i*hideString];
        //         }
    }
}

/**
 认证的按钮的点击
 */
- (void)tipButtonClick
{
    if (self.tipButtonClickBlock) {
        self.tipButtonClickBlock();
    }
}

- (void)loadData{
    NSString *userName = @"5层安全防护保护资金安全";
//   _userTitleLabel.text = [NSString stringWithFormat:@"您好，%@",userName];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:userName];
    // 设置字体和设置字体的范围
    [attrStr addAttribute:NSFontAttributeName
                    value:[UIFont systemFontOfSize:30.0f]
                    range:NSMakeRange(0, 1)];
    _userTitleLabel.attributedText = attrStr;
    
}

- (void)setAmountString:(NSString *)amountString{
    _amountString = amountString;
    if (_amountString.length != 0) {
    _tipButton.titleLabel.text = amountString;
    }
}

- (void)setProfitAndAmountData{
    _amountString = @"3000.00";
}

- (void)setProfitString:(NSString *)profitString{
    _profitString = profitString;
}

- (void)setTipString:(NSString *)tipString{
    _tipString = tipString;
    [self.tipButton setTitle:tipString forState:UIControlStateNormal];
}

- (UILabel *)userTitleLabel{
    if (!_userTitleLabel) {
        _userTitleLabel = [[UILabel alloc]init];
        _userTitleLabel.textColor = COR10;
        _userTitleLabel.font = HXB_Text_Font(SIZ17);
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
        [_tipButton setTitleColor:COR7 forState:UIControlStateNormal];
        _tipButton.titleLabel.font =  [UIFont systemFontOfSize:14];
        _tipButton.layer.borderWidth = 1.0f;
        _tipButton.layer.borderColor = COR10.CGColor;
        _tipButton.backgroundColor = [UIColor whiteColor];
        [_tipButton addTarget:self action:@selector(tipButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tipButton;
}

- (UILabel *)profitLabel{
    if (!_profitLabel) {
        _profitLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_userTitleLabel.frame) + 5, SCREEN_WIDTH, 15)];
    }
    return _profitLabel;
}

- (UIButton *)selectEyeButton
{
    if (!_selectEyeButton) {
        _selectEyeButton = [[UIButton alloc]init];
        [_selectEyeButton setImage:[UIImage imageNamed:@"hoomEye_open"] forState:UIControlStateNormal];
        [_selectEyeButton setImage:[UIImage imageNamed:@"hoomEye_close"] forState:UIControlStateSelected];
        [_selectEyeButton addTarget:self action:@selector(selectEyeButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectEyeButton;
}


@end
