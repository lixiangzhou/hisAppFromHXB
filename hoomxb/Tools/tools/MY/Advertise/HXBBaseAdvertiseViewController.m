//
//  HXBBaseAdvertiseViewController.m
//  hoomxb
//
//  Created by HXB on 2017/5/26.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseAdvertiseViewController.h"
#import "HXBAdvertisementManager.h"
#import "HxbAdvertiseView.h"
///关于广告加载的工具类
@interface HXBBaseAdvertiseViewController ()

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, copy) void(^dismissAdvertiseViewControllerBlock)();
@end

@implementation HXBBaseAdvertiseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setAdvertiseView];
    
}

- (void)setAdvertiseView{
    
    HxbAdvertiseView *advertiseView = [[HxbAdvertiseView alloc] initWithFrame:self.view.frame];
    [self.view addSubview:advertiseView];
    [advertiseView showAdvertiseWebViewWithBlock:^{
        [self setUPWebView];
    }];
    // 2.无论沙盒中是否存在广告图片，都需要重新调用广告接口，判断广告是否更新
    [HXBAdvertisementManager downLoadAdvertisementImageWithadvertisementImageURLStr:nil andDownLoadBlock:^(NSString *imagePath) {
        
    }];
    
    [advertiseView showAdvertiseWebViewWithBlock:^{
        [self setUPWebView];
    }];
    
    [advertiseView clickSkipButtonFuncWithBlock:^{
        if (self.dismissAdvertiseViewControllerBlock) {
            self.dismissAdvertiseViewControllerBlock();
        }
    }];
    //显示广告图片
    UIImage *image = [HXBAdvertisementManager getAdvertisementImagePath];
    if (image) {//显示广告
        advertiseView.advertiseImage = image;
        [advertiseView show];
    }else {//不显示直接跳转控制器
        NSLog(@"第一次加载广告图片，所以不显示");
        if (self.dismissAdvertiseViewControllerBlock) {
            self.dismissAdvertiseViewControllerBlock();
        }
    }
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


- (void) dismissAdvertiseViewControllerFunc: (void(^)())dismissAdvertiseViewControllerBlock{
    self.dismissAdvertiseViewControllerBlock = dismissAdvertiseViewControllerBlock;
}

@end
