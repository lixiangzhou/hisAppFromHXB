//
//  HXBRiskAssessmentViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/7/4.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBRiskAssessmentViewController.h"
#import "WebViewJavascriptBridge.h"
@interface HXBRiskAssessmentViewController ()

@property (nonatomic,copy) void(^popBlock)(NSString *type);

@end

@implementation HXBRiskAssessmentViewController

#pragma mark - Life Cycle

- (instancetype)init
{
    self = [super init];
    if (self) {
         self.pageUrl = kHXBH5_RiskEvaluationURL;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self setupRightBarBtn];
    //注册H5调用原生的方法
    [self registJSBridge];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.isColourGradientNavigationBar = YES;
}

#pragma mark - 注册H5事件
- (void)registJSBridge{
    kWeakSelf
    [self registJavascriptBridge:@"riskEvaluation" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"testObjcCallback called: %@", data);
        //如果外部实现了这个方法，那就直接执行这个block
        if (weakSelf.popBlock) {
            NSString *type = data[@"riskType"];
            weakSelf.popBlock(type);
            return;
        }
        __block UIViewController *vc = nil;
        [weakSelf.navigationController.viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:NSClassFromString(@"HxbAccountInfoViewController")]) {
                vc = obj;
                *stop = YES;
            }
        }];
        [weakSelf.navigationController popToViewController:vc animated:YES];
    }];
}


#pragma mark - UI
- (void)setupRightBarBtn{
    UIButton *rightBackBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScrAdaptationW(50), 35)];
    [rightBackBtn setTitle:@"跳过" forState:UIControlStateNormal];
    // 让按钮内部的所有内容左对齐
    rightBackBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [rightBackBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [rightBackBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBackBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
    // 修改导航栏左边的item
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBackBtn];
    rightBackBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    
}

#pragma mark - Action
- (void)dismiss{
    [self callHandler:@"skipTest" data:nil];
}

- (void)popWithBlock:(void (^)(NSString *type))popBlock {
    self.popBlock = popBlock;
}

@end
