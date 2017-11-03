//
//  HxbHomeView.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/11.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#define kHXBBottomSpacing 10
#define kHXbdefaultSpacing 0

#import "HxbHomeView.h"
#import "HXBHomePageHeadView.h"
#import "HXBHomePageProductCell.h"
#import "HXBHomeBaseModel.h"
#import "HXBHomeTitleModel.h"
@interface HxbHomeView ()<UITableViewDelegate,UITableViewDataSource,HXBHomePageHeadViewDelegate>
@property (nonatomic, strong) HXBHomePageHeadView *headView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UILabel *footerLabel;
@property (nonatomic, strong) HxbHomePageViewModel *dataViewModel;

@property (nonatomic, strong) HXBBaseContDownManager *contDwonManager;
@end

@implementation HxbHomeView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.mainTableView];
        [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
//            make.top.equalTo(self);//.offset(kScrAdaptationH(30))
            make.bottom.equalTo(self).offset(-49); //注意适配iPhone X
        }];
//        [self.mainTableView addSubview:self.refreshControl];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeIndicationView) name:IsLoginToReloadTableView object:nil];
//        [self addSubview:self.navigationBar];
        [self creatCountDownManager];

    }
    return self;
}


#pragma mark Private Methods
//- (void)hideBulletinView
//{
//    if (self.headView) {
//        [self.headView hideBulletinView];
//    }
//}

- (void)showBulletinView
{
    if (self.headView) {
        [self.headView showBulletinView];
    }
}

/**
 判断业务逻辑
 */
- (void)changeIndicationView
{
    kWeakSelf
    if (![KeyChain isLogin]) {
        //没有投资显示的界面
        [weakSelf.headView showNotValidatedView];
        return;
    }
    
    [KeyChain downLoadUserInfoNoHUDWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
        
//        if ([viewModel.userInfoModel.userInfo.isAllPassed isEqualToString:@"0"]) {
//            //没有投资显示的界面
//            [weakSelf.headView showNotValidatedView];
//        }else if ([viewModel.userInfoModel.userInfo.hasEverInvest isEqualToString:@"1"]){
//            //已经投资显示的界面
//             [weakSelf.headView showAlreadyInvestedView];
//        }else
//        {
//            //没有投资显示的界面
//            [weakSelf.headView showNotValidatedView];
//        }
        
//        if (viewModel.userInfoModel.userInfo.isCreateEscrowAcc && [viewModel.userInfoModel.userInfo.hasEverInvest isEqualToString:@"1"] && [viewModel.userInfoModel.userInfo.isIdPassed isEqualToString:@"1"] && [viewModel.userInfoModel.userInfo.isCashPasswordPassed isEqualToString:@"1"] && [viewModel.userInfoModel.userInfo.hasBindCard isEqualToString:@"1"])

        if([viewModel.userInfoModel.userInfo.hasEverInvest isEqualToString:@"1"]){
            //已经投资显示的界面
            [weakSelf.headView showAlreadyInvestedView];
        }else{
            //没有投资显示的界面
            [weakSelf.headView showNotValidatedView];
        }
        
    } andFailure:^(NSError *error) {
        
    }];

}

- (void)showSecurityCertificationOrInvest{
    [self.headView showSecurityCertificationOrInvest];
}

- (void)endRefreshing
{
//    [self.mainTableView.hxb_behindHeader endRefreshing];
}

#pragma mark HXBHomePageHeadViewDelegate Methods
- (void)resetHeadView
{
    self.mainTableView.tableHeaderView = self.headView;
}

- (void)setDataModel:(HxbHomePageViewModel *)dataModel{
    _dataViewModel = dataModel;
}

