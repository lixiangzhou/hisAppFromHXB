//
//  AppDelegate.m
//  hoomxb
//
//  Created by HXB-C on 2017/4/11.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "AppDelegate.h"
#import "NYNetwork.h"//网络请求的kit
#import "HxbAdvertiseView.h"//弹窗
#import "HXBServerAndClientTime.h"//客户端与服务器时间协调的工具类
#import "HXBAdvertisementManager.h"//广告管理者、
#import "HXBBaseVersionUpdateManager.h"//
#import "HxbAdvertiseViewController.h"///广告的VC
#import "HXBGesturePasswordViewController.h"//手势面膜控制器

#import "HXBVersionUpdateRequest.h"//版本更新的请求
#import "HXBVersionUpdateModel.h"//版本更新的Model

#import "IQKeyboardManager.h"//设置键盘

#import "UMMobClick/MobClick.h"//友盟统计
static NSString *const home = @"首页";
static NSString *const financing = @"理财";
static NSString *const my = @"我的";

@interface AppDelegate ()

@property (nonatomic, strong) NSDate *exitTime;

@property (nonatomic, strong) HXBVersionUpdateModel *versionUpdateModel;
@end

@implementation AppDelegate
///懒加载主界面Tabbar
- (HXBBaseTabBarController *)mainTabbarVC
{
    if (!_mainTabbarVC) {
        _mainTabbarVC = [[HXBBaseTabBarController alloc]init];
        _mainTabbarVC.selectColor = [UIColor redColor];///选中的颜色
        _mainTabbarVC.normalColor = [UIColor grayColor];///平常状态的颜色
        
        NSArray *controllerNameArray = @[
                                         @"HxbHomeViewController",//首页
                                         @"HxbFinanctingViewController",//理财
                                         @"HxbMyViewController"];//我的
        //title 集合
        NSArray *controllerTitleArray = @[home,financing,my];
        NSArray *imageArray = @[@"hom¡vg",@"investment_Unselected.svg",@"my_Unselected.svg"];
        //选中下的图片前缀
        NSArray *commonName = @[@"home_Selected.svg",@"investment_Selected.svg",@"my_Selected.svg"];
         
        [_mainTabbarVC subViewControllerNames:controllerNameArray andNavigationControllerTitleArray:controllerTitleArray andImageNameArray:imageArray andSelectImageCommonName:commonName];

    }
    return _mainTabbarVC;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //配置网络
    [self setNetworkConfig];
    
    //判断app是否第一次启动，以及版本是否需要更新
    [self judgementApplication];
    
    //创建根视图 并设置
    [self creatRootViewController];
    
    //服务器时间与客户端时间的处理
    [self serverAndClientTime];

    //设置键盘
    [self keyboardManager];
    
    //设置友盟统计
    [self setupUmeng];
    
    return YES;
}
//设置UI友盟统计信息
- (void)setupUmeng
{
    UMConfigInstance.appKey = @"596359ca5312dd05b4001381";
    UMConfigInstance.channelId = @"App Store";
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setEncryptEnabled:YES];// 设置是否对日志信息进行加密, 默认NO(不加密).
    [MobClick setAppVersion:version];
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
}

- (void)keyboardManager
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
}

- (void)checkversionUpdate
{
    kWeakSelf
    NSString *version = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
    HXBVersionUpdateRequest *versionUpdateRequest = [[HXBVersionUpdateRequest alloc] init];
    [versionUpdateRequest versionUpdateRequestWitversionCode:version andSuccessBlock:^(id responseObject) {
//        HXBVersionUpdateViewModel *versionUpdateVM = [[HXBVersionUpdateViewModel alloc] init];
        weakSelf.versionUpdateModel = [HXBVersionUpdateModel yy_modelWithDictionary:responseObject[@"data"]];
//        versionUpdateVM.versionUpdateModel =  weakSelf.versionUpdateModel;
    } andFailureBlock:^(NSError *error) {
        
    }];
}


