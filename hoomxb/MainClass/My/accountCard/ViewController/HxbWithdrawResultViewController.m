//
//  HxbWithdrawResultViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbWithdrawResultViewController.h"
#import "HXBBankCardModel.h"
#import "HXBPresentInformationView.h"
#import "HXBLazyCatResponseDelegate.h"
#import "HXBLazyCatResultWithdrawalModel.h"
#import "HXBLazyCatResponseModel.h"
#import "HXBAccountWithdrawViewModel.h"
#import "HXBWithdrawModel.h"
#import "HXBRootVCManager.h"

@interface HxbWithdrawResultViewController () <HXBLazyCatResponseDelegate, UITableViewDataSource>

@property (nonatomic, strong) HXBPresentInformationView *presentInformationView;

@property (nonatomic, weak) UIViewController *popVC;

@property (nonatomic, strong) NSArray *dataSource;

@property (nonatomic, strong) HXBLazyCatResponseModel *responseModel;
@end

@implementation HxbWithdrawResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"提现";
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 禁用全屏滑动手势
    ((HXBBaseNavigationController *)self.navigationController).enableFullScreenGesture = NO;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    ((HXBBaseNavigationController *)self.navigationController).enableFullScreenGesture = YES;
}

#pragma mark - HXBLazyCatResponseDelegate
- (void)setResultPageProperty:(HXBLazyCatResponseModel *)model {
    self.responseModel = model;
    
    self.contentModel = [HXBCommonResultContentModel new];
    self.contentModel.titleString = model.data.title;
    self.contentModel.descString = model.data.content;
    
    if ([model.result isEqualToString:@"success"]) {
        [self successResult];
    } else if ([model.result isEqualToString:@"error"]) {
        [self errorResult];
    } else if ([model.result isEqualToString:@"timeout"]) {
        [self timeoutResult];
    }
}

- (void)setResultPageWithPopViewControllers:(NSArray *)vcArray {
    self.popVC = vcArray.lastObject;
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellId"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cellId"];
    }
    
    cell.separatorInset = UIEdgeInsetsMake(0, -20, 0, 0);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dict = self.dataSource[indexPath.row];
    
    cell.textLabel.textColor = COR6;
    cell.textLabel.font = kHXBFont_30;
    cell.textLabel.text = dict[@"title"];
    cell.indentationWidth = 0;
    
    cell.detailTextLabel.textColor = COR10;
    cell.detailTextLabel.font = kHXBFont_30;
    cell.detailTextLabel.text = dict[@"desc"];
    
    return cell;
}

#pragma mark - Helper

- (void)successResult {
    self.contentModel.imageName = @"shouli";
    
    HXBLazyCatResultWithdrawalModel *model = (HXBLazyCatResultWithdrawalModel *)self.responseModel.data;

    NSString *bankInfo = [NSString stringWithFormat:@"尾号 %@", [model.cardNo substringFromIndex:model.cardNo.length - 4]];
    NSString *amount = [NSString stringWithFormat:@"%@",[NSString hxb_getPerMilWithDouble:[model.amount doubleValue]]];
    NSString *date = [[HXBBaseHandDate sharedHandleDate] stringFromDate:[NSDate dateWithTimeIntervalSince1970:model.arrivalTime.doubleValue / 1000] andDateFormat:@"yyyy-MM-dd"];

    self.dataSource = @[
                        @{@"title": @"银行卡", @"desc": bankInfo},
                        @{@"title": @"提现金额", @"desc": amount},
                        @{@"title": @"预计到账时间", @"desc": date},
                        ];
    kWeakSelf
    self.configCustomView = ^(UIView *customView) {
        [weakSelf setupTableViewIn:customView];
    };
    
    self.contentModel.firstBtnTitle = @"完成";
    self.contentModel.firstBtnBlock = ^(HXBCommonResultController *resultController) {
        [weakSelf toMine];
    };
}

- (void)errorResult {
    self.contentModel.imageName = @"failure";
    
    self.contentModel.firstBtnTitle = @"重新提现";
    kWeakSelf
    self.contentModel.firstBtnBlock = ^(HXBCommonResultController *resultController) {
        [weakSelf toMine];
    };
}

- (void)timeoutResult {
    self.contentModel.imageName = @"outOffTime";
    
    self.contentModel.firstBtnTitle = @"我的账户";
    kWeakSelf
    self.contentModel.firstBtnBlock = ^(HXBCommonResultController *resultController) {
        [weakSelf toMine];
    };
}

/// 到我的页面
- (void)toMine {
    [HXBRootVCManager manager].mainTabbarVC.selectedIndex = 2;
    [[HXBRootVCManager manager].mainTabbarVC.selectedViewController popToRootViewControllerAnimated:NO];
    [self.navigationController popToRootViewControllerAnimated:NO];
}

- (void)setupTableViewIn:(UIView *)view {
    UITableView *tableView = [UITableView new];
    tableView.scrollEnabled = NO;
    tableView.dataSource = self;
    tableView.rowHeight = 30;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(view);
        make.left.equalTo(@5);
        make.right.equalTo(@-5);
    }];
    
    [view mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@90);
    }];
}

#pragma mark - Action

- (void)leftBackBtnClick {
    [self toMine];
}


/*
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现结果";
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.presentInformationView];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 禁用全屏滑动手势
    ((HXBBaseNavigationController *)self.navigationController).enableFullScreenGesture = NO;
    self.isColourGradientNavigationBar = YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 恢复全屏滑动手势
    ((HXBBaseNavigationController *)self.navigationController).enableFullScreenGesture = YES;
}

#pragma mark - HXBLazyCatResponseDelegate
- (void)setResultPageProperty:(HXBLazyCatResponseModel *)model {
    HXBAccountWithdrawViewModel *viewModel = [HXBAccountWithdrawViewModel new];
    kWeakSelf
    [viewModel accountWithdrawaWithParameter:nil andRequestMethod:NYRequestMethodGet resultBlock:^(BOOL isSuccess) {
        if (isSuccess) {
            weakSelf.bankCardModel = viewModel.withdrawModel.bankCard;
            weakSelf.bankCardModel.amount = ((HXBLazyCatResultWithdrawalModel *)model.data).amount;
            
            weakSelf.presentInformationView.bankCardModel = weakSelf.bankCardModel;
        }
    }];
}

- (void)setResultPageWithPopViewControllers:(NSArray *)vcArray {
    self.popVC = vcArray.lastObject;
}

#pragma mark - Action
- (void)leftBackBtnClick {
    [self.navigationController popToViewController:self.popVC animated:YES];
}

#pragma mark - Lazy
- (HXBPresentInformationView *)presentInformationView
{
    if (!_presentInformationView) {
        kWeakSelf
        _presentInformationView = [[HXBPresentInformationView alloc] initWithFrame:self.view.bounds];
        _presentInformationView.completeBlock = ^{
            //            [[NSNotificationCenter defaultCenter] postNotificationName:@"提现充值" object:weakSelf];
            [weakSelf.navigationController popToRootViewControllerAnimated:YES];
        };
    }
    return _presentInformationView;
}
*/
@end