- (void)setHomeBaseModel:(HXBHomeBaseModel *)homeBaseModel
{
    _homeBaseModel = homeBaseModel;
     UIEdgeInsets contentInset = self.mainTableView.contentInset;
    if (homeBaseModel.homeTitle.baseTitle.length) {
        _footerLabel.text = [NSString stringWithFormat:@"- %@ -",homeBaseModel.homeTitle.baseTitle];
        self.mainTableView.tableFooterView = self.footerView;
        contentInset.bottom = kHXBBottomSpacing;
        self.mainTableView.contentInset = contentInset;
    } else {
        self.mainTableView.tableFooterView = nil;
        contentInset.bottom = kHXbdefaultSpacing;
        self.mainTableView.contentInset = contentInset;
    }
    
    self.headView.homeBaseModel = homeBaseModel;
   
    [self.mainTableView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull subView, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            [subView removeFromSuperview];
        }
    }];
    self.contDwonManager.modelArray = self.homeBaseModel.homePlanRecommend;
    [self.mainTableView reloadData];
}

- (void)creatCountDownManager {
    kWeakSelf

    self.contDwonManager = [HXBBaseContDownManager countDownManagerWithCountDownStartTime: 3600 andCountDownUnit:1 andModelArray:self.homeBaseModel.homePlanRecommend andModelDateKey:@"countDownLastStr" andModelCountDownKey:@"countDownString" andModelDateType:PYContDownManagerModelDateType_OriginalTime];
    
    [self.contDwonManager countDownWithChangeModelBlock:^(HxbHomePageModel_DataList *model, NSIndexPath *index) {
        if (weakSelf.homeBaseModel.homePlanRecommend.count > index.row) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:index.row];
            HXBHomePageProductCell *cell = [self.mainTableView cellForRowAtIndexPath:indexPath];
            [cell setValue:model.countDownString forKey:@"countDownString"];
        }
    }];
    //要与服务器时间想比较
    //    self.contDwonManager.clientTime = [HXBDate       ]
    //    [self.contDwonManager stopWenScrollViewScrollBottomWithTableView:self.planListTableView];
    self.contDwonManager.isAutoEnd = true;
    //开启定时器
    [self.contDwonManager resumeTimer];
}

//- (void)setHomeDataListViewModelArray:(NSMutableArray<HxbHomePageViewModel_dataList *> *)homeDataListViewModelArray{
//    _homeDataListViewModelArray = homeDataListViewModelArray;
//    [_mainTableView reloadData];
//}
//- (void)loadData
//{
//    id next = [self nextResponder];
//    while (![next isKindOfClass:[HXBHomePageVC class]]) {
//        next = [next nextResponder];
//    }
//    if ([next isKindOfClass:[HXBHomePageVC class]]) {
//        HXBHomePageVC *vc = (HXBHomePageVC *)next;
//        [vc refreshHomePage];
//        //        [self getTopProductsData];
//    }
//}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView.contentOffset.y >= (SCREEN_WIDTH * 9)/16) {
        [UIView animateWithDuration:0.5 animations:^{
//            _navigationBar.alpha = 1.0f;
        } completion:^(BOOL finished) {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        }];
    }else{
        [UIView animateWithDuration:0.5 animations:^{
//            _navigationBar.alpha = 0;
        } completion:^(BOOL finished) {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        }];
    }
}

#pragma mark UITableView Delegate/DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.homeBaseModel.homePlanRecommend.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HxbHomePageModel_DataList *homePageModel_DataList = self.homeBaseModel.homePlanRecommend[indexPath.section];
    if (homePageModel_DataList.tag.length > 0) {
        return kScrAdaptationH750(526);
    }else
    {
        return kScrAdaptationH750(500);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *identifier = @"ProductCelled";
    HXBHomePageProductCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HXBHomePageProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.homePageModel_DataList = self.homeBaseModel.homePlanRecommend[indexPath.section];
    
    kWeakSelf
    cell.purchaseButtonClickBlock = ^(){
        weakSelf.purchaseButtonClickBlock();
    };
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.homeCellClickBlick) {
        self.homeCellClickBlick(indexPath);
    }
