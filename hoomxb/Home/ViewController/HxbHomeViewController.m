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
#import "HXBMiddlekey.h"
#import "HXBVersionUpdateManager.h"



@interface HxbHomeViewController ()

@property (nonatomic, assign) BOOL isVersionUpdate;

@property (nonatomic, strong) HXBVersionUpdateViewModel *versionUpdateVM;

@property (nonatomic, strong) HXBRequestUserInfoViewModel *userInfoViewModel;

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
    
    [self registerRefresh];
    
    //判断是否显示设置手势密码
    [self gesturePwdShow];
    [self hiddenTabbarLine];
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


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self hideNavigationBar:animated];
    [self getData:YES];
    [self.homeView changeIndicationView:self.userInfoViewModel];
    [self.homeView showSecurityCertificationOrInvest:self.userInfoViewModel];
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[HXBVersionUpdateManager sharedInstance] show];
    
    [self transparentNavigationTitle];
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark Request
- (void)getData:(BOOL)isUPReloadData{
    kWeakSelf
    if (KeyChain.isLogin) {
        [KeyChain downLoadUserInfoNoHUDWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
            [self.homeView changeIndicationView:viewModel];
            [self.homeView showSecurityCertificationOrInvest:viewModel];
            self.userInfoViewModel = viewModel;
        } andFailure:^(NSError *error) {
            [self.homeView changeIndicationView:self.userInfoViewModel];
            [self.homeView showSecurityCertificationOrInvest:self.userInfoViewModel];
        }];
    } else {
        [self.homeView changeIndicationView:self.userInfoViewModel];
        [self.homeView showSecurityCertificationOrInvest:self.userInfoViewModel];
    }
    
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
        
    } andFailureBlock:^(NSError *error) {
        weakSelf.homeView.isStopRefresh_Home = YES;
        NSLog(@"%@",error);
        
    }];

}


///登录
- (void)loginOrSignUp
{
    [[NSNotificationCenter defaultCenter]postNotificationName:kHXBNotification_LoginSuccess_PushMYVC object:nil];
    
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
            planDetailsVC.isPlan = YES;
            planDetailsVC.isFlowChart = YES;
            [weakSelf.navigationController pushViewController:planDetailsVC animated:YES];
        };
        _homeView.tipButtonClickBlock_homeView = ^(){
            
            if (![KeyChain isLogin]) {
                //跳转登录注册
                [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowLoginVC object:nil];
            }else
            {
                //判断首页的header各种逻辑
                [HXBMiddlekey depositoryJumpLogicWithNAV:weakSelf.navigationController withOldUserInfo:weakSelf.userInfoViewModel];
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
                webViewVC.pageUrl = model.url;
                //            webViewVC.title = model.title;//mgmt标题
                [weakSelf.navigationController pushViewController:webViewVC animated:YES];
            }
        };
    }
    return _homeView;
}
@end
