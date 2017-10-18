//
//  HXBLoginManager.m
//  hoomxb
//
//  Created by HXB on 2017/6/1.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBLoginManager.h"
#import "HXBSignUPAndLoginRequest.h"///用于请求注册登录的接口
#import "HXBRequestUserInfo.h"///用户数据的请求
#import "HXBRequestUserInfoViewModel.h"///userinfo的viewModel

///登录请求的次数 （大于三次后， 就要进行图验）
static NSString *const kReuqestSignINNumber = @"reuqestSignINNumber";
static char *kLoginManagerQueueName = "LoginManagerQueueName";



@interface HXBLoginManager ()

///用户的基本信息的ViewModel
@property (nonatomic,strong) HXBRequestUserInfoViewModel *userInfoViewModel;
///用户名，在登录的时候会用到
@property (nonatomic,copy) NSString *userName;

///穿行队列，异步执行，只会开启一条线程，并且会依次执行
@property (nonatomic,strong) dispatch_queue_t queue;
@end

@implementation HXBLoginManager
#pragma mark - getter
- (NSNumber *)reuqestSignINNumber {
    return [[NSUserDefaults standardUserDefaults] valueForKey:kReuqestSignINNumber];
}
- (void) setReuqestSignINNumber:(NSNumber *)reuqestSignINNumber {
    [[NSUserDefaults standardUserDefaults] setValue:reuqestSignINNumber forKey:kReuqestSignINNumber];
}
- (dispatch_queue_t) queue{
    if (!_queue) {
        _queue = dispatch_queue_create(kLoginManagerQueueName, DISPATCH_QUEUE_SERIAL);
    }
    return _queue;
}
- (NSString *)userName {
    return self.userInfoViewModel.userInfoModel.userInfo.username;
}


- (void)loginReuquestWithPassword: (NSString *)password andCaptcha: (NSString *)captcha
              andShowCaptchaBlock:(void(^)(id response))showCaptchaBlock
andGreaterThan_LoginTotalNumberBlock: (void(^)())GreaterThan_LoginTotalNumberBlock{
    ///关于用户信息的任务请求
    dispatch_block_t userInfoBlock = ^{
        [self userInfo_DownLoadData];
    };
    ///关于图验请求的接口
    dispatch_block_t captchaBlock = ^{
        [self captcha_DownLoadDataWithShowCaptchaBlock:showCaptchaBlock];
    };
    ///关于用户登录的接口
    dispatch_block_t signINBlock = ^{
        [self signIn_downLoadDataWithCaptcha:captcha andPassword:password];
    };
    
    ///异步执行 串行队列，会生成一个新线程，并且依次执行
    if ([self.reuqestSignINNumber integerValue] <= kLoginTotalNumber) {//登录次数小于等于3
        dispatch_async(self.queue, userInfoBlock);
        dispatch_async(self.queue, signINBlock);
    }else {//登录次数大于3
        dispatch_async(self.queue, userInfoBlock);
        dispatch_async(self.queue, captchaBlock);
    }
}

///用户数据的请求
- (void)userInfo_DownLoadData {
    HXBRequestUserInfo *userInfo_request = [[HXBRequestUserInfo alloc]init];
//    [userInfo_request downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
//        self.userInfoViewModel = viewModel;
//    } andFailure:^(NSError *error) {
//        NSLog(@"用户数据请求出错");
//    }];
}
///图验请求 如果请求成功那么就 执行外部传进来的 block
- (void)captcha_DownLoadDataWithShowCaptchaBlock:(void(^)(id response))showCaptchaBlock {
//    [HXBSignUPAndLoginRequest captchaRequestWithSuccessBlock:^(id responseObject) {
//        if (responseObject) {
//            if (showCaptchaBlock) {
//                showCaptchaBlock(responseObject);
//            }
//            NSLog(@"%@",responseObject);
//        }
//    } andFailureBlock:^(NSError *error) {
//        
//    }];
}
///登录 数据的请求
- (void)signIn_downLoadDataWithCaptcha: (NSString *)captcha andPassword: (NSString *)password {
    [HXBSignUPAndLoginRequest loginRequetWithfMobile:self.userName andPassword:password andCaptcha:captcha andSuccessBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            NSLog(@"登录成功");
            self.reuqestSignINNumber = @(0);
        }
    } andFailureBlock:^(NSError *error, id responseObject) {
        //请求不成功就 计数器就加一
        self.reuqestSignINNumber = @([self.reuqestSignINNumber integerValue] + 1);
    }];
}

@end