//    
//    if (_network) {
//        [tableView deselectRowAtIndexPath:indexPath animated:YES];
//        TopProductModel * model = [_hotSellDataList objectAtIndex:indexPath.row];
//        id next = [self nextResponder];
//        while (![next isKindOfClass:[HXBHomePageVC class]]) {
//            next = [next nextResponder];
//        }
//        if ([next isKindOfClass:[HXBHomePageVC class]]) {
//            HXBHomePageVC *vc = (HXBHomePageVC *)next;
//            [vc purchaseWithModel:model];
//        }
//    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer = [[UIView alloc] init];
    footer.backgroundColor = [UIColor clearColor];
    return footer;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return kScrAdaptationH(10);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}
#pragma mark SET/GET METHODS
//- (void)setBannersModel:(NSArray *)bannersModel
//{
//    _bannersModel = bannersModel;
//    self.headView.bannerView.bannersModel = bannersModel;
//}
//
//- (void)setBulletinsModel:(NSArray *)bulletinsModel
//{
//    _bulletinsModel = bulletinsModel;
//    self.headView.bulletinsModel = bulletinsModel;
//}
//
//-(void)setProfitModel:(AssetOverviewModel *)profitModel
//{
//    _profitModel = profitModel;
//    self.headView.profitModel = profitModel;
//    
//}

- (void)setIsStopRefresh_Home:(BOOL)isStopRefresh_Home{
    _isStopRefresh_Home = isStopRefresh_Home;
    if (isStopRefresh_Home) {
        [self.mainTableView.mj_footer endRefreshing];
        [self.mainTableView.mj_header endRefreshing];
    }
}


- (HXBHomePageHeadView *)headView
{
    if (!_headView) {
        kWeakSelf
        _headView = [[HXBHomePageHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kScrAdaptationH750(533))];//199
        
        _headView.delegate = self;
        _headView.tipButtonClickBlock_homePageHeadView = ^(){
            if (weakSelf.tipButtonClickBlock_homeView) {
                weakSelf.tipButtonClickBlock_homeView();
            }
        };
        
        _headView.noticeBlock = ^{
            if (weakSelf.noticeBlock) {
                weakSelf.noticeBlock();
            }
        };
        
        _headView.clickBannerImageBlock = ^(BannerModel *model) {
            if (weakSelf.clickBannerImageBlock) {
                weakSelf.clickBannerImageBlock(model);
            }
        };
    }
    return _headView;
}

- (UIView *)footerView
{
    if (!_footerView) {
        _footerView = [UIView new];
        _footerView.backgroundColor = [UIColor clearColor];
        _footerView.frame = CGRectMake(0, 0, _mainTableView.width, kScrAdaptationH(20));
        
        _footerLabel = [UILabel new];
        _footerLabel.frame = CGRectMake(0, 0, _footerView.width, _footerView.height);
//        _footerLabel.text = @"- 预期年利率不等于实际收益，投资需谨慎 -";
        _footerLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
        _footerLabel.textColor = RGB(184, 184, 184);
        _footerLabel.backgroundColor = RGB(245, 245, 245);
        
        [_footerView addSubview:_footerLabel];
        [_footerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_footerView);
        }];
        
    }
    return _footerView;
}

- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectZero];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = RGB(245, 245, 245);
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.tableHeaderView = self.headView;
        [HXBMiddlekey AdaptationiOS11WithTableView:_mainTableView];
        kWeakSelf
        [_mainTableView hxb_GifHeaderWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
            if (weakSelf.homeRefreshHeaderBlock) weakSelf.homeRefreshHeaderBlock();
        } andSetUpGifHeaderBlock:^(MJRefreshGifHeader *gifHeader) {

        }];
    }
    return _mainTableView;
}

//- (HXBBannerView *)bannerView
//{
//    if (!_bannerView) {
//        _bannerView = [[HXBBannerView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_WIDTH * 9/16)];
//        _bannerView.backgroundColor = [UIColor clearColor];
//    }
//    return _bannerView;
//}

//- (NSMutableArray<HxbHomePageViewModel_dataList *> *)homeDataListViewModelArray{
//    if (!_homeDataListViewModelArray) {
//        _homeDataListViewModelArray = [NSMutableArray array];
//    }
//    return _homeDataListViewModelArray;
//}
@end
