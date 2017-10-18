//
//  HXBXYAlertViewController.m
//  hoomxb
//
//  Created by HXB on 2017/8/25.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBXYAlertViewController.h"

@interface HXBXYAlertViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) Animatr *animatr;
@property (nonatomic,copy) NSString *titleAlert;
@property (nonatomic,assign) int force;
@property (nonatomic,copy) NSString *massage;
@property (nonatomic,copy) NSString *leftButtonMassage;
@property (nonatomic,copy) NSString *rightButtonMassage;

/**
 Title
 */
@property (nonatomic,strong) UILabel *mainTitle;

/**
 massageTextView
 */
@property (nonatomic,strong) UITextView *massageTextView;

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

@implementation HXBXYAlertViewController

- (instancetype) init {
    if (self = [super init]) {
        self.modalPresentationStyle = UIModalPresentationCustom;
        self.transitioningDelegate = self.animatr;
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title
                      Massage:(NSString *)massage
                        force:(int)force
         andLeftButtonMassage:(NSString *)leftButtonMassage
        andRightButtonMassage:(NSString *)rightButtonMassage {
    self = [[HXBXYAlertViewController alloc]init];
    
    self.titleAlert = title;
    self.massage = massage;
    self.force = force;
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
- (void)clickContainerView : (UIButton *)button {
//    [self dismissViewControllerAnimated:true completion:nil];
}

- (void)setUPAnimater{
//    __weak typeof (self)weakSelf = self;
    
    [self.animatr presentAnimaWithBlock:^(UIViewController *toVC, UIViewController *fromeVC, UIView *toView, UIView *fromeView) {
        toView.center = [UIApplication sharedApplication].keyWindow.center;
        toView.bounds = CGRectMake(0, 0, kScrAdaptationW(295), kScrAdaptationH(_messageHeight + 105));
        self.animatr.isAccomplishAnima = true;
    }];
    [self.animatr dismissAnimaWithBlock:^(UIViewController *toVC, UIViewController *fromeVC, UIView *toView, UIView *fromeView) {
        [UIView animateWithDuration:0 animations:^{
            
        } completion:^(BOOL finished) {
            self.animatr.isAccomplishAnima = true;
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

- (void) setUPViews{
    self.mainTitle.text = self.titleAlert;
    self.massageTextView.text = self.massage;
//    self.massageLabel.text = self.massage;
    [self.leftButton setTitle:self.leftButtonMassage forState:UIControlStateNormal];
    [self.rightButton setTitle:self.rightButtonMassage forState:UIControlStateNormal];
    if (_force == 1) { // 如果强制。只展示右边按钮
        self.leftButton.hidden = YES;
        [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.containerView).offset(kScrAdaptationW(20));
            make.right.equalTo(self.containerView).offset(kScrAdaptationW(-20));
        }];
    } else {
        self.leftButton.hidden = NO;
        [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.view).offset(kScrAdaptationW(-20));
            make.centerY.equalTo(self.leftButton);
        }];
        if (_isCenterShow) {
            self.massageTextView.textAlignment = NSTextAlignmentCenter;
            self.massageTextView.font = kHXBFont_PINGFANGSC_REGULAR(15);
        } else {
            self.massageTextView.textAlignment = NSTextAlignmentLeft;
        }
        if (self.titleAlert.length > 0) {
            self.mainTitle.hidden = NO;
            [self.massageTextView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view).offset(kScrAdaptationH(45));
                make.left.equalTo(self.view).offset(kScrAdaptationW(10));
                make.right.equalTo(self.view).offset(kScrAdaptationW(-10));
                make.height.offset(kScrAdaptationH(_messageHeight));
            }];
        } else {
            self.mainTitle.hidden = YES;
            [self.massageTextView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view).offset(kScrAdaptationH(20));
                make.left.equalTo(self.view).offset(kScrAdaptationW(10));
                make.right.equalTo(self.view).offset(kScrAdaptationW(-10));
                make.height.offset(kScrAdaptationH(_messageHeight));
            }];
        }
        if (_isHIddenLeftBtn) {
            self.leftButton.hidden = YES;
            [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.view).offset(kScrAdaptationW(-20));
                make.top.equalTo(self.mainTitle).offset(kScrAdaptationH(_messageHeight + 50));
                make.left.equalTo(self.view).offset(kScrAdaptationW(20));
                make.height.offset(kScrAdaptationH(35));
            }];
        } else {
            self.leftButton.hidden = NO;
            [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self.view).offset(kScrAdaptationW(-20));
                make.top.equalTo(self.mainTitle).offset(kScrAdaptationH(_messageHeight + 50));
                make.width.offset(kScrAdaptationW(115));
                make.height.offset(kScrAdaptationH(35));
            }];
        }
    }

}

