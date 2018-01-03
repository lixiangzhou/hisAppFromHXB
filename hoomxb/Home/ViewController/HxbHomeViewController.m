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
#import "HXBFinancing_LoanDetailsViewController.h"
#import "HXBFin_DetailLoanTruansfer_ViewController.h"
#import "HXBNoticeViewController.h"
#import "HxbHomePageModel_DataList.h"
#import "HXBGesturePasswordViewController.h"

#import "HXBVersionUpdateRequest.h"//版本更新的请求
#import "HXBVersionUpdateViewModel.h"//版本更新的viewModel
#import "HXBVersionUpdateModel.h"//版本更新的Model
#import "HXBNoticeViewController.h"//公告界面
#import "HXBBannerWebViewController.h"//H5的Banner页面
#import "HXBMiddlekey.h"
#import "HXBHomePopViewManager.h"
#import "HXBRootVCManager.h"
#import "HXBVersionUpdateManager.h"

@interface HxbHomeViewController ()

@property (nonatomic, strong) HxbHomeView *homeView;

@property (nonatomic, assign) BOOL isVersionUpdate;

@property (nonatomic, strong) HXBVersionUpdateViewModel *versionUpdateVM;
@property (nonatomic, strong) HXBRequestUserInfoViewModel *userInfoViewModel;

@end

@implementation HxbHomeViewController

#pragma mark - Life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.homeView];
    [self setupUI];
    
    [self registerRefresh];
    
    [self hiddenTabbarLine];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[HXBHomePopViewManager sharedInstance] popHomeViewfromController:self];//展示首页弹窗
    [[HXBVersionUpdateManager sharedInstance] show];
    [self hideNavigationBar:animated];
    [self getData:YES];
    self.homeView.userInfoViewModel = self.userInfoViewModel;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self transparentNavigationTitle];
    self.tabBarController.tabBar.hidden = NO;
}

#pragma mark - UI
/**
 设置UI
 */
- (void)setupUI {
    [self.homeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.equalTo(self.view);
        make.top.equalTo(self.view);//.offset(kScrAdaptationH(30))
        make.bottom.equalTo(self.view); //注意适配iPhone X
    }];
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

#pragma mark Request
- (void)getData:(BOOL)isUPReloadData{
    kWeakSelf
    if (KeyChain.isLogin) {
        [KeyChain downLoadUserInfoNoHUDWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
            weakSelf.userInfoViewModel = viewModel;
            weakSelf.homeView.userInfoViewModel = weakSelf.userInfoViewModel;
        } andFailure:^(NSError *error) {
            if (weakSelf.userInfoViewModel) {
                weakSelf.homeView.userInfoViewModel = weakSelf.userInfoViewModel;
            } else {
                weakSelf.userInfoViewModel = [[HXBRequestUserInfoViewModel alloc] init];
                id responseObject = [PPNetworkCache httpCacheForURL:kHXBUser_UserInfoURL parameters:nil];
                HXBUserInfoModel *userInfoModel = [[HXBUserInfoModel alloc]init];
                [userInfoModel yy_modelSetWithDictionary:responseObject[@"data"]];
                userInfoModel.userAssets.availablePoint = HXBIdentifier;
                weakSelf.userInfoViewModel.userInfoModel = userInfoModel;
                weakSelf.homeView.userInfoViewModel = weakSelf.userInfoViewModel;
            }
        }];
    } else {
        self.homeView.userInfoViewModel = self.userInfoViewModel;
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
                [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowSignUpVC object:nil];
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
            [weakSelf pushToViewControllerWithModel:model];
        };
    }
    return _homeView;
}

// 点击benner跳转的方法(公告列表，详情，计划列表) H5
- (void)pushToViewControllerWithModel:(BannerModel *)model {
    
    __block HXBBaseViewController *vc;
    if ([model.type isEqualToString:@"native"]) {
        [model.link parseUrlParam:^(NSString *path, NSDictionary *paramDic) {
            if ([path isEqualToString:kNoticeVC]) { // 公告列表页
                HXBNoticeViewController *noticeVC = [HXBNoticeViewController new];
                vc = noticeVC;
            } else if ([path isEqualToString:kPlanDetailVC]) { // 计划详情
                HXBFinancing_PlanDetailsViewController *planVC = [HXBFinancing_PlanDetailsViewController new];
                planVC.planID = paramDic[@"productId"];
                planVC.isPlan = YES;
                planVC.isFlowChart = YES;
                vc = planVC;
            } else if ([path isEqualToString:kLoanDetailVC]) { // 散标详情
                HXBFinancing_LoanDetailsViewController *loadVC = [HXBFinancing_LoanDetailsViewController new];
                loadVC.loanID = paramDic[@"productId"];
                loadVC.isFlowChart = YES;
                vc = loadVC;
            } else if ([path isEqualToString:kLoanTransferDetailVC]) { // 债权详情
                HXBFin_DetailLoanTruansfer_ViewController *loanTruansferVC = [HXBFin_DetailLoanTruansfer_ViewController new];
                loanTruansferVC.loanID = paramDic[@"productId"];
                loanTruansferVC.isFlowChart = YES;
                vc = loanTruansferVC;
            } else if ([path isEqualToString:kPlan_fragment]) { // 计划列表
                [HXBRootVCManager manager].mainTabbarVC.selectedIndex = 1;
            } else if ([path isEqualToString:kRegisterVC]) { //跳转登录注册
                [[NSNotificationCenter defaultCenter] postNotificationName:kHXBNotification_ShowSignUpVC object:nil];
            } else {
                
            }
        }];
        
    } else if ([model.type isEqualToString:@"h5"]){
        if (model.url.length) {
            HXBBannerWebViewController *webViewVC = [[HXBBannerWebViewController alloc] init];
            webViewVC.pageUrl = model.url;
            vc = webViewVC;
        }
        
    } else if ([model.type isEqualToString:@"broswer"]) {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:model.link]]) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:model.link]];
        }
    }
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 设置状态栏
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}



@end
