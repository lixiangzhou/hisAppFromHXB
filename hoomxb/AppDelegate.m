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
@interface AppDelegate ()

@end

@implementation AppDelegate
/**
 *  懒加载主界面Tabbar
 */

- (HXBBaseTabBarController *)mainTabbarVC
{
    if (!_mainTabbarVC) {
        _mainTabbarVC = [[HXBBaseTabBarController alloc]init];
        _mainTabbarVC.selectColor = [UIColor redColor];
        _mainTabbarVC.normalColor = [UIColor grayColor];
        NSArray *controllerNameArray = @[@"HxbHomeViewController",@"HxbFinanctingViewController",@"HxbMyViewController"];
        NSArray *controllerTitleArray = @[@"首页",@"理财",@"我的"];
        NSArray *imageArray = @[@"1",@"1",@"1"];
        //选中下的图片前缀
        NSString *commonName = @"1";
        
        [_mainTabbarVC subViewControllerNames:controllerNameArray andNavigationControllerTitleArray:controllerTitleArray andImageNameArray:imageArray andSelectImageCommonName:commonName];

    }
    return _mainTabbarVC;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //配置网络
    [self setNetworkConfig];
    
    //创建根视图 并设置
    [self creatRootViewController];
    
    //服务器时间与客户端时间的处理
    [self serverAndClientTime];
    return YES;
}

#pragma mark - 设置网路库的Config
- (void)setNetworkConfig
{
    NYNetworkConfig *config = [NYNetworkConfig sharedInstance];
    config.baseUrl = BASEURL;
    config.version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

#pragma mark - 创建并设置根视图控制器
- (void)creatRootViewController {
    
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    HXBBaseTabBarController *tabBarController = [[HXBBaseTabBarController alloc]init];

    //数据
    _window.rootViewController = self.mainTabbarVC;
    _window.backgroundColor = [UIColor whiteColor];
    [_window makeKeyAndVisible];
    [self setAdvertiseView];
}

- (void)setAdvertiseView{
    
    NSString *filePath = [HxbFileManager getFilePathWithImageName:[kUserDefaults valueForKey:adImageName]];
    
    BOOL isExist = [HxbFileManager isFileExistWithFilePath:filePath];
    if (isExist) {// 图片存在
        HxbAdvertiseView *advertiseView = [[HxbAdvertiseView alloc] initWithFrame:self.window.bounds];
        advertiseView.filePath = filePath;
        [advertiseView show];
    }
    // 2.无论沙盒中是否存在广告图片，都需要重新调用广告接口，判断广告是否更新
    [self getAdvertisingImage];
}

- (void)getAdvertisingImage
{
    // TODO 请求广告接口
    NSArray *imageArray = @[@"https://a-ssl.duitang.com/uploads/item/201505/31/20150531222441_kVZXU.jpeg", @"https://a-ssl.duitang.com/uploads/item/201505/31/20150531222425_zFKGY.thumb.700_0.jpeg", @"https://a-ssl.duitang.com/uploads/item/201505/31/20150531222413_ak25z.thumb.700_0.jpeg", @"https://a-ssl.duitang.com/uploads/item/201604/06/20160406172034_TVkJs.thumb.700_0.jpeg"];
    NSString *imageUrl = imageArray[arc4random() % imageArray.count];
    
    // 获取图片名:43-130P5122Z60-50.jpg
    NSArray *stringArr = [imageUrl componentsSeparatedByString:@"/"];
    NSString *imageName = stringArr.lastObject;
    
    // 拼接沙盒路径
    NSString *filePath = [HxbFileManager getFilePathWithImageName:imageName];
    BOOL isExist = [HxbFileManager isFileExistWithFilePath:filePath];
    if (!isExist){// 如果该图片不存在，则删除老图片，下载新图片
        [self downloadAdImageWithUrl:imageUrl imageName:imageName];
    }
    
}

/**
 *  下载新图片
 */
- (void)downloadAdImageWithUrl:(NSString *)imageUrl imageName:(NSString *)imageName
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        UIImage *image = [UIImage imageWithData:data];
        
        NSString *filePath = [HxbFileManager getFilePathWithImageName:imageName]; // 保存文件的名称
        
        if ([UIImagePNGRepresentation(image) writeToFile:filePath atomically:YES]) {// 保存成功
            NSLog(@"保存成功");
            [self deleteOldImage];
            [kUserDefaults setValue:imageName forKey:adImageName];
            [kUserDefaults synchronize];
            // 如果有广告链接，将广告链接也保存下来
        }else{
            NSLog(@"保存失败");
        }
        
    });
}

/**
 *  删除旧图片
 */
- (void)deleteOldImage
{
    NSString *imageName = [kUserDefaults valueForKey:adImageName];
    if (imageName) {
        NSString *filePath = [HxbFileManager getFilePathWithImageName:imageName];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtPath:filePath error:nil];
    }
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
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    //服务器时间与客户端时间的处理
    [self serverAndClientTime];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    //服务器时间与客户端时间的处理
    [self serverAndClientTime];
}


- (void)applicationWillTerminate:(UIApplication *)application {
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
