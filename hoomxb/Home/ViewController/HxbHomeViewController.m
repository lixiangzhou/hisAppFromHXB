//
//  HxbHomeViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/4/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbHomeViewController.h"
#import "HxbAdvertiseViewController.h"
#import "HxbHomeRequest.h"
#import "HxbHomeRequest_dataList.h"
//#import "HxbSecurityCertificationViewController.h"
#import "HXBHomeBaseModel.h"
#import "HXBFinancing_PlanDetailsViewController.h"
#import "HxbHomePageModel_DataList.h"
#import "HXBGesturePasswordViewController.h"

#import "HXBVersionUpdateRequest.h"//版本更新的请求
#import "HXBVersionUpdateViewModel.h"//版本更新的viewModel
#import "HXBVersionUpdateModel.h"//版本更新的Model
#import "HXBNoticeViewController.h"//公告界面
#import "HXBBannerWebViewController.h"//H5的Banner页面
//#import "HXBOpenDepositAccountViewController.h"//开通存管账户
//#import "HxbWithdrawCardViewController.h"//绑卡界面
#import "HXBMiddlekey.h"
#import "HXBRootVCManager.h"



@interface HxbHomeViewController ()

@property (nonatomic, assign) BOOL isVersionUpdate;

@property (nonatomic, strong) HXBVersionUpdateViewModel *versionUpdateVM;

@end

@implementation HxbHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self hiddenTabbarLine];
    [self.view addSubview:self.homeView];
    [self.homeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.view);
        make.top.equalTo(self.view);//.offset(kScrAdaptationH(30))
        make.bottom.equalTo(self.view); //注意适配iPhone X
    }];
//    [self getData:YES];
//    [self.homeView changeIndicationView];
//    [self.homeView showSecurityCertificationOrInvest];
    self.automaticallyAdjustsScrollViewInsets = NO;
    //    [self getBannersWithCompletion:^{}];
    
    [self registerRefresh];
    
    //判断是否显示设置手势密码
    [self gesturePwdShow];
    [self hiddenTabbarLine];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(update) name:kHXBNotification_update object:nil];
}



// 去除tabBar上面的横线
- (void)hiddenTabbarLine {
    UIImageView *shadowImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.3)];
    shadowImage.backgroundColor = [UIColor colorWithWhite:0.952 alpha:0.8];
    [[HXB_XYTools shareHandle] createViewShadDow:shadowImage];    
    [[UITabBar appearance] setShadowImage:[UIImage new]];
    [self.tabBarController.tabBar addSubview:shadowImage];
    [self.tabBarController.tabBar setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc]init]];
}

/**
 手势密码逻辑
 */
- (void)gesturePwdShow
{
    if (KeyChain.gesturePwd.length == 0 && [KeyChain isLogin]) {
        HXBGesturePasswordViewController *gesturePasswordVC = [[HXBGesturePasswordViewController alloc] init];
        gesturePasswordVC.type = GestureViewControllerTypeSetting;
        [self.navigationController pushViewController:gesturePasswordVC animated:NO];
    }
}

/**
 下拉加载数据
 */
- (void)registerRefresh {
    kWeakSelf
    self.homeView.homeRefreshHeaderBlock = ^(){
        NSLog(@"首页下来加载数据");
        [weakSelf getData:YES];
    };
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(starCountDown) name:kHXBNotification_starCountDown object:nil];
}
//后台进入进入倒计时
- (void)starCountDown
{
     [self getData:YES];
}

//- (void)pushToAd {
//    HxbAdvertiseViewController *adVc = [[HxbAdvertiseViewController alloc] init];
//    [self.navigationController pushViewController:adVc animated:YES];
//}

-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kHXBNotification_update object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:true animated:false];
    [self getData:YES];
    
    [self.homeView changeIndicationView];
    [self.homeView showSecurityCertificationOrInvest];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:true animated:false];
}

/**
 检测版本更新
 */