//- (void)setIsCenterShow:(BOOL)isCenterShow {
//    _isCenterShow = isCenterShow;
//    if (isCenterShow) {
//        self.massageTextView.textAlignment = NSTextAlignmentCenter;
//        self.massageTextView.font = kHXBFont_PINGFANGSC_REGULAR(16);
//    } else {
//        self.massageTextView.textAlignment = NSTextAlignmentLeft;
//    }
//}



- (void)setUPViewsFrame {
    
    //    self.view.frame = CGRectMake(kScrAdaptationW(40), kScrAdaptationH(260), kScrAdaptationW(295), kScrAdaptationH(145));
    self.view.layer.cornerRadius = kScrAdaptationW(5);
    self.view.layer.masksToBounds = true;
    self.containerView = [[UIView alloc]init];
    self.containerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.containerView];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(0);
        make.height.offset(kScrAdaptationH(_messageHeight + 105));
        make.width.offset(self.view.width);
        make.center.equalTo(self.view);
    }];
    
    [self.mainTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kScrAdaptationH(0));
        make.left.equalTo(self.view).offset(kScrAdaptationW(0));
        make.right.equalTo(self.view).offset(kScrAdaptationW(0));
        make.height.offset(kScrAdaptationH(50));
    }];
    
    [self.massageTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(kScrAdaptationH(40));
        make.left.equalTo(self.view).offset(kScrAdaptationW(10));
        make.right.equalTo(self.view).offset(kScrAdaptationW(-10));
        make.height.offset(kScrAdaptationH(_messageHeight));
    }];
    
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(kScrAdaptationW(20));
        make.top.equalTo(self.mainTitle).offset(kScrAdaptationH(_messageHeight + 50));
        make.width.offset(kScrAdaptationW(115));
        make.height.offset(kScrAdaptationH(35));
    }];
    
    [self.rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).offset(kScrAdaptationW(-20));
        make.top.equalTo(self.mainTitle).offset(kScrAdaptationH(_messageHeight + 50));
        make.width.offset(kScrAdaptationW(115));
        make.height.offset(kScrAdaptationH(35));
    }];
}
- (UILabel *)mainTitle {
    if (!_mainTitle) {
        _mainTitle = [[UILabel alloc]init];
        _mainTitle.font = kHXBFont_PINGFANGSC_REGULAR(17);
        _mainTitle.textColor = [UIColor blackColor];
        _mainTitle.backgroundColor = [UIColor whiteColor];
        _mainTitle.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:_mainTitle];
    }
    return _mainTitle;
}

- (UITextView *)massageTextView {
    if (!_massageTextView) {
        _massageTextView = [[UITextView alloc]init];
        _massageTextView.font = kHXBFont_PINGFANGSC_REGULAR(15);
        _massageTextView.textColor = kHXBColor_Grey_Font0_2;
        _massageTextView.backgroundColor = [UIColor whiteColor];
        _massageTextView.textAlignment = NSTextAlignmentLeft;
        _massageTextView.editable = NO;
        [self.view addSubview:_massageTextView];
    }
    return _massageTextView;
}
- (UIButton*)rightButton {
    if (!_rightButton) {
        _rightButton = [[UIButton alloc]init];
        _rightButton.layer.cornerRadius = kScrAdaptationW(4);
        _rightButton.layer.masksToBounds = YES;
        _rightButton.backgroundColor = COR29;
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _rightButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
        [self.view addSubview:_rightButton];
    }
    return _rightButton;
}
- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [[UIButton alloc]init];
        _leftButton.layer.cornerRadius = kScrAdaptationW(4);
        _leftButton.layer.masksToBounds = YES;
        _leftButton.layer.borderWidth =  0.5;
        _leftButton.layer.borderColor = COR29.CGColor;
        _leftButton.backgroundColor = [UIColor whiteColor];
        [_leftButton setTitleColor:COR29 forState:UIControlStateNormal];
        _leftButton.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
        [self.view addSubview:_leftButton];
    }
    return _leftButton;
}
- (void)clickLeftButton:(UIButton *)button {
    NSLog(@"点击了左边的button %@",self);
    [self dismissViewControllerAnimated:true completion:nil];
    if (self.clickXYLeftButtonBlock) {
        self.clickXYLeftButtonBlock();
    }
}
- (void)clickRightButton: (UIButton *)button {
    NSLog(@"点击了右边的button %@",self);
    [self dismissViewControllerAnimated:true completion:nil];
    if (self.clickXYRightButtonBlock) {
        self.clickXYRightButtonBlock();
    }
}

- (void)addButtonWithTitle:(NSString *)title andEvent:(void(^)(UIButton *button))eventBlock {
    UIButton *button = [[UIButton alloc]init];
    [self.containerView addSubview:button];
    [self.buttonArray addObject:button];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUPAnimater];
    [self setUPViewsFrame];
    [self setUPViews];
    [_rightButton addTarget:self  action:@selector(clickRightButton:) forControlEvents:UIControlEventTouchUpInside];
    [_leftButton addTarget:self  action:@selector(clickLeftButton:) forControlEvents:UIControlEventTouchUpInside];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
