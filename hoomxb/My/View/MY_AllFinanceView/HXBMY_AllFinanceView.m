//
//  HXBMY_AllFinanceView.m
//  hoomxb
//
//  Created by HXB on 2017/6/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMY_AllFinanceView.h"
#import "HXBMy_AllFinance_TableViewCell.h"
static NSString *const cellID = @"CELLID";
@interface HXBMY_AllFinanceView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *allFinanceTableView;
///散标债券收益
@property (nonatomic,strong) HXBBaseView_TwoLable_View *loanFinanceView;
///计划收益
@property (nonatomic,strong) HXBBaseView_TwoLable_View *planFinanceView;
/**
 数据源
 */
@property (nonatomic,strong) HXBRequestUserInfoViewModel *viewModel;
@end
@implementation HXBMY_AllFinanceView
- (void) setViewModel:(HXBRequestUserInfoViewModel *)viewModel {
    _viewModel = viewModel;
    [self.loanFinanceView setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
        viewModelVM.leftLabelStr = @"红利计划累计收益（元）";
        viewModelVM.rightLabelStr = viewModel.financePlanSumPlanInterest;
        return viewModelVM;
    }];
    [self.planFinanceView setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
        viewModelVM.leftLabelStr = @"散标债权累计收益（元）";
        viewModelVM.rightLabelStr = viewModel.lenderEarned;
        return viewModelVM;
    }];
    [self.allFinanceTableView reloadData];
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUPViews];
    }
    return self;
}

- (void)setUPViews {
    [self creatViews];
    [self setUPFrames];
    [[KeyChainManage sharedInstance] downLoadUserInfoWithSeccessBlock:^(HXBRequestUserInfoViewModel *viewModel) {
        self.viewModel = viewModel;
    } andFailure:^(NSError *error) {
        
    }];
}

- (void)creatViews {
    self.allFinanceTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.allFinanceTableView.delegate = self;
    self.allFinanceTableView.dataSource = self;
    
    [self.allFinanceTableView registerClass:[HXBMy_AllFinance_TableViewCell class] forCellReuseIdentifier:cellID];
    self.allFinanceTableView.tableFooterView = [[UIView alloc]init];
    
    self.planFinanceView = [[HXBBaseView_TwoLable_View alloc]init];
    self.loanFinanceView = [[HXBBaseView_TwoLable_View alloc]init];
    
    [self addSubview:self.allFinanceTableView];
    [self addSubview:self.planFinanceView];
    [self addSubview:self.loanFinanceView];
    
}

- (void)setUPFrames {
    [self.allFinanceTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH(500)));
    }];
    [self.planFinanceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.allFinanceTableView.mas_bottom);
        make.left.equalTo(self);
        make.right.equalTo(self.mas_centerX);
        make.bottom.equalTo(self);
    }];
    [self.loanFinanceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.allFinanceTableView.mas_bottom);
        make.left.equalTo(self.mas_centerX);
        make.right.equalTo(self);
        make.bottom.equalTo(self);
    }];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
        case 1:
            return 4;
        case 2:
            return 1;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    HXBMy_AllFinance_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    if (indexPath.section == 0) {
        [cell setUPValueWithLeftStr:@"资产总额（元）" andRightStr:self.viewModel.userInfoModel.userAssets.assetsTotal andTypeStr:nil];
    }
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                [cell setUPValueWithLeftStr:@"红利计划资产（元）"andRightStr:self.viewModel.userInfoModel.userAssets.financePlanAssets andTypeStr:nil];
                break;
            case 1:
                [cell setUPValueWithLeftStr:@"散标资产（元）" andRightStr:self.viewModel.userInfoModel.userAssets.lenderPrincipal andTypeStr:nil];
                break;
            case 2:
                [cell setUPValueWithLeftStr:@"可用金额（元）" andRightStr:self.viewModel.userInfoModel.userAssets.availablePoint andTypeStr:nil];
                break;
            case 3:
                [cell setUPValueWithLeftStr:@"冻结金额 (元)" andRightStr:self.viewModel.userInfoModel.userAssets.frozenPoint andTypeStr:nil];
                break;
                
            default:
                break;
        }
    }
    if (indexPath.section == 2) {
         [cell setUPValueWithLeftStr:@"累计收益 (元)" andRightStr:self.viewModel.userInfoModel.userAssets.earnTotal andTypeStr:nil];
    }
    return cell;
}
- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    CGFloat height = 0.0;
    if (section == 0) {
        height = 30;
    }
    if (section == 1) {
        height = 120;
    }
    if (section == 2) {
        height = 30;
    }
    return height;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat height = 0.0;
    if (indexPath.section == 0) {
        height = 30;
    }
    if (indexPath.section == 1) {
        switch (indexPath.row) {
            case 0:
                height = 30;
                break;
            case 1:
                height = 30;
                break;
            case 2:
                height = 30;
                break;
            case 3:
                height = 30;
                break;
                
            default:
                break;
        }
    }
    if (indexPath.section == 2) {
        height = 30;
    }
    return height;
}
@end
