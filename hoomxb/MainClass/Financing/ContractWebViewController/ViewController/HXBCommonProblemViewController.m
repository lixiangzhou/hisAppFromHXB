//
//  HXBCommonProblemViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/11/30.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBCommonProblemViewController.h"

@interface HXBCommonProblemViewController ()

@end

@implementation HXBCommonProblemViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    [self addObservers];
}

#pragma mark - Observers

- (void)addObservers {
    
}

#pragma mark - UI

- (void)setUI {
    [self setupRightBarBtn];
}

- (void)setupRightBarBtn {
    UIButton *callBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, kScrAdaptationH(18), kScrAdaptationH(18))];
    [callBtn setImage:[UIImage imageNamed:@"phone"] forState:(UIControlStateNormal)];
    callBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(30);
    [callBtn addTarget:self action:@selector(call) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem *callBtnItem = [[UIBarButtonItem alloc] initWithCustomView:callBtn];
    self.navigationItem.rightBarButtonItem = callBtnItem;
}

#pragma mark - Network


#pragma mark - Delegate Internal

#pragma mark -


#pragma mark - Delegate External

#pragma mark -


#pragma mark - Action
- (void)call {
    [HXBAlertManager callupWithphoneNumber:kServiceMobile andWithTitle:@"红小宝客服电话" Message:kServiceMobile];
}

#pragma mark - Setter / Getter / Lazy


#pragma mark - Helper


#pragma mark - Other


#pragma mark - Public

@end
