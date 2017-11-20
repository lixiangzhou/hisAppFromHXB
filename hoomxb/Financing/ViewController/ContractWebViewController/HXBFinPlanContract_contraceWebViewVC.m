//
//  HXBFinPlanContract_contraceWebViewVC.m
//  hoomxb
//
//  Created by HXB on 2017/5/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinPlanContract_contraceWebViewVC.h"
#import "HXBFinPlanContract_ContractWebView.h"
@interface HXBFinPlanContract_contraceWebViewVC ()
@property (nonatomic,strong) HXBFinPlanContract_ContractWebView *contractWebVeiw;
@end

@implementation HXBFinPlanContract_contraceWebViewVC

- (void) setURL:(NSString *)URL {
    _URL = URL;
    [self.contractWebVeiw loadURL:URL];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"";
    [self setUP];
    self.isColourGradientNavigationBar = YES;
}

/**
 再次获取网络数据
 */
- (void)getNetworkAgain
{
    [self.contractWebVeiw loadURL:self.URL];
}

/**
 是否显示导航栏右边的按钮
 */
- (void)setIsShowRightBtn:(BOOL)isShowRightBtn
{
    _isShowRightBtn = isShowRightBtn;
    if (isShowRightBtn) {
        [self setupRightBarBtn];
    } else {
        self.navigationItem.rightBarButtonItem = nil;
    }
}

- (void)setupRightBarBtn {
    UIButton *callBtn = [[UIButton alloc] init];
    [callBtn setImage:[UIImage imageNamed:@"phone"] forState:(UIControlStateNormal)];
    callBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
    [callBtn addTarget:self action:@selector(call) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *callBtnItem = [[UIBarButtonItem alloc] initWithCustomView:callBtn];
    self.navigationItem.rightBarButtonItem = callBtnItem;
}

- (void)call {
    [HXBAlertManager callupWithphoneNumber:kServiceMobile andWithTitle:@"红小宝客服电话" Message:kServiceMobile];
}

- (void)setUP {
    self.contractWebVeiw = [[HXBFinPlanContract_ContractWebView alloc]init];
    [self.view addSubview:self.contractWebVeiw];
    self.contractWebVeiw.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    [self.contractWebVeiw loadURL: self.URL];
    [self.contractWebVeiw addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:NULL];
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:@"title"])
    {
        if (object == self.contractWebVeiw) {
            self.title = [HXBMiddlekey H5Title:self.contractWebVeiw.title];
        }else
        {
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
            
        }
    }else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
- (void)dealloc
{
    [self.contractWebVeiw removeObserver:self forKeyPath:@"title"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
