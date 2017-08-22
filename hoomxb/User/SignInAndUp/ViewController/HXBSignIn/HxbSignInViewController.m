        //
//  HxbSignInViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/4/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbSignInViewController.h"
#import "HxbSignUpViewController.h"
#import "HxbPhoneVerifyViewController.h"
#import "HxbSignInView.h"
#import "HXBSignUPAndLoginRequest.h"///用于请求注册登录的接口
#import "HXBRequestUserInfo.h"///用户数据的请求
#import "HXBRequestUserInfoViewModel.h"///userinfo的viewModel
#import "HXBCheckCaptchaViewController.h"
#import "HXBBaseTabBarController.h"
#import "SVGKImage.h"
#import "HXBSignUPAgreementWebViewVC.h"
///手机号存在
static NSString *const kMobile_IsExist = @"手机号已存在";
static NSString *const kMobile_NotExis = @"手机号尚未注册";



@interface HxbSignInViewController ()
@property (nonatomic,strong) HxbSignInView *signView;
///记录登录请求的次数， （存到了用户偏好设置中）
@property (nonatomic,strong) NSNumber *reuqestSignINNumber;
///用户的基本信息的ViewModel
@property (nonatomic,strong) HXBRequestUserInfoViewModel *userInfoViewModel;
@property (nonatomic,copy) NSString *checkCaptcha;

@end

@implementation HxbSignInViewController



#pragma mark - getter 
//- (NSNumber *)reuqestSignINNumber {
//    return [];
//}
//- (void) setReuqestSignINNumber:(NSNumber *)reuqestSignINNumber {
//    [[NSUserDefaults standardUserDefaults] setValue:reuqestSignINNumber forKey:kReuqestSignINNumber];
//}


- (void)viewDidLoad {
    [super viewDidLoad];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(modalCaptchaVC:) name:kHXBBotification_ShowCaptchaVC object:nil];
//    self.isColourGradientNavigationBar = YES;
    self.title = @"登录";
    [self setLeftItemBar];
    [self setSignView];/// 设置登录界面
    [self registerSignViewEvent];///signView事件注册
    [self registerCheckMobileEvent];///请求手机号是否存在
    [self registerSignUPEvent];///注册 点击signUP事件
    [self registerClickforgetPasswordButton];///忘记密码
    [self registerClickUserAgreementBtn];///用户协议
}


