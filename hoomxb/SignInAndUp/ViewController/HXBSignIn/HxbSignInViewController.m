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


///登录请求的次数 （大于三次后， 就要进行图验）
static NSString *const kReuqestSignINNumber = @"reuqestSignINNumber";
///手机号存在
static NSString *const kMobile_IsExist = @"手机号已存在";
static NSString *const kMobile_NotExis = @"手机号不存在";



@interface HxbSignInViewController ()
@property (nonatomic,strong) HxbSignInView *signView;
///记录登录请求的次数， （存到了用户偏好设置中）
@property (nonatomic,strong) NSNumber *reuqestSignINNumber;
///用户的基本信息的ViewModel
@property (nonatomic,strong) HXBRequestUserInfoViewModel *userInfoViewModel;
@end

@implementation HxbSignInViewController

#pragma mark - getter 
- (NSNumber *)reuqestSignINNumber {
    return [[NSUserDefaults standardUserDefaults] valueForKey:kReuqestSignINNumber];
}
- (void) setReuqestSignINNumber:(NSNumber *)reuqestSignINNumber {
    [[NSUserDefaults standardUserDefaults] setValue:reuqestSignINNumber forKey:kReuqestSignINNumber];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Sign In";
    [self setLeftItemBar];
    [self setSignView];/// 设置 登录界面
    [self registerSignViewEvent];///signView事件注册
    [self registerCheckMobileEvent];///请求手机号是否存在
    [self registerSignUPEvent];///注册 点击signUP事件
}

/// 设置 登录界面
- (void)setSignView{
    self.signView = [[HxbSignInView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.signView];

}

#pragma mark - signView事件注册
///点击了登录按钮
- (void)registerSignViewEvent {
    kWeakSelf
    [self.signView signIN_ClickButtonFunc:^(NSString *pasword) {
        [weakSelf userInfo_DownLoadData];//请求用户信息
        if ([weakSelf.reuqestSignINNumber integerValue] > 3) {//如果大于三次了
            
        }
        //用户登录请求
        
        
    }];
}
///注册 校验手机号事件
- (void) registerCheckMobileEvent {
    kWeakSelf
    [self.signView checkMobileRequestBlockFunc:^(NSString *mobile) {
      [HXBSignUPAndLoginRequest checkMobileRequestWithMobile:mobile andSuccessBlock:^(BOOL isExist) {
          NSString *existStr = isExist? kMobile_IsExist : kMobile_NotExis;
          ///通过这个方法吧要展示的信息，和是否可以点击登录按钮进行设定
          [weakSelf.signView checkMobileResultFuncWithCheckMobileResultStr:existStr andIsEditLoginButton:isExist];
      } andFailureBlock:^(NSError *error) {
          
      }];
    }];
}

///注册 点击注册事件
- (void)registerSignUPEvent {
    kWeakSelf
    [self.signView signUP_clickButtonFunc:^{
        HxbSignUpViewController *signUPVC = [[HxbSignUpViewController alloc]init];
        [weakSelf.navigationController pushViewController:signUPVC animated:true];
    }];
}


#pragma mark - 数据的请求
///用户数据的请求
- (void)userInfo_DownLoadData {
    __weak typeof(self)weakSelf = self;
    HXBRequestUserInfo *userInfo_request = [[HXBRequestUserInfo alloc]init];
    [userInfo_request downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
        weakSelf.userInfoViewModel = viewModel;
    } andFailure:^(NSError *error) {
        NSLog(@"用户数据请求出错");
    }];
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
    [self dismissViewControllerAnimated:YES completion:nil];
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
    [HXBNotificationCenter removeObserver:self name:ShowLoginVC object:nil];
}
@end
