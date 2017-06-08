//
//  HXBCheckCaptchaViewController.m
//  hoomxb
//
//  Created by HXB on 2017/6/2.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBCheckCaptchaViewController.h"
#import "HXBCheckCaptcha.h"
#import "HXBSignUPAndLoginRequest.h"
#import   "UIImageView+WebCache.h"


@interface HXBCheckCaptchaViewController ()
@property (nonatomic, strong) Animatr *animatrManager;
@property (nonatomic, strong) HXBCheckCaptcha *checkCaptcha;
@property (nonatomic, strong) HXBSignUPAndLoginRequest *request;
@property (nonatomic, copy) void (^isCheckCaptchaSucceedBlock)(NSString *captcha);
@end

@implementation HXBCheckCaptchaViewController

- (Animatr *)animatrManager {
    if (!_animatrManager) {
        _animatrManager = [Animatr animatrWithModalPresentationStyle:UIModalPresentationCustom];
    }
    return _animatrManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.transitioningDelegate = self.animatrManager;
        self.modalPresentationStyle = UIModalPresentationCustom;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    ///setUP
    [self setUP];
    ///请求数据
    [self setUPAnimater];
}

- (void)setUPAnimater{
    __weak typeof (self)weakSelf = self;
    [self.animatrManager presentAnimaWithBlock:^(UIViewController *toVC, UIViewController *fromeVC, UIView *toView, UIView *fromeView) {
        [UIView animateWithDuration:.0 animations:^{
            toView.center = [UIApplication sharedApplication].keyWindow.center;
            toView.bounds = CGRectMake(0, 0, kScrAdaptationW(300), kScrAdaptationW(300));
            weakSelf.checkCaptcha.frame = toView.bounds;
        } completion:^(BOOL finished) {
            weakSelf.animatrManager.isAccomplishAnima = true;
        }];
    }];
    [self.animatrManager dismissAnimaWithBlock:^(UIViewController *toVC, UIViewController *fromeVC, UIView *toView, UIView *fromeView) {
        [UIView animateWithDuration:0 animations:^{
            
        } completion:^(BOOL finished) {
            weakSelf.animatrManager.isAccomplishAnima = true;
        }];
    }];
    [self.animatrManager setupContainerViewWithBlock:^(UIView *containerView) {
        containerView.backgroundColor = [UIColor colorWithWhite:.5 alpha:.8];
        UIButton *button = [[UIButton alloc]init];
        [containerView insertSubview:button atIndex:0];
        button.frame = containerView.bounds;
        [button addTarget:self action:@selector(clickContainerView:) forControlEvents:UIControlEventTouchUpInside];
    }];
    
}
- (void)clickContainerView: (UIButton *)button {
    [self dismissViewControllerAnimated:true completion:nil];
}

//设置
- (void) setUP {
    
    [self setUPSubView];//设置图层
    [self downCheckCaptcha];//请求图验
    [self clickTrueButtonEvent];//点击了确认按钮
    [self clickCheckCaptchaImageViewEvent];///点击了图验图片
}
- (void)setUPSubView {
    self.checkCaptcha = [[HXBCheckCaptcha alloc]init];
    [self.view addSubview:self.checkCaptcha];
    self.checkCaptcha.frame = self.view.frame;
    
    
}
///请求数据 图验图片
- (void)downCheckCaptcha {
    self.request = [[HXBSignUPAndLoginRequest alloc]init];
    [self.request captchaRequestWithSuccessBlock:^(id responseObject) {
        self.checkCaptcha.checkCaptchaImage = responseObject;
    } andFailureBlock:^(NSError *error) {
        
    }];
}
///点击了确定按钮
- (void)clickTrueButtonEvent {
    kWeakSelf
    
    [self.checkCaptcha clickTrueButtonFunc:^(NSString *checkCaptChaStr) {
        //判断验证码是否正确
        [HXBSignUPAndLoginRequest checkCaptcharRequestWithCaptcha:checkCaptChaStr andSuccessBlock:^(BOOL isSuccessBlock) {
            //正确就dismiss
            if (isSuccessBlock) {
                ///通知控制器 图验通过
                if(weakSelf.isCheckCaptchaSucceedBlock) weakSelf.isCheckCaptchaSucceedBlock(checkCaptChaStr);
                [weakSelf dismissViewControllerAnimated:true completion:nil];
            }else{
                weakSelf.checkCaptcha.isCorrect = false;
            }
        } andFailureBlock:^(NSError *error) {
            weakSelf.checkCaptcha.isCorrect = false;
        }];
    }];
}

///点击了图验图片
- (void)clickCheckCaptchaImageViewEvent {
    kWeakSelf
    [self.checkCaptcha clickCheckCaptchaImageViewFunc:^{
        [weakSelf downCheckCaptcha];
    }];
}

///验证通过
- (void)checkCaptchaSucceedFunc:(void (^)(NSString *checkCaptcha))isCheckCaptchaSucceedBlock {
    self.isCheckCaptchaSucceedBlock = isCheckCaptchaSucceedBlock;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