//谈图验
- (void) modalCaptchaVC: (NSNotification *)notif {
    HXBCheckCaptchaViewController *checkCaptchaViewController = [[HXBCheckCaptchaViewController alloc]init];
    [checkCaptchaViewController checkCaptchaSucceedFunc:^(NSString *checkPaptcha) {
        self.checkCaptcha = checkPaptcha;
    }];
    [self presentViewController:checkCaptchaViewController animated:true completion:nil];
}
/// 设置 登录界面
- (void)setSignView{
    kWeakSelf
    self.isTransparentNavigationBar = true;
    self.signView = [[HxbSignInView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.hxb_automaticallyAdjustsScrollViewInsets = false;
    [self.hxbBaseVCScrollView addSubview:self.signView];
    [self trackingScrollViewBlock:^(UIScrollView *scrollView) {
        [weakSelf.signView endEditing:true];
    }];
}

#pragma mark - signView事件注册
///点击了登录按钮
- (void)registerSignViewEvent {
    kWeakSelf
    [self.signView signIN_ClickButtonFunc:^(NSString *pasword, NSString *mobile) {

    
        //用户登录请求
        [HXBSignUPAndLoginRequest loginRequetWithfMobile:mobile andPassword:pasword andCaptcha:self.checkCaptcha andSuccessBlock:^(BOOL isSuccess) {
            NSLog(@"登录成功");
            [weakSelf userInfo_DownLoadData];//请求用户信息
            self.reuqestSignINNumber = @(0);
            [KeyChainManage sharedInstance].siginCount = @"0";
            //调到我的界面
            [KeyChainManage sharedInstance].isLogin = true;
            KeyChain.ciphertext = @"0";
            [[KeyChainManage sharedInstance] isVerifyWithBlock:^(NSString *isVerify) {
                
                [weakSelf dismissViewControllerAnimated:YES completion:nil];
            }];
        } andFailureBlock:^(NSError *error, id responseObject) {
            if ([responseObject[kResponseStatus] integerValue]) {
                
                [HxbHUDProgress showTextWithMessage: responseObject[kResponseMessage]];
                if ([responseObject[kResponseStatus] integerValue] == kHXBCode_Enum_Captcha) {
//                    [HxbHUDProgress showTextWithMessage:responseObject[kResponseMessage]];
                    if ([responseObject[kResponseStatus] integerValue] == kHXBCode_Enum_Captcha) {//谈图验
                        HXBCheckCaptchaViewController *checkCaptchaViewController = [[HXBCheckCaptchaViewController alloc]init];
                        [checkCaptchaViewController checkCaptchaSucceedFunc:^(NSString *checkPaptcha) {
                            //                    self.checkCaptcha = checkPaptcha;
                            
                            [self signIn_downLoadDataWithCaptcha:checkPaptcha andPassword:pasword andMobile:mobile];
                        }];
                        [self presentViewController:checkCaptchaViewController animated:true completion:nil];
                    }
                }
            }
            ///清空
            self.checkCaptcha = nil;
        }];
    }];
}
///注册 校验手机号事件
- (void) registerCheckMobileEvent {
    kWeakSelf
    [self.signView checkMobileRequestBlockFunc:^(NSString *mobile) {
      [HXBSignUPAndLoginRequest checkExistMobileRequestWithMobile:mobile andSuccessBlock:^(BOOL isExist) {
          NSString *existStr = isExist? kMobile_IsExist : kMobile_NotExis;
          ///通过这个方法吧要展示的信息，和是否可以点击登录按钮进行设定
          [weakSelf.signView checkMobileResultFuncWithCheckMobileResultStr:existStr andIsEditLoginButton:isExist];
      } andFailureBlock:^(NSError *error, NYBaseRequest *request) {
          kHXBRespons_ShowHUDWithError(self.signView)
      }];
    }];
}

#pragma mark - 注册 点击注册事件
- (void)registerSignUPEvent {
    kWeakSelf
    [self.signView signUP_clickButtonFunc:^{
        HxbSignUpViewController *signUPVC = [[HxbSignUpViewController alloc]init];
        signUPVC.title = @"注册";
        signUPVC.type = HXBSignUPAndLoginRequest_sendSmscodeType_signup;
        [weakSelf.navigationController pushViewController:signUPVC animated:true];
    }];
}

///点击了忘记密码按钮
- (void)registerClickforgetPasswordButton {
    kWeakSelf
    [self.signView clickforgetPasswordButtonFunc:^{
        HxbSignUpViewController *signUPVC = [[HxbSignUpViewController alloc] init];
        signUPVC.title = @"重置登录密码";
        signUPVC.type = HXBSignUPAndLoginRequest_sendSmscodeType_forgot;
        [weakSelf.navigationController pushViewController:signUPVC animated:true];
    }];
   
}

- (void)registerClickUserAgreementBtn
{
    [self.signView clickUserAgreementBtnFunc:^{
        HXBSignUPAgreementWebViewVC *signUPAgreementWebViewVC = [[HXBSignUPAgreementWebViewVC alloc]init];
        signUPAgreementWebViewVC.URL = kHXB_Negotiate_SginUPURL;
        [self.navigationController pushViewController:signUPAgreementWebViewVC animated:true];
    }];
}

#pragma mark - 数据的请求
///用户数据的请求
- (void)userInfo_DownLoadData {
//    __weak typeof(self)weakSelf = self;
//    HXBRequestUserInfo *userInfo_request = [[HXBRequestUserInfo alloc]init];
//    [userInfo_request downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
//        weakSelf.userInfoViewModel = viewModel;
//    } andFailure:^(NSError *error) {
//        NSLog(@"用户数据请求出错");
//    }];
}

///登录 数据的请求
- (void)signIn_downLoadDataWithCaptcha: (NSString *)captcha andPassword: (NSString *)password andMobile: (NSString *)mobile{
    kWeakSelf
    [HXBSignUPAndLoginRequest loginRequetWithfMobile:mobile andPassword:password andCaptcha:captcha andSuccessBlock:^(BOOL isSuccess) {
        NSLog(@"登录成功");
        [self userInfo_DownLoadData];//请求用户信息
        self.reuqestSignINNumber = @(0);
        [KeyChainManage sharedInstance].siginCount = @"0";
        //调到我的界面
        [KeyChainManage sharedInstance].isLogin = true;
        [[KeyChainManage sharedInstance] isVerifyWithBlock:^(NSString *isVerify) {
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }];
    } andFailureBlock:^(NSError *error, id responseObject) {
        if ([responseObject[kResponseStatus] integerValue]) {
            [HxbHUDProgress showTextWithMessage:responseObject[kResponseMessage]];
            if ([responseObject[kResponseStatus] integerValue] == kHXBCode_Enum_Captcha) {//谈图验
                HXBCheckCaptchaViewController *checkCaptchaViewController = [[HXBCheckCaptchaViewController alloc]init];
                [checkCaptchaViewController checkCaptchaSucceedFunc:^(NSString *checkPaptcha) {
//                    self.checkCaptcha = checkPaptcha;
                    [self signIn_downLoadDataWithCaptcha:checkPaptcha andPassword:password andMobile:mobile];
                }];
                [self presentViewController:checkCaptchaViewController animated:true completion:nil];
            }
        }
        
    }];
}


- (void)didClicksignUpBtn{
    HxbPhoneVerifyViewController *phoneVerifyViewController =[[HxbPhoneVerifyViewController alloc]init];
    [self.navigationController pushViewController:phoneVerifyViewController animated:true];
}

- (void)dismiss{
    
    HXBBaseTabBarController *baseTabBarVC = (HXBBaseTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    if (self.selectedIndexVC != nil) {
        baseTabBarVC.selectedIndex = [self.selectedIndexVC integerValue];
    }
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)setLeftItemBar{
    UIButton *leftBackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 50, 35)];
    //    [leftBackBtn setTitle:@"返回" forState:UIControlStateNormal];
    [leftBackBtn setImage:[SVGKImage imageNamed:@"back.svg"].UIImage forState:UIControlStateNormal];
    // 让按钮内部的所有内容左对齐
    leftBackBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [leftBackBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [leftBackBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    // 修改导航栏左边的item
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBackBtn];
//    self.navigationController.navigationBar.barStyle=UIBarStyleBlackTranslucent;
//    self.navigationController.navigationBar.titleTextAttributes=@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:kHXBFont_PINGFANGSC_REGULAR(18)};
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top"] forBarMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setValue:@(0)forKeyPath:@"backgroundView.alpha"];
}
- (void)didClickSignInBtn{
    
    [self dismiss];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [HXBNotificationCenter removeObserver:self name:kHXBNotification_ShowLoginVC object:nil];
}
@end
