//
//  HxbAdvertiseViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/4/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbAdvertiseViewController.h"
#import "HXBAdvertisementManager.h"
#import "HxbAdvertiseView.h"
@interface HxbAdvertiseViewController ()

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, copy) void(^dismissAdvertiseViewControllerBlock)(BOOL isSingleLogin);
@property (nonatomic, assign) BOOL isSingleLogin;
@end

@implementation HxbAdvertiseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setAdvertiseView];
    
}

- (void)setAdvertiseView{
   
    HxbAdvertiseView *advertiseView = [[HxbAdvertiseView alloc] initWithFrame:self.view.frame];
    advertiseView.advertiseImage = [UIImage imageNamed:@"launch"];
    [self.view addSubview:advertiseView];
    [advertiseView showAdvertiseWebViewWithBlock:^{
        [self setUPWebView];
    }];
    // 2.无论沙盒中是否存在广告图片，都需要重新调用广告接口，判断广告是否更新
    NYBaseRequest *splashTRequest = [[NYBaseRequest alloc] init];
    splashTRequest.requestUrl = kHXBSplash;
    [splashTRequest startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSInteger status =  [responseObject[kResponseStatus] integerValue];
        
        self.isSingleLogin = status == kHXBCode_Enum_SingleLogin;
        
        if (status == 0) {
            NSString *imageURL = responseObject[kResponseData][@"url"];
            [HXBAdvertisementManager downLoadAdvertisementImageWithadvertisementImageURLStr:imageURL andDownLoadBlock:^(NSString *imagePath) {
                UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
                if (image) {//显示广告
                    advertiseView.advertiseImage = image;
                    [advertiseView show];
                }else {//不显示直接跳转控制器
                    NSLog(@"第一次加载广告图片，所以不显示");
                    if (self.dismissAdvertiseViewControllerBlock) {
                        self.dismissAdvertiseViewControllerBlock(self.isSingleLogin);
                    }
                }
            }];
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        if (self.dismissAdvertiseViewControllerBlock) {
            self.dismissAdvertiseViewControllerBlock(self.isSingleLogin);
        }
    }];
    
    [advertiseView showAdvertiseWebViewWithBlock:^{
        [self setUPWebView];
    }];
    
    [advertiseView clickSkipButtonFuncWithBlock:^{
        if (self.dismissAdvertiseViewControllerBlock) {
            self.dismissAdvertiseViewControllerBlock(self.isSingleLogin);
        }
    }];
//    //显示广告图片
//    UIImage *image = [HXBAdvertisementManager getAdvertisementImagePath];
//    if (image) {//显示广告
//        advertiseView.advertiseImage = image;
//        [advertiseView show];
//    }else {//不显示直接跳转控制器
//        NSLog(@"第一次加载广告图片，所以不显示");
//        if (self.dismissAdvertiseViewControllerBlock) {
//            self.dismissAdvertiseViewControllerBlock();
//        }
//    }
}
- (void)setUPWebView{
    self.title = @"点击进入广告链接";
    _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    _webView.backgroundColor = [UIColor whiteColor];
    if (!self.adUrl) {
        self.adUrl = @"http://www.hoomxb.com";
    }
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.adUrl]];
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
}

- (void)setAdUrl:(NSString *)adUrl{
    _adUrl = adUrl;
}


- (void) dismissAdvertiseViewControllerFunc: (void(^)(BOOL isSingleLogin))dismissAdvertiseViewControllerBlock{
    self.dismissAdvertiseViewControllerBlock = dismissAdvertiseViewControllerBlock;
}

@end
