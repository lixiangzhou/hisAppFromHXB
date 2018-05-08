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

@end

@implementation HXBPlanBuyResultViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];  
}

#pragma mark - UI

- (void)setUI {
    self.title = @"加入成功";
    self.view.backgroundColor = [UIColor whiteColor];
    self.isRedColorWithNavigationBar = YES;

    [self addChildViewController:self.commenResultVC];
    [self.view addSubview:self.commenResultVC.view];
}


#pragma mark - Action
- (void)setResultPageProperty:(HXBLazyCatResponseModel *)model {
    
    if ([model.result isEqualToString:@"success"]) {
        HXBLazyCatResultBuyModel *resultModel = (HXBLazyCatResultBuyModel *)model.data;
        self.commenResultVC.contentModel = [HXBCommonResultContentModel new];
        self.commenResultVC.contentModel.descHasMark = YES;
        self.commenResultVC.contentModel.descAlignment = NSTextAlignmentLeft;
        self.commenResultVC.contentModel.imageName = model.imageName;
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
        self.title = model.data.title;
        self.commenResultVC.contentModel.imageName = model.imageName;
        self.commenResultVC.contentModel.titleString = model.data.title;
        self.commenResultVC.contentModel.descString = model.data.content;
        self.commenResultVC.contentModel.firstBtnTitle = @"重新出借";
        kWeakSelf
        self.commenResultVC.contentModel.firstBtnBlock = ^(HXBCommonResultController *resultController) {
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        };
    }
}

- (HXBCommonResultController *)commenResultVC {
    if (!_commenResultVC) {
        _commenResultVC = [[HXBCommonResultController alloc] init];
    }
    return _commenResultVC;
}


- (void)leftBackBtnClick {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)dealloc {
    [self.commenResultVC removeFromParentViewController];
}

@end
