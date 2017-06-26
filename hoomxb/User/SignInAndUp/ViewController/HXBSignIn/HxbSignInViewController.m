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


///手机号存在
static NSString *const kMobile_IsExist = @"手机号已存在";
static NSString *const kMobile_NotExis = @"手机号不存在";



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

    self.title = @"Sign In";
    [self setLeftItemBar];
    [self setSignView];/// 设置 登录界面
    [self registerSignViewEvent];///signView事件注册
    [self registerCheckMobileEvent];///请求手机号是否存在
    [self registerSignUPEvent];///注册 点击signUP事件
    [self registerClickforgetPasswordButton];///忘记密码
}

/// 设置 登录界面
- (void)setSignView{
    kWeakSelf

    self.signView = [[HxbSignInView alloc]initWithFrame:self.view.frame];
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

        //[weakSelf userInfo_DownLoadData];//请求用户信息
//        NSNumber *reuqestSignINNumber =  [[NSUserDefaults standardUserDefaults] valueForKey:mobile];
//        if ([reuqestSignINNumber integerValue] >= 3) {//如果大于三次了
//            
//            HXBCheckCaptchaViewController *vc = [[HXBCheckCaptchaViewController alloc] init];
//            [vc checkCaptchaSucceedFunc:^(NSString *checkPaptcha) {
//                self.checkCaptcha = checkPaptcha;
//            }];
//            [weakSelf presentViewController:vc animated:true completion:nil];
//        }
        //用户登录请求
        [HXBSignUPAndLoginRequest loginRequetWithfMobile:mobile andPassword:pasword andCaptcha:self.checkCaptcha andSuccessBlock:^(BOOL isSuccess) {
            NSLog(@"登录成功");
            self.reuqestSignINNumber = @(0);
            //调到我的界面
//            [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_LoginSuccess_PushMYVC object:self];
            [KeyChain removeAllInfo];
//            [KeyChain setMobile:mobile];
            [[KeyChainManage sharedInstance] mobileWithBlock:^(NSString *mobile) {
                
            }];
            [weakSelf dismiss];
        } andFailureBlock:^(NSError *error) {
            self.reuqestSignINNumber = @(self.reuqestSignINNumber.integerValue + 1);
            if (!error) {
                HXBCheckCaptchaViewController *vc = [[HXBCheckCaptchaViewController alloc] init];
                [vc checkCaptchaSucceedFunc:^(NSString *checkPaptcha) {
                    self.checkCaptcha = checkPaptcha;
                }];
                [weakSelf presentViewController:vc animated:true completion:nil];
            }
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
      } andFailureBlock:^(NSError *error) {
          
      }];
    }];
}

#pragma mark - 注册 点击注册事件
- (void)registerSignUPEvent {
    kWeakSelf
    [self.signView signUP_clickButtonFunc:^{
        HxbSignUpViewController *signUPVC = [[HxbSignUpViewController alloc]init];
        signUPVC.type = HXBSignUPAndLoginRequest_sendSmscodeType_signup;
        [weakSelf.navigationController pushViewController:signUPVC animated:true];
    }];
}

///点击了忘记密码按钮
- (void)registerClickforgetPasswordButton {
    kWeakSelf
    [self.signView clickforgetPasswordButtonFunc:^{
        HxbSignUpViewController *signUPVC = [[HxbSignUpViewController alloc] init];
        signUPVC.type = HXBSignUPAndLoginRequest_sendSmscodeType_forgot;
        [weakSelf.navigationController pushViewController:signUPVC animated:true];
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
    [HXBSignUPAndLoginRequest loginRequetWithfMobile:mobile andPassword:password andCaptcha:captcha andSuccessBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            NSLog(@"登录成功");
        }
    } andFailureBlock:^(NSError *error) {
    }];
}


- (void)didClicksignUpBtn{
    HxbPhoneVerifyViewController *phoneVerifyViewController =[[HxbPhoneVerifyViewController alloc]init];
    [self.navigationController pushViewController:phoneVerifyViewController animated:true];
}

- (void)dismiss{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)setLeftItemBar{
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"login_close"] style:UIBarButtonItemStyleDone target:self action:@selector(dismiss)];
    leftItem.tintColor = [UIColor colorWithRed:131/255.0f green:131/255.0f blue:131/255.0f alpha:1];
    self.navigationItem.leftBarButtonItem = leftItem;
}
- (void)didClickSignInBtn{
    
    [self dismiss];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [HXBNotificationCenter removeObserver:self name:kHXBNotification_ShowLoginVC object:nil];
}
@end
