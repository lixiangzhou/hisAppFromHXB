//
//  HxbHomeView.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/11.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//
#define kHXBFooterLabelHeight kScrAdaptationH(12)
#define kHXBBottomSpacing kScrAdaptationH(10)
#define kHXBInvestViewHeight (kScrAdaptationH(330) + kHXBBottomSpacing)
#define kHXBNotInvestViewHeight (kScrAdaptationH(299) + kHXBBottomSpacing)
#define kHXBNewbieHeight kScrAdaptationH(90)

#import "HxbHomeView.h"
#import "HXBHomePageHeadView.h"
#import "HXBHomePageProductCell.h"
#import "HXBNewbieProductCell.h"
#import "HXBHomeBaseModel.h"
#import "HXBHomeTitleModel.h"
#import "HXBHomeNewbieProductModel.h"
@interface HxbHomeView ()<UITableViewDelegate,UITableViewDataSource,HXBHomePageHeadViewDelegate>
@property (nonatomic, strong) HXBHomePageHeadView *headView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UILabel *footerLabel;
@property (nonatomic, strong) HxbHomePageViewModel *dataViewModel;
@property (nonatomic, strong) HXBBaseContDownManager *contDwonManager;

@property (nonatomic, strong) UIView *tableBackgroundView;

@property (nonatomic, strong) HXBCustomNavView *navView;

@end

@implementation HxbHomeView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.mainTableView];
        [self.mainTableView insertSubview:self.tableBackgroundView atIndex:0];
        [self addSubview:self.navView];
        [self setupUI];
    }
    return self;
}

#pragma mark - setupUI

- (void)setupUI {
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        //            make.top.equalTo(self);//.offset(kScrAdaptationH(30))
        make.bottom.equalTo(self).offset(-(HXBTabbarHeight)); //注意适配iPhone X
    }];
    UIImage *bgImage = [UIImage imageNamed:@"Home_top_bg"];
    CGSize imageSize = bgImage.size;
    CGFloat imageHeight = imageSize.height / (imageSize.width / kScreenWidth);
    [self.tableBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.height.offset(imageHeight);
        make.bottom.equalTo(self.headView.bannerView.mas_top);
    }];
}


#pragma mark Private Methods

/**
 判断业务逻辑
 */
- (void)changeIndicationView:(HXBRequestUserInfoViewModel *)viewModel
{
    CGFloat newbieViewHeight = 0;
    if (self.homeBaseViewModel.homeBaseModel.newbieProductData.img.length > 0) {
        newbieViewHeight = kHXBNewbieHeight;
    }
    kWeakSelf
    if (![KeyChain isLogin]) {
        //没有投资显示的界面
        self.headView.frame = CGRectMake(0, 0, kScreenWidth, kHXBNotInvestViewHeight + HXBStatusBarAdditionHeight + newbieViewHeight);
        [weakSelf.headView showNotValidatedView];
        return;
    }
    if([viewModel.userInfoModel.userInfo.hasEverInvest isEqualToString:@"1"]){
        //已经投资显示的界面
        self.headView.frame = CGRectMake(0, 0, kScreenWidth, kHXBInvestViewHeight + HXBStatusBarAdditionHeight + newbieViewHeight);
        [self.headView showAlreadyInvestedView];
    }else{
        //没有投资显示的界面
        self.headView.frame = CGRectMake(0, 0, kScreenWidth, kHXBNotInvestViewHeight + HXBStatusBarAdditionHeight + newbieViewHeight);
        [self.headView showNotValidatedView];
    }
    
}

- (void)showSecurityCertificationOrInvest:(HXBRequestUserInfoViewModel *)viewModel{
    [self.headView showSecurityCertificationOrInvest:viewModel];
}


#pragma mark HXBHomePageHeadViewDelegate Methods
- (void)resetHeadView
{
    self.mainTableView.tableHeaderView = self.headView;
}

- (void)setHomeBaseViewModel:(HxbHomePageViewModel *)homeBaseViewModel
{
    _homeBaseViewModel = homeBaseViewModel;
    if (homeBaseViewModel.homeBaseModel.homeTitle.baseTitle.length) {
        self.footerLabel.text = [NSString stringWithFormat:@"- %@ -",homeBaseViewModel.homeBaseModel.homeTitle.baseTitle];
        self.mainTableView.tableFooterView = self.footerView;
    }
    
    [self changeIndicationView:self.userInfoViewModel];
    self.headView.homeBaseModel = homeBaseViewModel.homeBaseModel;
    
    
    [self.mainTableView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull subView, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            [subView removeFromSuperview];
        }
    }];
    
    //更换数据源之前， 要先取消定时器，然后再重新设置， 否则由于线程同步问题会引发crash
    if(self.contDwonManager) {
        [self.contDwonManager cancelTimer];
        self.contDwonManager = nil;
    }
    [self creatCountDownManager];
    [self.mainTableView reloadData];
}

