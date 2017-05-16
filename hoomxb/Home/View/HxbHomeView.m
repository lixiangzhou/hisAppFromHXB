//
//  HxbHomeView.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/11.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbHomeView.h"
#import "HXBHomePageHeadView.h"

@interface HxbHomeView ()
@property (nonatomic, strong) HXBHomePageHeadView *headView;
@property (nonatomic, strong) UIView *footerView;
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
- (void)hideBulletinView
{
    if (self.headView) {
        [self.headView hideBulletinView];
    }
}

- (void)showBulletinView
{
    if (self.headView) {
        [self.headView showBulletinView];
    }
}

- (void)changeIndicationView
{
    if ([KeyChain isLogin]) {
        [self.headView hideLoginIndicationView];
    }else{
        [self.headView showLoginIndicationView];
    }
}

- (void)endRefreshing
{
//    [self.mainTableView.hxb_behindHeader endRefreshing];
}

#pragma mark HXBHomePageHeadViewDelegate Methods
- (void)resetHeadView
{
    NSLog(@"==========%f",self.headView.height);
    self.mainTableView.tableHeaderView = self.headView;
}

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
        return 1;
//    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 169;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (_network) {
//        TopProductModel * model = [_hotSellDataList objectAtIndex:indexPath.row];
//        if (model.requiredNew) {
//            if (indexPath.row == 0) {
//                HXBHomePageFreshCell *cell = [[HXBHomePageFreshCell alloc]init];
//                cell.model = model;
//                return cell;
//            }else{
//                static NSString *identifier = @"ProductCelled";
//                HXBHomePageProductCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
//                if (!cell) {
//                    cell = [[HXBHomePageProductCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
//                }
//                cell.model = model;
//                NSLog(@"%ld",(long)model.status);
//                return cell;
//            }
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
        static NSString *identifier = @"ProductCelled";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }

        return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
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

- (HXBHomePageHeadView *)headView
{
    if (!_headView) {
        _headView = [[HXBHomePageHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH *9/16 + 195)];//199
        _headView.delegate = self;
    }
    return _headView;
}

- (UIView *)footerView
{
    if (!_footerView) {
        _footerView = [UIView new];
        _footerView.backgroundColor = BACKGROUNDCOLOR;
        _footerView.frame = CGRectMake(0, 0, _mainTableView.width, 48);
        
        UILabel *label = [UILabel new];
        label.frame = CGRectMake(0, 0, _footerView.width, _footerView.height);
        label.text = @"预期年利率不等于实际收益，投资需谨慎";
        label.font = HXB_Text_Font(SIZ15);
        label.textColor = COR11;
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = CLEARCOLOR;
        
        [_footerView addSubview:label];
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
        _mainTableView.tableFooterView = self.footerView;
    }
    return _mainTableView;
}

- (HXBBannerView *)bannerView
{
    if (!_bannerView) {
        _bannerView = [[HXBBannerView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_WIDTH * 9/16)];
        _bannerView.backgroundColor = COR1;
    }
    return _bannerView;
}
@end
