//
//  HxbSignUpViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/2.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbSignUpViewController.h"
#import "HXBSignUPView.h"///关于 注册的view
#import "HxbSignUpSucceedViewController.h"
#import "HXBSignUPAndLoginRequest.h"///数据请求
#import "HXBCheckCaptchaViewController.h"///modal 出来的校验码
#import "HXBSendSmscodeViewController.h"///短信验证的Vc

///注册按钮的title
static NSString *const kSignUPButtonString = @"注册";
///已有账号
static NSString *const kAlreadyRegistered = @"该手机号已注册";

@interface HxbSignUpViewController ()

@property (nonatomic, strong) HXBSignUPView *signUPView;
@property (nonatomic, assign) BOOL isCheckCaptchaSucceed;
@property (nonatomic, copy) NSString *checkPaptchaStr;
@property (nonatomic, strong) HXBCheckCaptchaViewController *checkCaptchVC;
@property (nonatomic,strong) UITableView *hxbBaseVCScrollView;
@property (nonatomic,copy) void(^trackingScrollViewBlock)(UIScrollView *scrollView);
@end

@implementation HxbSignUpViewController

- (HXBSignUPView *)signUPView {
    if (!_signUPView) {
        _signUPView = [[HXBSignUPView alloc]init];
        _signUPView.frame = self.view.frame;
    }
    return _signUPView;
}

- (UITableView *)hxbBaseVCScrollView {
    if (!_hxbBaseVCScrollView) {
        
        _hxbBaseVCScrollView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        if (LL_iPhoneX) {
            _hxbBaseVCScrollView.frame = CGRectMake(0, 88, kScreenWidth, kScreenHeight - 88);
        }
        
        [self.view insertSubview:_hxbBaseVCScrollView atIndex:0];
        [_hxbBaseVCScrollView.panGestureRecognizer addObserver:self forKeyPath:@"state" options:NSKeyValueObservingOptionNew context:nil];
        _hxbBaseVCScrollView.tableFooterView = [[UIView alloc]init];
        _hxbBaseVCScrollView.backgroundColor = kHXBColor_BackGround;
        [HXBMiddlekey AdaptationiOS11WithTableView:_hxbBaseVCScrollView];
    }
    return _hxbBaseVCScrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    [self.hxbBaseVCScrollView addSubview:self.signUPView];
    self.hxbBaseVCScrollView.bounces = NO;
    kWeakSelf
    self.trackingScrollViewBlock = ^(UIScrollView *scrollView) {
        [weakSelf.hxbBaseVCScrollView endEditing:true];
    };
    self.automaticallyAdjustsScrollViewInsets = YES;
    [self registerEvent];
    if (self.type == HXBSignUPAndLoginRequest_sendSmscodeType_forgot) {
        _signUPView.isHiddenLoginBtn = YES;
    }
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)registerEvent {
    [self registerEvent_ClickNextButton];///点击了下一步按钮
    [self registerEvent_checkMobile];///校验手机号事件注册
    [self registerEvent_clickHaveAccount];///点击了已有账户，去登录按钮
}