- (void)creatCountDownManager {
    kWeakSelf

    self.contDwonManager = [HXBBaseContDownManager countDownManagerWithCountDownStartTime: 3600 andCountDownUnit:1 andModelArray:self.homeBaseViewModel.homeDataList andModelDateKey:@"countDownLastStr" andModelCountDownKey:@"countDownString" andModelDateType:PYContDownManagerModelDateType_OriginalTime];
    
    [self.contDwonManager countDownWithChangeModelBlock:^(HxbHomePageModel_DataList *model, NSIndexPath *index) {
        if (weakSelf.homeBaseViewModel.homeDataList.count > index.row) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:index.row];
            HXBHomePageProductCell *cell = [self.mainTableView cellForRowAtIndexPath:indexPath];
            //更新列表中对应的字段值
            HxbHomePageModel_DataList* pageModel = [weakSelf.homeBaseViewModel.homeDataList safeObjectAtIndex:index.row];
            [pageModel setValue:model.countDownLastStr forKey:@"countDownLastStr"];
            [pageModel setValue:model.countDownString forKey:@"countDownString"];
            
            [cell setValue:pageModel.countDownString forKey:@"countDownString"];
        }
    }];
    self.contDwonManager.isAutoEnd = YES;
    //开启定时器
    [self.contDwonManager resumeTimer];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    self.navView.navAlpha = (scrollView.contentOffset.y)/(CGRectGetMaxY(self.tableBackgroundView.frame) - HXBStatusBarAndNavigationBarHeight);
}

#pragma mark UITableView Delegate/DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.homeBaseViewModel.homeDataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HxbHomePageModel_DataList *homePageModel_DataList = self.homeBaseViewModel.homeDataList[indexPath.section];
    if (homePageModel_DataList.novice == 1) {
        return kScrAdaptationH750(354);
    }
    else if (homePageModel_DataList.tag.length > 0) {
        return kScrAdaptationH750(526);
    } else
    {
        return kScrAdaptationH750(500);
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

     HxbHomePageModel_DataList *homePageModel_DataList = self.homeBaseViewModel.homeDataList[indexPath.section];
    if (homePageModel_DataList.novice == 1) {
        HXBNewbieProductCell * cell = [self newBieProductCellWithTableView:tableView];
        cell.homePageModel_DataList = homePageModel_DataList;
         return cell;
    }
    else {
        HXBHomePageProductCell *cell = (HXBHomePageProductCell *)[self planProductCellWithTableView:tableView];
        cell.homePageModel_DataList = homePageModel_DataList;
         return cell;
    }
    
    
   
}

- (HXBHomePageProductCell *)planProductCellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"planProductCelled";
    HXBHomePageProductCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HXBHomePageProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    kWeakSelf
    cell.purchaseButtonClickBlock = ^(){
        weakSelf.purchaseButtonClickBlock();
    };
    return cell;
}

- (HXBNewbieProductCell *)newBieProductCellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"newBieProductCelled";
    HXBNewbieProductCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[HXBNewbieProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.homeCellClickBlick) {
        self.homeCellClickBlick(indexPath);
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footer = [[UIView alloc] init];
    footer.backgroundColor = [UIColor clearColor];
    return footer;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.homeBaseViewModel.homeDataList.count > (section + 1)) {
        HxbHomePageModel_DataList *homePageModel_DataList = self.homeBaseViewModel.homeDataList[section + 1];
        if (homePageModel_DataList.novice == 1) {
            return 0.01;
        }
    }
    return kHXBBottomSpacing;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

#pragma mark SET/GET METHODS

- (void)setUserInfoViewModel:(HXBRequestUserInfoViewModel *)userInfoViewModel {
    _userInfoViewModel = userInfoViewModel;
    self.headView.userInfoViewModel = userInfoViewModel;
    [self changeIndicationView:userInfoViewModel];
    [self showSecurityCertificationOrInvest:userInfoViewModel];
}

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
        _headView = [[HXBHomePageHeadView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kHXBNotInvestViewHeight + HXBStatusBarAdditionHeight)];//199
        
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
        
        _headView.newbieAreaActionBlock = ^{
            if (weakSelf.newbieAreaActionBlock) {
                weakSelf.newbieAreaActionBlock();
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
        _footerView.frame = CGRectMake(0, 0, self.mainTableView.width, kHXBBottomSpacing + kHXBFooterLabelHeight);
        [_footerView addSubview:self.footerLabel];
        [self.footerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_footerView);
            make.centerX.equalTo(_footerView);
        }];
        
    }
    return _footerView;
}

- (UILabel *)footerLabel {
    if (!_footerLabel) {
        _footerLabel = [UILabel new];
        _footerLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
        _footerLabel.textColor = kHXBColor_999999_100;
    }
    return _footerLabel;
}

- (UITableView *)mainTableView
{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc] initWithFrame:CGRectZero style:(UITableViewStyleGrouped)];
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.backgroundColor = RGB(245, 245, 245);
        _mainTableView.showsVerticalScrollIndicator = NO;
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.tableHeaderView = self.headView;
        [HXBMiddlekey AdaptationiOS11WithTableView:_mainTableView];
        kWeakSelf
        [_mainTableView hxb_headerWithRefreshBlock:^{
            if (weakSelf.homeRefreshHeaderBlock) weakSelf.homeRefreshHeaderBlock();
        }];
    }
    return _mainTableView;
}

- (UIView *)tableBackgroundView {
    if (!_tableBackgroundView) {
        UIImage *bgImage = [UIImage imageNamed:@"Home_top_bg"];
        CGSize imageSize = bgImage.size;
        CGFloat imageHeight = imageSize.height / (imageSize.width / kScreenWidth);
        _tableBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, imageHeight)];
        UIImageView *bgImageView = [[UIImageView alloc] initWithImage:bgImage];
        bgImageView.contentMode = UIViewContentModeScaleAspectFit;
        [_tableBackgroundView addSubview:bgImageView];
        [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(_tableBackgroundView);
        }];
    }
    return _tableBackgroundView;
}

- (HXBCustomNavView *)navView {
    if (!_navView) {
        _navView = [[HXBCustomNavView alloc] init];
        _navView.backgroundColor = [UIColor whiteColor];
        _navView.title = @"红小宝";
        _navView.navAlpha = 0;
    }
    return _navView;
}

@end
