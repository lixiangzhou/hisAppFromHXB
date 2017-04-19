//
//  AppDelegate.m
//  hoomxb
//
//  Created by HXB-C on 2017/4/11.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "AppDelegate.h"
#import "NYNetwork.h"//网络请求的kit
#import "HXBBaseTabBarController.h"//自定义的tabBarController
#import "HxbAdvertiseView.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    //配置网络
    [self setNetworkConfig];
    
    //创建根视图 并设置
    [self creatRootViewController];
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
    HXBBaseTabBarController *tabBarController = [[HXBBaseTabBarController alloc]init];
    tabBarController.selectColor = [UIColor redColor];
    tabBarController.normalColor = [UIColor grayColor];
    //数据
    NSArray *controllerNameArray = @[@"HxbHomeViewController",@"ViewController",@"HxbMyViewController"];
    NSArray *controllerTitleArray = @[@"首页",@"理财",@"我的"];
    NSArray *imageArray = @[@"1",@"1",@"1"];
    NSString *commonName = @"1";
    [tabBarController subViewControllerNames:controllerNameArray andNavigationControllerTitleArray:controllerTitleArray andImageNameArray:imageArray andSelectImageCommonName:commonName];
    
    _window.rootViewController = tabBarController;
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


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
