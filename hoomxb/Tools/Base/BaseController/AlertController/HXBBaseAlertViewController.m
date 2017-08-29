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
 Title
 */
@property (nonatomic,strong) UILabel *mainTitle;
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
@property (nonatomic,strong) UIView *containerView;
@property (nonatomic,strong) NSMutableArray *buttonArray;
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
        toView.center = [UIApplication sharedApplication].keyWindow.center;
        toView.bounds = CGRectMake(0, 0, kScrAdaptationW(295), kScrAdaptationH(145));
        weakSelf.animatr.isAccomplishAnima = true;
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
//    self.view.frame = CGRectMake(kScrAdaptationW(40), kScrAdaptationH(260), kScrAdaptationW(295), kScrAdaptationH(145));
    self.view.layer.cornerRadius = kScrAdaptationW(5);
    self.view.layer.masksToBounds = true;
    self.containerView = [[UIView alloc]init];
    [self.view addSubview:self.containerView];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.massageLabel).offset(kScrAdaptationH(-30));
        make.bottom.equalTo(self.rightButton).offset(kScrAdaptationH(30));
        make.left.right.equalTo(self.view);
        make.center.equalTo(self.view);
    }];
    
    [self.massageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containerView).offset(kScrAdaptationH(30));
        make.left.equalTo(self.containerView).offset(kScrAdaptationW(20));
        make.right.equalTo(self.containerView).offset(kScrAdaptationW(-20));
    }];
    
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kScrAdaptationW(20));
        make.top.equalTo(self.massageLabel.mas_bottom).offset(kScrAdaptationH(30));
//        make.height.equalTo(@(kScrAdaptationW(35)));
        make.width.offset(kScrAdaptationW(115));
        make.height.offset(kScrAdaptationH(35));
    }];
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(kScrAdaptationW(-20));
        make.centerY.equalTo(self.leftButton);
        make.height.width.equalTo(self.leftButton);
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
        _massageLabel.numberOfLines = 0;
        _massageLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_massageLabel];
    }
    return _massageLabel;
}
- (UIButton*)leftButton {
    if (!_leftButton) {
        _leftButton = [[UIButton alloc]init];
        _leftButton.layer.cornerRadius = kScrAdaptationW(4);
        _leftButton.layer.masksToBounds = YES;
        _leftButton.backgroundColor = COR29;
        [_leftButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _leftButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
        [self.view addSubview:_leftButton];
    }
    return _leftButton;
}
- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [[UIButton alloc]init];
       
        _rightButton.layer.cornerRadius = kScrAdaptationW(4);
        _rightButton.layer.masksToBounds = YES;
        _rightButton.layer.borderWidth =  kXYBorderWidth;
        _rightButton.layer.borderColor = COR29.CGColor;
        _rightButton.backgroundColor = [UIColor whiteColor];
        [_rightButton setTitleColor:COR29 forState:UIControlStateNormal];
        _rightButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
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

- (void)addButtonWithTitle:(NSString *)title andEvent:(void(^)(UIButton *button))eventBlock {
    UIButton *button = [[UIButton alloc]init];
    [self.containerView addSubview:button];
    [self.buttonArray addObject:button];
}
@end