///点击了下一步按钮
- (void) registerEvent_ClickNextButton {
    kWeakSelf
    [self.signUPView signUPClickNextButtonFunc:^(NSString *mobile) {
        [HXBUmengManagar HXB_clickEventWithEnevtId:kHXBUmeng_registFirst];
        if (!KeyChain.ishaveNet) {
            [HxbHUDProgress showMessageCenter:@"暂无网络，请稍后再试" inView:nil];
            return;
        }

//        if (self.type == HXBSignUPAndLoginRequest_sendSmscodeType_signup) {//注册
//           //
////            if (weakSelf.signUPView.checkMobileStr.length > 0)
////            {
////                [HxbHUDProgress showTextWithMessage:weakSelf.signUPView.checkMobileStr];
////                return;
////            }
//        }else if(self.type == HXBSignUPAndLoginRequest_sendSmscodeType_forgot)
//        {
////            if([weakSelf.signUPView.checkMobileStr isEqualToString:@"该手机号暂未注册"])
////            {
////                [HxbHUDProgress showMessageCenter:weakSelf.signUPView.checkMobileStr inView:self.view];
////                return;
////            }
//        }
        NSLog(@"点击了下一步");
        switch (weakSelf.type) {
            case HXBSignUPAndLoginRequest_sendSmscodeType_signup://注册
                
                break;
            case HXBSignUPAndLoginRequest_sendSmscodeType_forgot://忘记密码重置登录密码
                
                break;
            case HXBSignUPAndLoginRequest_sendSmscodeType_tradpwd://重置交易密码
                
                break;
            case HXBSignUPAndLoginRequest_sendSmscodeType_newmobile://绑定手机号
                
                break;
            case HXBSignUPAndLoginRequest_sendSmscodeType_oldmobile://校验老的手机号)
                
                break;
            default:
                break;
        }
   
      
        //1. modal一个图验控制器
        ///1. 如果要是已经图验过了，那就不需要图验了
        self.checkCaptchVC = [[HXBCheckCaptchaViewController alloc] init];
        [self.checkCaptchVC checkCaptchaSucceedFunc:^(NSString *checkPaptcha){
            weakSelf.checkPaptchaStr = checkPaptcha;
            NSLog(@"发送 验证码");
//            dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 0.5 * NSEC_PER_SEC);
//                dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                    [HXBSignUPAndLoginRequest smscodeRequestWithMobile:mobile andAction:self.type andCaptcha:checkPaptcha andSuccessBlock:^(BOOL isSuccessBlock) {
                        //发送短信vc
                        HXBSendSmscodeViewController *sendSmscodeVC = [[HXBSendSmscodeViewController alloc]init];
                        sendSmscodeVC.title = self.title;
                        sendSmscodeVC.phonNumber = mobile;
                        sendSmscodeVC.captcha = self.checkPaptchaStr;
                        sendSmscodeVC.type = self.type;
                        [weakSelf.navigationController pushViewController:sendSmscodeVC animated:true];
                    } andFailureBlock:^(NSError *error) {
//                        [HxbHUDProgress showMessageCenter:@"短信发送失败" inView:self.view];
                    }];
//                });
//            });
        }];
        
        if (weakSelf.type == HXBSignUPAndLoginRequest_sendSmscodeType_forgot) {
            [HXBSignUPAndLoginRequest checkExistMobileRequestWithMobile:mobile andSuccessBlock:^(BOOL isExist) {
                if (!weakSelf.isCheckCaptchaSucceed && isExist) {
                    [weakSelf presentViewController:self.checkCaptchVC animated:true completion:nil];
                    return;
                }
            } andFailureBlock:^(NSError *error, NYBaseRequest *request) {
                
            }];
        }else
        {
            [HXBSignUPAndLoginRequest checkMobileRequestHUDWithMobile:mobile andSuccessBlock:^(BOOL isExist, NSString *message) {
                if (!weakSelf.isCheckCaptchaSucceed && isExist) {
                    [weakSelf presentViewController:self.checkCaptchVC animated:true completion:nil];
                    return;
                }
            } andFailureBlock:^(NSError *error) {
                
            }];
        }
        
        
       
    
    }];
}
///校验手机号事件注册
- (void) registerEvent_checkMobile {
    kWeakSelf
    [self.signUPView checkMobileWithBlockFunc:^(NSString *mobile) {
        if (self.type == HXBSignUPAndLoginRequest_sendSmscodeType_signup) {
            [weakSelf registerCheckMobileWithMobile:mobile];
        }else
        {
            [weakSelf forgotPasswordCheckMobileWithMobile:mobile];
        }
    }];
}

/**
 注册验证手机号

 @param mobile 手机号
 */
- (void)registerCheckMobileWithMobile:(NSString *)mobile
{
    kWeakSelf
    [HXBSignUPAndLoginRequest checkMobileRequestWithMobile:mobile andSuccessBlock:^(BOOL isExist, NSString *message) {
        NSLog(@"%d",isExist);
        if (!isExist) {
            ///已有账号
            weakSelf.signUPView.checkMobileStr = message;
        }
        ///已有账号
//        weakSelf.signUPView.checkMobileStr = @"该手机号暂未注册";
    } andFailureBlock:^(NSError *error) {
        NSLog(@"%@",error);
        ///已有账号
        weakSelf.signUPView.checkMobileStr = kAlreadyRegistered;
    }];

}

/**
 忘记密码验证手机号

 @param mobile 手机号
 */
- (void)forgotPasswordCheckMobileWithMobile:(NSString *)mobile
{
    kWeakSelf
    [HXBSignUPAndLoginRequest checkExistMobileRequestWithMobile:mobile andSuccessBlock:^(BOOL isExist) {
        if (isExist) {
            ///已有账号
            weakSelf.signUPView.checkMobileStr = kAlreadyRegistered;
        }else
        {
            ///已有账号
            weakSelf.signUPView.checkMobileStr = @"该手机号暂未注册";
        }
        ///已有账号
//        weakSelf.signUPView.checkMobileStr = @"该手机号暂未注册";
    } andFailureBlock:^(NSError *error,NYBaseRequest *request) {
        NSLog(@"%@",error);
        ///已有账号
        weakSelf.signUPView.checkMobileStr = kAlreadyRegistered;
    }];
}

///点击了已有账号按钮
- (void) registerEvent_clickHaveAccount{
    kWeakSelf
    [self.signUPView clickHaveAccountButtonFunc:^{
        [weakSelf.navigationController popViewControllerAnimated:true];
    }];
}

- (void)dealloc {
    [self.hxbBaseVCScrollView.panGestureRecognizer removeObserver: self forKeyPath:@"state"];
    NSLog(@"✅被销毁 %@",self);
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"state"]) {
        NSNumber *tracking = change[NSKeyValueChangeNewKey];
        if (tracking.integerValue == UIGestureRecognizerStateBegan && self.trackingScrollViewBlock) {
            self.trackingScrollViewBlock(self.hxbBaseVCScrollView);
        }
        return;
    }
    
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:nil];
}

@end
