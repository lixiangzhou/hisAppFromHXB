//
//  HXBBaseAlertViewController.m
//  hoomxb
//
//  Created by HXB on 2017/7/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseAlertViewController.h"

@interface HXBBaseAlertViewController ()
@property (nonatomic,strong) Animatr *animatr;

@property (nonatomic,copy) NSString *massage;
@property (nonatomic,copy) NSString *leftButtonMassage;
@property (nonatomic,copy) NSString *rightButtonMassage;


/**
 massageLabel
 */
@property (nonatomic,strong) UILabel *massageLabel;
/**
 leftButton
 */
@property (nonatomic,strong) UIButton *leftButton;
/**
 rightButton
 */
@property (nonatomic,strong) UIButton *rightButton;
@end

@implementation HXBBaseAlertViewController
- (instancetype) init {
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self.animatr;
    }
    return self;
}
- (instancetype) initWithMassage:(NSString *)massage
            andLeftButtonMassage:(NSString *)leftButtonMassage
           andRightButtonMassage:(NSString *)rightButtonMassage {
    self = [[HXBBaseAlertViewController alloc]init];
    self.massage = massage;
    self.leftButtonMassage = leftButtonMassage;
    self.rightButtonMassage = rightButtonMassage;
    return self;
}
- (Animatr *)animatr {
    if (!_animatr) {
        _animatr = [Animatr animatrWithModalPresentationStyle:UIModalPresentationCustom];
    }
    return _animatr;
}
- (void)setUPAnimater{
    __weak typeof (self)weakSelf = self;
    [self.animatr presentAnimaWithBlock:^(UIViewController *toVC, UIViewController *fromeVC, UIView *toView, UIView *fromeView) {
        [UIView animateWithDuration:.0 animations:^{
            toView.center = [UIApplication sharedApplication].keyWindow.center;
            toView.bounds = CGRectMake(0, 0, kScrAdaptationW(295), kScrAdaptationH(145));
        } completion:^(BOOL finished) {
            weakSelf.animatr.isAccomplishAnima = true;
        }];
    }];
    [self.animatr dismissAnimaWithBlock:^(UIViewController *toVC, UIViewController *fromeVC, UIView *toView, UIView *fromeView) {
        [UIView animateWithDuration:0 animations:^{
            
        } completion:^(BOOL finished) {
            weakSelf.animatr.isAccomplishAnima = true;
        }];
    }];
    [self.animatr setupContainerViewWithBlock:^(UIView *containerView) {
        containerView.backgroundColor = [UIColor colorWithWhite:0 alpha:.6];
        UIButton *button = [[UIButton alloc]init];
        [containerView insertSubview:button atIndex:0];
        button.frame = containerView.bounds;
        [button addTarget:self action:@selector(clickContainerView:) forControlEvents:UIControlEventTouchUpInside];
    }];
}
- (void)clickContainerView : (UIButton *)button {
    [self dismissViewControllerAnimated:true completion:nil];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUPAnimater];
    [self setUPViewsFrame];
    [self setUPViews];
    [_rightButton addTarget:self  action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    [_leftButton addTarget:self  action:@selector(clickLeftButton:) forControlEvents:UIControlEventTouchUpInside];
}
- (void) setUPViews{
    self.massageLabel.text = self.massage;
    [self.leftButton setTitle:self.leftButtonMassage forState:UIControlStateNormal];
    [self.rightButton setTitle:self.rightButtonMassage forState:UIControlStateNormal];
    
}
- (void)setUPViewsFrame {
    self.view.frame = CGRectMake(kScrAdaptationW(40), kScrAdaptationH(260), kScrAdaptationW(295), kScrAdaptationH(145));
    self.view.layer.cornerRadius = kScrAdaptationW(5);
    self.view.layer.masksToBounds = true;
    
    [self.massageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kScrAdaptationH(30));
        make.left.equalTo(self.view).offset(kScrAdaptationW(20));
        make.right.equalTo(self.view).offset(kScrAdaptationW(-20));
        make.height.equalTo(@(kScrAdaptationH(20)));
    }];
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.massageLabel);
        make.top.equalTo(self.massageLabel.mas_bottom).offset(kScrAdaptationH(30));
        make.height.equalTo(@(kScrAdaptationW(35)));
        make.width.equalTo(@(kScrAdaptationW(115)));
    }];
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.massageLabel);
        make.top.width.height.equalTo(self.leftButton);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UILabel *)massageLabel {
    if (!_massageLabel) {
        _massageLabel = [[UILabel alloc]init];
        _massageLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
        _massageLabel.textColor = kHXBColor_Grey_Font0_2;
        [self.view addSubview:_massageLabel];
    }
    return _massageLabel;
}
- (UIButton*)leftButton {
    if (!_leftButton) {
        _leftButton = [[UIButton alloc]init];
        _leftButton.layer.cornerRadius = kScrAdaptationW(2.5);
        _leftButton.layer.masksToBounds = true;
        _leftButton.backgroundColor = HXBC_Red_Light;
        [_leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _leftButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(20);
        [self.view addSubview:_leftButton];
    }
    return _leftButton;
}
- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [[UIButton alloc]init];
       
        _rightButton.layer.cornerRadius = kScrAdaptationW(2.5);
        _rightButton.layer.masksToBounds = true;
        _rightButton.layer.borderWidth = kScrAdaptationW(1);
        _rightButton.layer.borderColor = HXBC_Red_Light.CGColor;
        _rightButton.backgroundColor = [UIColor whiteColor];
        [_rightButton setTitleColor:HXBC_Red_Light forState:UIControlStateNormal];
        _rightButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(20);
        [self.view addSubview:_rightButton];
    }
    return _rightButton;
}
- (void)clickLeftButton:(UIButton *)button {
    NSLog(@"点击了左边的button %@",self);
    [self dismissViewControllerAnimated:true completion:nil];
    if (self.clickLeftButtonBlock) {
        self.clickLeftButtonBlock();
    }
}
- (void)clickRightButton: (UIButton *)button {
    NSLog(@"点击了右边的button %@",self);
    [self dismissViewControllerAnimated:true completion:nil];
    if (self.clickRightButtonBlock) {
        self.clickRightButtonBlock();
    }
}
@end
