 //
//  HxbMyView.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbMyView.h"
#import "HxbMyViewHeaderView.h"
#import "AppDelegate.h"
#import "HxbMyViewController.h"
#import "HXBMY_PlanListViewController.h"///plan 列表的VC
#import "HXBMY_LoanListViewController.h"///散标 列表的VC
#import "HXBMY_CapitalRecordViewController.h"//资产记录
#import "HXBMyHomeViewCell.h"

@interface HxbMyView ()
<
UITableViewDelegate,
UITableViewDataSource,
MyViewHeaderDelegate
>
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) HxbMyViewHeaderView *headerView;
//@property (nonatomic, strong) UIButton *signOutButton;
@property (nonatomic, copy) void(^clickAllFinanceButtonWithBlock)(UILabel *button);
@end

@implementation HxbMyView
///点击了 总资产
- (void)clickAllFinanceButtonWithBlock: (void(^)(UILabel * button))clickAllFinanceButtonBlock{
    self.clickAllFinanceButtonWithBlock = clickAllFinanceButtonBlock;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.mainTableView];

    }
    return self;
}


/**
 数据模型的set方法
 */
- (void)setUserInfoViewModel:(HXBRequestUserInfoViewModel *)userInfoViewModel
{
    _userInfoViewModel = userInfoViewModel;
    self.headerView.userInfoViewModel = userInfoViewModel;
}

- (void)didClickLeftHeadBtn:(UIButton *)sender{
    [self.delegate didLeftHeadBtnClick:sender];
   
}
-(void)didClickTopUpBtn:(UIButton *)sender{
    [self.delegate didClickTopUpBtn:sender];
}

- (void)didClickWithdrawBtn:(UIButton *)sender{
    [self.delegate didClickWithdrawBtn:sender];
}
- (void)didClickRightHeadBtn{
    
}
////登出按钮事件
//- (void)signOutButtonButtonClick:(UIButton *)sender{
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您确定要退出登录吗？" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
//        NSLog(@"%@",action.title);
//    }];
//    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
//        [KeyChain signOut];
//        [(HXBBaseTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController setSelectedIndex:0];
//    }];
//    [alertController addAction:cancelAction];
//    [alertController addAction:okAction];
//     HxbMyViewController *vc = (HxbMyViewController *)[UIResponder findNextResponderForClass:[HxbMyViewController class] ByFirstResponder:self];
//    [vc presentViewController:alertController animated:YES completion:nil];
//    
//    //    UIViewController *VC =[[UIViewController alloc]init];
//    //    VC.view.backgroundColor = [UIColor redColor];
//    //    [self.navigationController pushViewController:VC animated:true];
//}

- (void)setIsStopRefresh_Home:(BOOL)isStopRefresh_Home{
    _isStopRefresh_Home = isStopRefresh_Home;
    if (isStopRefresh_Home) {
        [self.mainTableView.mj_footer endRefreshing];
        [self.mainTableView.mj_header endRefreshing];
    }
}

#pragma TableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {//第一组： plan
        if (indexPath.row == 0) {
            HxbMyViewController *vc = (HxbMyViewController *)[UIResponder findNextResponderForClass:[HxbMyViewController class] ByFirstResponder:self];
            HXBMY_PlanListViewController *myPlanViewController = [[HXBMY_PlanListViewController alloc]init];
            [vc.navigationController pushViewController:myPlanViewController animated:YES];
        }else
        {
            HxbMyViewController *VC = (HxbMyViewController *)[UIResponder findNextResponderForClass:[HxbMyViewController class] ByFirstResponder:self];
            HXBMY_LoanListViewController *loanListViewController = [[HXBMY_LoanListViewController alloc]init];
            [VC.navigationController pushViewController:loanListViewController animated:true];
        }
    }
    if (indexPath.section == 1) {
        HxbMyViewController *VC = (HxbMyViewController *)[UIResponder findNextResponderForClass:[HxbMyViewController class] ByFirstResponder:self];
        HXBMY_CapitalRecordViewController *capitalRecordViewController = [[HXBMY_CapitalRecordViewController alloc]init];
        [VC.navigationController pushViewController:capitalRecordViewController animated:true];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kScrAdaptationH(10);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    return 0.1;
}

#pragma TableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *celledStr = @"celled";
    HXBMyHomeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:celledStr];
    if (cell == nil) {
        cell = [[HXBMyHomeViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:celledStr];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"红利计划资产";
            cell.imageView.svgImageString = @"hongli.svg";
            cell.isShowLine = YES;
        }else
        {
            cell.textLabel.text = @"散标债权资产";
            cell.imageView.svgImageString = @"sanbiao.svg";
        }
        
    }else if (indexPath.section == 1){
        cell.textLabel.text = @"交易记录";
        cell.imageView.svgImageString = @"trading_record.svg";
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }else
    {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (UITableView *)mainTableView{
    if (!_mainTableView) {
        _mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStyleGrouped];
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.tableHeaderView = self.headerView;
        _mainTableView.tableHeaderView.userInteractionEnabled = YES;
        _mainTableView.backgroundColor = kHXBColor_BackGround;
        kWeakSelf
        [_mainTableView hxb_GifHeaderWithIdleImages:nil andPullingImages:nil andFreshingImages:nil andRefreshDurations:nil andRefreshBlock:^{
            if (weakSelf.homeRefreshHeaderBlock) weakSelf.homeRefreshHeaderBlock();
        } andSetUpGifHeaderBlock:^(MJRefreshGifHeader *gifHeader) {
            
        }];
    }
    return _mainTableView;
}

- (HxbMyViewHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[HxbMyViewHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kScrAdaptationH(276))];
        _headerView.delegate = self;
        _headerView.userInteractionEnabled = YES;
        kWeakSelf
        [_headerView clickAllFinanceButtonWithBlock:^(UILabel * _Nullable button) {
            if (weakSelf.clickAllFinanceButtonWithBlock) {
                weakSelf.clickAllFinanceButtonWithBlock(button);
            }
        }];
    }
    return _headerView;
}

////登出按钮
//- (UIButton *)signOutButton{
//    if (!_signOutButton) {
//        _signOutButton = [UIButton btnwithTitle:@"Sign Out" andTarget:self andAction:@selector(signOutButtonButtonClick:) andFrameByCategory:CGRectMake(20, SCREEN_HEIGHT - 100, SCREEN_WIDTH - 40, 44)];
//    }
//    return _signOutButton;
//}

@end
