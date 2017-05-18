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
@property (nonatomic, strong) UILabel *tipLabel;
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
        [self addSubview:self.tipLabel];
        [self addSubview:self.profitLabel];
        [self addSubview:self.selectEyeButton];
        [self setContentFrame];
        [self loadData];
    }
    return self;
}

- (void)setContentFrame{
    [_userTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.top.equalTo(self).offset(HxbMarginBig + 10);
        make.right.equalTo(self);
        make.height.equalTo(@11);
    }];
    
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.bottom.equalTo(self).offset(-10);
        make.right.equalTo(self);
        make.height.equalTo(@25);
    }];
    
    [_selectEyeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-8);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
}

- (void)selectEyeButtonClicked:(UIButton *)sender
{
    UIButton *button = (UIButton*)sender;
    button.selected = !button.selected;
    NSString * oldStr = _tipLabel.text;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (!sender.selected) {
//        _profitLabel.text = [NSString stringWithFormat:@"%.2f",[_profitModel.currentProfit doubleValue]];
        [defaults setBool:NO forKey:@"hideProfit"];
        
        [defaults synchronize];
    }else{
    
        [defaults setBool:YES forKey:@"hideProfit"];
        [defaults synchronize];
        NSString *string = [_tipLabel.text substringWithRange:NSMakeRange(0,oldStr.length)];
        _tipLabel.text = [oldStr stringByReplacingOccurrencesOfString:string withString:@"****"];
        //字符串的替换
        //        for (int i=0; i<oldStr.length; i++) {
        //            NSString * hideString = @"*";
        //            hideString = [hideString stringByAppendingString:@"%@",i*hideString];
        //         }
    }
}

- (void)loadData{
    NSString *userName = @"hxb0001";
   _userTitleLabel.text = [NSString stringWithFormat:@"您好，%@",userName];
}

- (void)setAmountString:(NSString *)amountString{
    _amountString = amountString;
    if (_amountString.length != 0) {
    _tipLabel.text = amountString;
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
    _tipLabel.text = tipString;
}

- (UILabel *)userTitleLabel{
    if (!_userTitleLabel) {
        _userTitleLabel = [[UILabel alloc]init];
        _userTitleLabel.textColor = COR10;
        _userTitleLabel.font = HXB_Text_Font(SIZ16);
        _userTitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return _userTitleLabel;
}

- (UILabel *)tipLabel{
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc]init];
        _tipLabel.textColor = COR7;
        _tipLabel.font = HXB_Text_Font(22);
        _tipLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLabel;
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