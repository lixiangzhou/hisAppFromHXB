//
//  HXBPlanBuyResultViewController.m
//  hoomxb
//
//  Created by HXB-xiaoYang on 2018/4/27.
//Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBPlanBuyResultViewController.h"
#import "HXBCommonResultController.h"
#import "HXBLazyCatResponseDelegate.h"
#import "HXBLazyCatResponseModel.h"
#import "HXBLazyCatResultBuyModel.h"
#import "HXBUMengShareManager.h"

@interface HXBPlanBuyResultViewController ()<HXBLazyCatResponseDelegate>

@property (nonatomic, strong) HXBCommonResultController *commenResultVC;
@property (nonatomic, strong) HXBLazyCatResponseModel *model;

@end

@implementation HXBPlanBuyResultViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setData];
    [self setUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    ((HXBBaseNavigationController *)self.navigationController).enableFullScreenGesture = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    ((HXBBaseNavigationController *)self.navigationController).enableFullScreenGesture = YES;
}
#pragma mark - UI

- (void)setUI {
    self.view.backgroundColor = [UIColor whiteColor];
    self.isRedColorWithNavigationBar = YES;

    [self addChildViewController:self.commenResultVC];
    [self.view addSubview:self.commenResultVC.view];
}

- (void)setData {
    
    self.title = self.model.data.title;
    
    if ([_model.result isEqualToString:@"success"]) {
        
        HXBLazyCatResultBuyModel *resultModel = (HXBLazyCatResultBuyModel *)_model.data;
        
        self.commenResultVC.contentModel.imageName = self.model.imageName;
        self.commenResultVC.contentModel.titleString = resultModel.title;
        self.commenResultVC.contentModel.descString = resultModel.content;
        self.commenResultVC.contentModel.firstBtnTitle = @"查看我的出借";
        
        self.commenResultVC.contentModel.secondBtnTitle = resultModel.isInviteActivityShow ? resultModel.inviteActivityDesc : @"";
        
        kWeakSelf
        self.commenResultVC.contentModel.firstBtnBlock = ^(HXBCommonResultController *resultController) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowMYVC_PlanList object:nil];
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        };
        
        if (self.commenResultVC.contentModel.secondBtnTitle) {
            self.commenResultVC.contentModel.secondBtnBlock = ^(HXBCommonResultController *resultController) {
                [HXBUmengManagar HXB_clickEventWithEnevtId:kHXBUmeng_inviteSucess_share];
                [HXBUMengShareManager showShareMenuViewInWindowWith:nil];
            };
        }
    } else {
        self.commenResultVC.contentModel.imageName = self.model.imageName;
        self.commenResultVC.contentModel.titleString = self.model.data.title;
        self.commenResultVC.contentModel.descString = self.model.data.content;
        self.commenResultVC.contentModel.firstBtnTitle = [self.model.result isEqualToString:@"timeout"] ? @"查看账户" : @"重新出借";
        kWeakSelf
        self.commenResultVC.contentModel.firstBtnBlock = ^(HXBCommonResultController *resultController) {
            if ([weakSelf.model.result isEqualToString:@"timeout"]) {
                [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowMyVC object:nil];  //跳回我的页面
            } else {
                [weakSelf.navigationController popToRootViewControllerAnimated:YES];
            }
        };
    }
}

#pragma mark - Action
- (void)setResultPageProperty:(HXBLazyCatResponseModel *)model {
    _model = model;
}

- (HXBCommonResultController *)commenResultVC {
    if (!_commenResultVC) {
        _commenResultVC = [[HXBCommonResultController alloc] init];
        _commenResultVC.contentModel = [HXBCommonResultContentModel new];
        _commenResultVC.contentModel.descHasMark = YES;
        _commenResultVC.contentModel.descAlignment = NSTextAlignmentLeft;
    }
    return _commenResultVC;
}


- (void)leftBackBtnClick {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
