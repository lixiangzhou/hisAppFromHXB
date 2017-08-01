//
//  HXBMY_Capital_Sift_ViewController.m
//  hoomxb
//
//  Created by HXB on 2017/6/28.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMY_Capital_Sift_ViewController.h"

@interface HXBMY_Capital_Sift_ViewController ()
/**
 点击了筛选的类型进行回调
 */
@property (nonatomic,copy) void(^clickCapital_TitleBlock)(NSString *typeStr,kHXBEnum_MY_CapitalRecord_Type type);
@property (nonatomic,copy) NSString *typeStr;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,strong) NSArray <NSString *>* buttonTitleArray;
@property (nonatomic,strong) UIButton *backButton;
@property (nonatomic,strong) UILabel *titleLabel;
@end

@implementation HXBMY_Capital_Sift_ViewController
- (void)clickCapital_TitleWithBlock:(void (^)(NSString *, kHXBEnum_MY_CapitalRecord_Type))clickCapital_TitleBlock {
    _clickCapital_TitleBlock = clickCapital_TitleBlock;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.isColourGradientNavigationBar = true;
    self.view.backgroundColor = kHXBColor_BackGround;
    self.titleLabel.text = @"交易记录";
    
    
    self.buttonTitleArray = @[
                              @"全部",
                              @"充值",
                              @"提现",
                              @"散标债权",
                              @"红利计划",
                              ];
    UIView *view = [[UIView alloc]init];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.height.equalTo(@(500));
        make.width.equalTo(self.view);
    }];
    NSArray <UIButton *>* buttonArray = [self creatButtonWithTitleArray:self.buttonTitleArray andButtonSuperView:view];
    [buttonArray mas_distributeViewsAlongAxis:MASAxisTypeVertical withFixedSpacing:kScrAdaptationH(5) leadSpacing:0 tailSpacing:0];
    [buttonArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(view);
    }];
}

/// 创建button
- (NSArray <UIButton *>*) creatButtonWithTitleArray: (NSArray <NSString *>*)titleArray andButtonSuperView:(UIView *)view{
    NSMutableArray <UIButton *>* buttonArray = [[NSMutableArray alloc]init];
    [titleArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *button = [[UIButton alloc]init];
        [buttonArray addObject:button];
        button.tag = idx;
        [button setTitleColor:kHXBColor_Grey_Font0_2 forState:UIControlStateNormal];
        [button setTitle:titleArray[idx] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickCapitalButton:) forControlEvents:UIControlEventTouchUpInside];
        button.backgroundColor = [UIColor whiteColor];
        [view addSubview:button];
    }];
    return buttonArray;
}


- (void)clickCapitalButton: (UIButton *)button {
    if (_clickCapital_TitleBlock) {
        _clickCapital_TitleBlock(button.titleLabel.text,button.tag);
    }
    [self dismissViewControllerAnimated:true completion:nil];
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = [UIColor whiteColor];
        [self.view addSubview:_titleLabel];
        _titleLabel.frame = CGRectMake(0, 0, kScreenWidth, 64);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}


- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [[UIButton alloc]init];
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.svgImageString = @"back.svg";
        [_backButton setImage:imageView.image forState:UIControlStateNormal];
    }
    return _backButton;
}
@end
