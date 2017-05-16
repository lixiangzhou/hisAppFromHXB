//
//  HXBHomePageAfterLoginView.m
//  HongXiaoBao
//
//  Created by HXB-C on 2016/11/15.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#import "HXBHomePageAfterLoginView.h"
@interface HXBHomePageAfterLoginView ()
@property (nonatomic,strong) UILabel * userTitleLabel;
@property (nonatomic,strong) UILabel * profitLabel;
@property (nonatomic,strong) UIButton * selectEyeButton;
@end

@implementation HXBHomePageAfterLoginView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.userTitleLabel];
        [self addSubview:self.profitLabel];
        [self addSubview:self.selectEyeButton];
        [self setContentFrame];
        [self loadData];
    }
    return self;
}

- (void)setContentFrame{
    [_userTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(16);
        make.width.equalTo(@(SCREEN_WIDTH/3));
        make.height.equalTo(@11);
    }];
    
    [_profitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(_userTitleLabel.mas_bottom).offset(10);
        make.width.equalTo(@(SCREEN_WIDTH-70));
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
    NSString * oldStr = _profitLabel.text;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if (!sender.selected) {
//        _profitLabel.text = [NSString stringWithFormat:@"%.2f",[_profitModel.currentProfit doubleValue]];
        [defaults setBool:NO forKey:@"hideProfit"];
        
        [defaults synchronize];
    }else{
    
        [defaults setBool:YES forKey:@"hideProfit"];
        [defaults synchronize];
        NSString *string = [_profitLabel.text substringWithRange:NSMakeRange(0,oldStr.length)];
        _profitLabel.text = [oldStr stringByReplacingOccurrencesOfString:string withString:@"****"];
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

- (UILabel *)userTitleLabel{
    if (!_userTitleLabel) {
        _userTitleLabel = [[UILabel alloc]init];
        _userTitleLabel.textColor = COR10;
        _userTitleLabel.font = HXB_Text_Font(SIZ16);
        _userTitleLabel.textAlignment = NSTextAlignmentCenter;
        _userTitleLabel.text = @"累计收益(元)";
    }
    
    return _userTitleLabel;
}

- (UILabel *)profitLabel{
    if (!_profitLabel) {
        _profitLabel = [[UILabel alloc]init];
        _profitLabel.textColor = COR7;
        _profitLabel.font = HXB_Text_Font(22);
        _profitLabel.textAlignment = NSTextAlignmentLeft;
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
