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
}

/// 设置 登录界面
- (void)setSignView{
    self.signView = [[HxbSignInView alloc]initWithFrame:self.view.frame];
    [self.view addSubview:self.signView];

}

#pragma mark - signView事件注册
- (void)registerSignViewEvent {
    [self.signView signIN_ClickButtonFunc:^(NSString *pasword) {
        [self userInfo_DownLoadData];//请求用户信息
        if ([self.reuqestSignINNumber integerValue] > 3) {
            
        }
        [self signIn_downLoadDataWithCaptcha:<#(NSString *)#> andPassword:<#(NSString *)#>];//用户登录请求
    }];
}


///用户数据的请求
- (void)userInfo_DownLoadData {
    HXBRequestUserInfo *userInfo_request = [[HXBRequestUserInfo alloc]init];
    [userInfo_request downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
        self.userInfoViewModel = viewModel;
    } andFailure:^(NSError *error) {
        NSLog(@"用户数据请求出错");
    }];
}

///登录 数据的请求
- (void)signIn_downLoadDataWithCaptcha: (NSString *)captcha andPassword: (NSString *)password {
    [HXBSignUPAndLoginRequest loginRequetWithfMobile:self.userInfoViewModel.userInfoModel.userInfo.username andPassword:password andCaptcha:captcha andSuccessBlock:^(BOOL isSuccess) {
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
