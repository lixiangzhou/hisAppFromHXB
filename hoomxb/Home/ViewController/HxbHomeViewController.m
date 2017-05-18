//
//  HxbHomeViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/4/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbHomeViewController.h"
#import "HxbAdvertiseViewController.h"
#import "HxbHomeRequest.h"
#import "HxbHomeRequest_dataList.h"
@interface HxbHomeViewController ()

@end

@implementation HxbHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pushToAd) name:@"pushtoad" object:nil];
    [self.view addSubview:self.homeView];
    [self getData];
    [self.homeView changeIndicationView];
    [self.homeView showSecurityCertificationOrInvest];

    //    [self getBannersWithCompletion:^{}];
    
}

- (void)pushToAd {
    HxbAdvertiseViewController *adVc = [[HxbAdvertiseViewController alloc] init];
    [self.navigationController pushViewController:adVc animated:YES];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"pushtoad" object:nil];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillWillappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    //    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
}

#pragma mark Request
- (void)getData{
    HxbHomeRequest *request = [[HxbHomeRequest alloc]init];
    NSString *userId = @"2110468";
    [request homeAccountAssetWithUserID:userId andSuccessBlock:^(HxbHomePageViewModel *viewModel) {
        [self.homeView setDataModel:viewModel];
        NSLog(@"%@",viewModel);
    } andFailureBlock:^(NSError *error) {
        
    }];
    
    HxbHomeRequest_dataList * homeRequest_dataList = [[HxbHomeRequest_dataList alloc]init];
    [homeRequest_dataList homeDataListSuccessBlock:^(NSMutableArray<HxbHomePageViewModel_dataList *> *homeDataListViewModelArray) {
        self.homeView.homeDataListViewModelArray = [NSMutableArray array];
        self.homeView.homeDataListViewModelArray = homeDataListViewModelArray;
    } andFailureBlock:^(NSError *error) {
        
    }];
}
//- (void)getBannersWithCompletion:(void(^)())completion
//{
//    [self.homePageView getTopProductsData:NO];
//    BannersAPI *api = [[BannersAPI alloc]init];
//    [api startWithSuccess:^(NYBaseRequest *request, id responseObject) {
//        
//        GetBannersModel *model = [GetBannersModel yy_modelWithJSON:responseObject];
//        self.homePageView.bannersModel = model.banners;
//        
//        BulletinsAPI * bulletinsAPI = [[BulletinsAPI alloc]init];
//        [bulletinsAPI startWithSuccess:^(NYBaseRequest *request, id responseObject) {
//            completion();
//            
//            GetBulletinsModel * getBulletinsModel = [GetBulletinsModel yy_modelWithJSON:responseObject];
//            //            BulletinsModel *model = [[BulletinsModel alloc]init];
//            //            model.content = @"";
//            //            model.linkUrl = @"skdjfsl";
//            //            getBulletinsModel.bulletins = @[model,model,model];
//            if (!getBulletinsModel.bulletins || getBulletinsModel.bulletins.count==0) {
//                [self.homePageView hideBulletinView];
//                return ;
//            }
//            
//            NSMutableArray * contentArr = [NSMutableArray arrayWithCapacity:0];
//            [getBulletinsModel.bulletins enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//                BulletinsModel *model = (BulletinsModel *)obj;
//                [contentArr addObject:model];
//            }];
//            [self.homePageView showBulletinView];
//            self.homePageView.bulletinsModel = contentArr;
//            
//            
//        } failure:^(NYBaseRequest *request, NSError *error) {
//            [self.homePageView hideBulletinView];
//            completion();
//        }];
//        
//    } failure:^(NYBaseRequest *request, NSError *error) {
//        
//        [self.homePageView hideBulletinView];
//        NSArray * nullModel = nil;
//        self.homePageView.bannersModel = nullModel;
//        completion();
//    }];
//}

#pragma mark Action
///刷新首页
- (void)refreshHomePage
{
//    [self getBannersWithCompletion:^{
//        [self.homePageView endRefreshing];
//    }];
}

///登录
- (void)loginOrSignUp
{
    [[NSNotificationCenter defaultCenter]postNotificationName:ShowLoginVC object:nil];
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

// 点击bulletin web调整
- (void)showBulletinWebViewWithURL:(NSString *)linkUrl
{
//    HXBWKWebViewVC *webView = [[HXBWKWebViewVC alloc]initWithUrl:linkUrl];
//    [self.navigationController pushViewController:webView animated:YES];
}

///进入产品详情页
//- (void)purchaseWithModel:(TopProductModel *)model
//{
//    if (model.category == FreeTarget) {
//        HXBMoneyManageDetailsViewController * moneyDetailVC = [[HXBMoneyManageDetailsViewController alloc]initWithProductId:model.id AndTitle:model.name AndStatus:model.status AndCategory:model.category];
//        [self.navigationController pushViewController:moneyDetailVC animated:YES];
//    }else if (model.category == PlanProduct) {
//        HXBPlanProductDetailsViewController * moneyDetailVC = [[HXBPlanProductDetailsViewController alloc]initWithProductId:model.id AndTitle:model.name AndStatus:model.status AndCategory:model.category];
//        [self.navigationController pushViewController:moneyDetailVC animated:YES];
//    }
//}

///点击品牌介绍
- (void)showIntroduceView
{
    [self showBannerWebViewWithURL:AboutUs];
    
}

///点击安全保障
- (void)showSafetyGuaranteeView
{
    [self showBannerWebViewWithURL:SecurityProtect];
}

///点击邀请好友
- (void)showInviteFriendsView
{
//    if ([KeyChain isLogin]) {
//        HXBShareQrVersionVC *inviteVC = [[HXBShareQrVersionVC alloc] init];
//        [self.navigationController pushViewController:inviteVC animated:YES];
//    }else{
//        [[NSNotificationCenter defaultCenter]postNotificationName:ShowLoginVC object:nil];
//    }
}




#pragma mark Get Methods

- (HxbHomeView *)homeView{
    if (!_homeView) {
        _homeView = [[HxbHomeView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _homeView;
}
@end
