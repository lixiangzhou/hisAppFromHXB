//
//  HXBFin_Plan_BugFailViewController.m
//  hoomxb
//
//  Created by HXB on 2017/6/28.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_Plan_BugFailViewController.h"

@interface HXBFin_Plan_BugFailViewController ()
@property (nonatomic,strong) UILabel *failLabel;
@property (nonatomic,strong) UILabel *failMassageLabel;
@property (nonatomic,strong) UIButton *button;
@property (nonatomic,copy) void(^clickButtonBlcok)(UIButton *button);
@property (nonatomic,strong) UIImageView *imageView;
@end

@implementation HXBFin_Plan_BugFailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUPViews];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"<返回" style:UIBarButtonItemStylePlain target:self action:@selector(clickLeftBarButtonItem)];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    self.hxbBaseVCScrollView.backgroundColor = [UIColor whiteColor];
}

- (void)clickLeftBarButtonItem {
    [self.navigationController popToRootViewControllerAnimated:true];
}
- (void)setUPViews {
    [self creatViews];
}

- (void)creatViews {
    self.failLabel = [[UILabel alloc] init];
    self.failMassageLabel = [[UILabel alloc]init];
    self.button = [[UIButton alloc]init];
    self.imageView = [[UIImageView alloc]init];
    self.imageView.image = [UIImage imageNamed:self.image];
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.failMassageLabel];
    [self.view addSubview:self.failLabel];
    [self.view addSubview:self.button];
    
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.height.equalTo(@(kScrAdaptationH750(198)));
        make.width.equalTo(@(kScrAdaptationW750(310)));
        make.top.equalTo(self.view).offset(kScrAdaptationH(150));
    }];
    [self.failLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.height.equalTo(@(kScrAdaptationH(38)));
        make.top.equalTo(self.imageView.mas_bottom).offset(kScrAdaptationH(70));
    }];
    [self.failMassageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.failLabel.mas_bottom).offset(kScrAdaptationH(50));
        make.height.equalTo(self.failMassageLabel);
        make.centerX.equalTo(self.view);
    }];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.failMassageLabel.mas_bottom).offset(kScrAdaptationH(150));
        make.width.equalTo(@(kScrAdaptationW(150)));
        make.height.equalTo(@(kScrAdaptationH(50)));
    }];
    
    
    [self.failMassageLabel sizeToFit];
    [self.failLabel sizeToFit];
    
    self.failLabel.text = @"购买失败";
    self.button.backgroundColor = [UIColor blueColor];
    [self.button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)setMassage:(NSString *)massage {
    _massage = massage;
    self.failMassageLabel.text = massage;
}

- (void)setFailLabelStr:(NSString *)failLabelStr {
    _failLabelStr = failLabelStr;
    self.failLabel.text = failLabelStr;
}
- (void)setButtonStr:(NSString *)buttonStr {
    _buttonStr = buttonStr;
    [_button setTitle:buttonStr forState:UIControlStateNormal];
}
///购买 结果页 点击了充值按钮
- (void)clickButton : (UIButton *)button {
    if (_clickButtonBlcok) {
        _clickButtonBlcok(button);
    }
}
- (void)setImage:(NSString *)image{
    _image = image;
}
- (void)clickButtonWithBlcok:(void (^)(UIButton *))clickButtonBlcok {
    self.clickButtonBlcok = clickButtonBlcok;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