#pragma mark - 判断app是否第一次启动，以及版本是否需要更新
- (void)judgementApplication {
    if([HXBBaseVersionUpdateManager isFirstStartUPAPP]) {
        
    }
}
#pragma mark - 创建并设置根视图控制器
- (void)creatRootViewController {
    
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//HXBBaseTabBarController *tabBarController = [[HXBBaseTabBarController alloc]init];
    
    //数据
    __weak typeof(self) weakSelf = self;
    HxbAdvertiseViewController *advertiseViewControllre = [[HxbAdvertiseViewController alloc]init];
    _window.rootViewController = advertiseViewControllre;
    [advertiseViewControllre dismissAdvertiseViewControllerFunc:^{
        [weakSelf enterTheGesturePasswordVC];
    }];
    _window.backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];
}


/**
 判断是否进入手势密码
 */
- (void)enterTheGesturePasswordVC
{
    if ((KeyChain.gesturePwd.length >= 4) && [KeyChain isLogin] && [kUserDefaults boolForKey:kHXBGesturePWD]) {
        HXBGesturePasswordViewController *gesturePasswordVC = [[HXBGesturePasswordViewController alloc] init];
        gesturePasswordVC.type = GestureViewControllerTypeLogin;
         _window.rootViewController = gesturePasswordVC;
        
    }else
    {
        _window.rootViewController = self.mainTabbarVC;
    }
    //检测版本更新
    [self checkversionUpdate];
}

//根据服务器时间计算与本地时间的时间差
- (void)serverAndClientTime {
    //......服务器请求数据
    NSString *serverTime;//服务器求情下来之后的服务器时间戳
    HXBServerAndClientTime *serverAndClientTime = [HXBServerAndClientTime sharedServerAndClientTime];
    serverAndClientTime.serverTime = serverTime;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    //服务器时间与客户端时间的处理
    [self serverAndClientTime];
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    //服务器时间与客户端时间的处理
    [self serverAndClientTime];
    self.exitTime = [NSDate date];
    NSLog(@"%@",application);
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    //服务器时间与客户端时间的处理
    [self serverAndClientTime];
    
    [HXBAlertManager checkversionUpdateWith:self.versionUpdateModel];
    
    NSDate *nowTime = [NSDate date];
    NSTimeInterval timeDifference = [nowTime timeIntervalSinceDate: self.exitTime];
    if (timeDifference>300) {
        [self enterTheGesturePasswordVC];
    }

}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    //服务器时间与客户端时间的处理
    [self serverAndClientTime];
}


- (void)applicationWillTerminate:(UIApplication *)application {
}
#pragma mark - 设置网路库的Config
- (void)setNetworkConfig
{
    NYNetworkConfig *config = [NYNetworkConfig sharedInstance];
    config.baseUrl = BASEURL;
    config.version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:
//(void (^)(UIBackgroundFetchResult))completionHandler {
//    
//    //判断app是不是在前台运行，有三个状态(如果不进行判断处理，当你的app在前台运行时，收到推送时，通知栏不会弹出提示的)
//    // UIApplicationStateActive, 在前台运行
//    // UIApplicationStateInactive,未启动app
//    //UIApplicationStateBackground    app在后台
//    
//    if([UIApplication sharedApplication].applicationState == UIApplicationStateActive)
//    {  //此时app在前台运行，我的做法是弹出一个alert，告诉用户有一条推送，用户可以选择查看或者忽略
//        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"推送消息"
//                                                         message:@"您有一条新的推送消息!"
//                                                        delegate:self
//                                               cancelButtonTitle:@"取消"
//                                               otherButtonTitles:@"查看",nil];
//        [alert show];
//        
//    }
//    
//} else {
//    //这里是app未运行或者在后台，通过点击手机通知栏的推送消息打开app时可以在这里进行处理，比如，拿到推送里的内容或者附加      字段(假设，推送里附加了一个url为 www.baidu.com)，那么你就可以拿到这个url，然后进行跳转到相应店web页，当然，不一定必须是web页，也可以是你app里的任意一个controll，跳转的话用navigation或者模态视图都可以
//}
//
////这里设置app的图片的角标为0，红色但角标就会消失
//[UIApplication sharedApplication].applicationIconBadgeNumber  =  0;
//completionHandler(UIBackgroundFetchResultNewData);
//}
@end
