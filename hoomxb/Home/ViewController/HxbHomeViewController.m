//
//  HxbHomeViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/4/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbHomeViewController.h"
#import "HxbAdvertiseViewController.h"
#import "HXBBannerView.h"

@interface HxbHomeViewController ()
@property (nonatomic,strong)HXBBannerView *bannerView;
@end

@implementation HxbHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:true animated:true];
//    self.view.backgroundColor = [UIColor orangeColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToAd) name:@"pushtoad" object:nil];
//    HXBBannerView *bannersView = [[HXBBannerView alloc]initWithFrame:CGRectMake(0, 100, SCREEN_WIDTH, 100)];
    [self.view addSubview:self.bannerView];

}
///点击banner跳转
- (void)showBannerWebViewWithURL:(NSString *)linkUrl
{
//    HXBWKWebViewVC *webView = [[HXBWKWebViewVC alloc]initWithUrl:linkUrl];
//    [self.navigationController pushViewController:webView animated:YES];
}
- (void)showBannerWebViewWithModel:(BannerModel *)model
{
//    HXBWKWebViewVC *webView = [[HXBWKWebViewVC alloc]initWithBannersModel:model];
//    [self.navigationController pushViewController:webView animated:YES];
}

- (HXBBannerView *)bannerView
{
    if (!_bannerView) {
        _bannerView = [[HXBBannerView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_WIDTH * 9/16)];
        _bannerView.backgroundColor = COR1;
    }
    return _bannerView;
}

- (void)pushToAd {
    HxbAdvertiseViewController *adVc = [[HxbAdvertiseViewController alloc] init];
    [self.navigationController pushViewController:adVc animated:YES];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"pushtoad" object:nil];
}

@end
