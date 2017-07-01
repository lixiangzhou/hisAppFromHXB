//
//  HxbHomeView.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/11.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

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

@end

@implementation HxbHomeView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self addSubview:self.mainTableView];
//        [self.mainTableView addSubview:self.refreshControl];
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeIndicationView) name:IsLoginToReloadTableView object:nil];
//        [self addSubview:self.navigationBar];

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
    
    [KeyChain downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
        
        if ([viewModel.userInfoModel.userInfo.isAllPassed isEqualToString:@"0"]) {
            //没有投资显示的界面
            [weakSelf.headView showNotValidatedView];
        }else if ([viewModel.userInfoModel.userInfo.hasEverInvest isEqualToString:@"1"]){
            //已经投资显示的界面
             [weakSelf.headView showAlreadyInvestedView];
        }else
        {
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
    _footerLabel.text = homeBaseModel.homeTitle.baseTitle;
    self.headView.homeBaseModel = homeBaseModel;
    [self.mainTableView reloadData];
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
//    if (_network) {
//        return _hotSellDataList.count;
//    }else
//    {
//    NSLog(@"%lu",(unsigned long)_homeDataListViewModelArray.count);
//    return _homeDataListViewModelArray.count;
    return self.homeBaseModel.homePlanRecommend.count;
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 116;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (_network) {
//        TopProductModel * model = [_hotSellDataList objectAtIndex:indexPath.row];
//        if (model.requiredNew) {
//            if (indexPath.row == 0) {

    //            }else{
                static NSString *identifier = @"ProductCelled";
                HXBHomePageProductCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
                if (!cell) {
                    cell = [[HXBHomePageProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                    }
                   cell.homePageModel_DataList = self.homeBaseModel.homePlanRecommend[indexPath.row];
                   kWeakSelf
                   cell.purchaseButtonClickBlock = ^(){
                       weakSelf.purchaseButtonClickBlock();
                   };
//                cell.model = model;
//                NSLog(@"%ld",(long)model.status)
              return cell;
//        }else{
//            static NSString *identifier = @"ProductCell";
//            HXBHomePageProductCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//            if (!cell) {
//                cell = [[HXBHomePageProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//            }
//            cell.model = model;
//            NSLog(@"状态>>>>>>>%ld",(long)model.status);
//            return cell;
//        }
//    }else
//    {
//        NSString *identifier = @"nullCell";
//        HXBHomeNullTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//        if (!cell) {
//            cell = [[HXBHomeNullTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//        }
//        cell.refreshBtnClickBlock = ^() {
//            //            HXBHomePageVC *vc = (HXBHomePageVC *)next;
//            [self loadData];
//        };
//        return cell;
//    }
//        static NSString *identifier = @"ProductCelled";
//        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//        if (!cell) {
//            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//        }


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
        _headView = [[HXBHomePageHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH *9/16 + 110 + 33)];//199
        _headView.delegate = self;
        _headView.tipButtonClickBlock_homePageHeadView = ^(){
            if (weakSelf.tipButtonClickBlock_homeView) {
                weakSelf.tipButtonClickBlock_homeView();
            }
        };
    }
    return _headView;
}

- (UIView *)footerView
{
    if (!_footerView) {
        _footerView = [UIView new];
        _footerView.backgroundColor = BACKGROUNDCOLOR;
        _footerView.frame = CGRectMake(0, 0, _mainTableView.width, 48);
        
        _footerLabel = [UILabel new];
        _footerLabel.frame = CGRectMake(0, 0, _footerView.width, _footerView.height);
        _footerLabel.text = @"预期年利率不等于实际收益，投资需谨慎";
        _footerLabel.font = HXB_Text_Font(SIZ15);
        _footerLabel.textColor = COR11;
        _footerLabel.textAlignment = NSTextAlignmentCenter;
        _footerLabel.backgroundColor = CLEARCOLOR;
        
        [_footerView addSubview:_footerLabel];
    }
    return _footerView;
}

- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 49)];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = RGB(242, 242, 242);
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.tableHeaderView = self.headView;
        _mainTableView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
//        _mainTableView.hxb_behindHeader = [[HXBRefreshHeader alloc]initWithRefreshingTarget:self refreshingAction:@selector(loadData)];
//        _mainTableView.hxb_behindHeader.sloganView.hidden = NO;
        kWeakSelf
        [_mainTableView hxb_GifHeaderWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
            if (weakSelf.homeRefreshHeaderBlock) weakSelf.homeRefreshHeaderBlock();
        } andSetUpGifHeaderBlock:^(MJRefreshGifHeader *gifHeader) {
            
        }];
        _mainTableView.tableFooterView = self.footerView;
    }
    return _mainTableView;
}

- (HXBBannerView *)bannerView
{
    if (!_bannerView) {
        _bannerView = [[HXBBannerView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_WIDTH * 9/16)];
        _bannerView.backgroundColor = COR1;

//        BannerModel *bannerModel = [[BannerModel alloc] init];
//        bannerModel.title = @"banner";
//        bannerModel.picUrl = @"http://dl.bizhi.sogou.com/images/2012/03/14/124196.jpg";
//        bannerModel.linkUrl = @"http://blog.csdn.net/lkxasdfg/article/details/8660827";
//    
//        _bannerView.bannersModel = @[bannerModel,bannerModel,bannerModel];

    }
    return _bannerView;
}

//- (NSMutableArray<HxbHomePageViewModel_dataList *> *)homeDataListViewModelArray{
//    if (!_homeDataListViewModelArray) {
//        _homeDataListViewModelArray = [NSMutableArray array];
//    }
//    return _homeDataListViewModelArray;
//}
@end