- (void)checkVersionUpdate
{
    kWeakSelf
    NSString *version = [[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"];
    HXBVersionUpdateRequest *versionUpdateRequest = [[HXBVersionUpdateRequest alloc] init];
    [versionUpdateRequest versionUpdateRequestWitversionCode:version andSuccessBlock:^(id responseObject) {
        weakSelf.versionUpdateVM = [[HXBVersionUpdateViewModel alloc] init];
         weakSelf.versionUpdateVM.versionUpdateModel = [HXBVersionUpdateModel yy_modelWithDictionary:responseObject[@"data"]];
        [HXBAlertManager checkversionUpdateWith: weakSelf.versionUpdateVM.versionUpdateModel];
    } andFailureBlock:^(NSError *error) {
        
    }];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.navigationController setNavigationBarHidden:false animated:false];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (!self.isVersionUpdate) {
        self.isVersionUpdate = YES;
        static dispatch_once_t once;
        dispatch_once(&once, ^{
            [self checkVersionUpdate];
        });
    }
    //    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
}

#pragma mark Request
- (void)getData:(BOOL)isUPReloadData{
    kWeakSelf
    if (!self.homeView.homeBaseModel) {
        id responseObject = [PPNetworkCache httpCacheForURL:kHXBHome_HomeURL parameters:nil];
        if (responseObject) {
            NSDictionary *baseDic = [responseObject valueForKey:@"data"];
            self.homeView.homeBaseModel = [HXBHomeBaseModel yy_modelWithDictionary:baseDic];
        }
    }
    HxbHomeRequest *request = [[HxbHomeRequest alloc]init];
    [request homePlanRecommendWithIsUPReloadData:isUPReloadData andSuccessBlock:^(HxbHomePageViewModel *viewModel) {
        NSLog(@"%@",viewModel);
        weakSelf.homeView.homeBaseModel = viewModel.homeBaseModel;
        weakSelf.homeView.isStopRefresh_Home = YES;
        
        [self.homeView changeIndicationView];
        [self.homeView showSecurityCertificationOrInvest];
    } andFailureBlock:^(NSError *error) {
        weakSelf.homeView.isStopRefresh_Home = YES;
        NSLog(@"%@",error);
        
        [self.homeView changeIndicationView];
        [self.homeView showSecurityCertificationOrInvest];
    }];
//    NSString *userId = @"2110468";
//    [request homeAccountAssetWithUserID:userId andSuccessBlock:^(HxbHomePageViewModel *viewModel) {
//        [self.homeView setDataModel:viewModel];
//        NSLog(@"%@",viewModel);
//    } andFailureBlock:^(NSError *error) {
//        
//    }];
//    
//    HxbHomeRequest_dataList * homeRequest_dataList = [[HxbHomeRequest_dataList alloc]init];
//    [homeRequest_dataList homeDataListSuccessBlock:^(NSMutableArray<HxbHomePageViewModel_dataList *> *homeDataListViewModelArray) {
//        self.homeView.homeDataListViewModelArray = [NSMutableArray array];
//        self.homeView.homeDataListViewModelArray = homeDataListViewModelArray;
//    } andFailureBlock:^(NSError *error) {
//        
//    }];
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
- (void)update
{
    [HXBAlertManager checkversionUpdateWith: self.versionUpdateVM.versionUpdateModel];
}
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
    [[NSNotificationCenter defaultCenter]postNotificationName:kHXBNotification_LoginSuccess_PushMYVC object:nil];
    
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
        kWeakSelf
//        _homeView = [[HxbHomeView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _homeView = [[HxbHomeView alloc]initWithFrame:CGRectZero];

        /**
         点击cell中按钮的回调的Block
         */
        _homeView.purchaseButtonClickBlock = ^(){
            NSLog(@"点击cell中按钮的回调的Block");
        };
        /**
         点击cell中的回调的Block

         @param indexPath 点击cell的indexPath
         */
        _homeView.homeCellClickBlick = ^(NSIndexPath *indexPath){
            HXBFinancing_PlanDetailsViewController *planDetailsVC = [[HXBFinancing_PlanDetailsViewController alloc]init];
            UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"红利计划##" style:UIBarButtonItemStylePlain target:nil action:nil];
            weakSelf.navigationItem.backBarButtonItem = leftBarButtonItem;
            HxbHomePageModel_DataList *homePageModel = weakSelf.homeView.homeBaseModel.homePlanRecommend[indexPath.section];
            planDetailsVC.title = homePageModel.name;
            planDetailsVC.planID = homePageModel.ID;
            planDetailsVC.isPlan = true;
            planDetailsVC.isFlowChart = true;
            planDetailsVC.hidesBottomBarWhenPushed = true;
            [weakSelf.navigationController pushViewController:planDetailsVC animated:true];
        };
        _homeView.tipButtonClickBlock_homeView = ^(){
            
            if (![KeyChain isLogin]) {
                //跳转登录注册
                [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
            }else
            {
                //判断首页的header各种逻辑
//                [HXBMiddlekey depositoryJumpLogicWithNAV:weakSelf.navigationController];
                //跳转立即投资
                [HXBRootVCManager manager].mainTabbarVC.selectedIndex = 1;
            }
            
        };
        //公告的点击
        _homeView.noticeBlock = ^{
            HXBNoticeViewController *noticeVC = [[HXBNoticeViewController alloc] init];
            [weakSelf.navigationController pushViewController:noticeVC animated:YES];
        };
        
        _homeView.clickBannerImageBlock = ^(BannerModel *model) {
            if (model.url.length) {
                HXBBannerWebViewController *webViewVC = [[HXBBannerWebViewController alloc] init];
                webViewVC.url = model.url;
                //            webViewVC.title = model.title;//mgmt标题
                [weakSelf.navigationController pushViewController:webViewVC animated:true];
            }
        };
    }
    return _homeView;
}
@end
