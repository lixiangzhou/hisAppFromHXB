//
//  HXBMY_PlanDetailView.m
//  hoomxb
//
//  Created by HXB on 2017/5/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMY_PlanDetailView.h"
#import "HXBMYViewModel_PlanDetailViewModel.h"

#import "HXBMY_PlanDtetail_Topcell.h"//顶部的cell
#import "HXBMY_PlanDetail_InfoCell.h"//中部的信息的Cell
#import "HXBMY_PlanDetail_TypeCell.h"//底部的左右 都有lable的cell
#import "HXBMY_PlanInvestmentRecordCell.h"//投资记录

///红利详情 顶部的cell
static NSString *kTOPCELLID = @"kTOPCELLID";
///中部的信息的Cell
static NSString *kINFOCELLID = @"kINFOCELLID";
///底部的左右 都有lable的cell
static NSString *kTYPECELLID = @"kTYPECELLID";
///投资记录的cell
static NSString *kINVESTMENTRECORD = @"kINVESTMENTRECORD";


///收益方式
static NSString *kTYPECELLID_INCOMETYPE = @"收益处理方式";
///合同
static NSString *kTYPTCELLID_CONTRACT = @"合同";
///投资记录
static NSString *kINVESTMENTRECORDCELL_INVESTMENTRECORD = @"投资记录";


@interface HXBMY_PlanDetailView ()
<
UITableViewDelegate,
UITableViewDataSource
>

@end
@implementation HXBMY_PlanDetailView
- (void)setPlanDetailViewModel:(HXBMYViewModel_PlanDetailViewModel *)planDetailViewModel {
    _planDetailViewModel = planDetailViewModel;
    [self reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self setUP];
    }
    return self;
}

- (void)setUP {
    self.dataSource = self;
    self.delegate = self;
    
    [self registerClass:[HXBMY_PlanDtetail_Topcell class] forCellReuseIdentifier:kTOPCELLID];
    [self registerClass:[HXBMY_PlanDetail_InfoCell class] forCellReuseIdentifier:kINFOCELLID];
    [self registerClass:[HXBMY_PlanDetail_TypeCell class] forCellReuseIdentifier:kTYPECELLID];
    [self registerClass:[HXBMY_PlanInvestmentRecordCell class] forCellReuseIdentifier:kINVESTMENTRECORD];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (!self.planDetailViewModel) {
        return 0;
    }
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 4;
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self handleTableViewCellWithTableView:tableView andIndetfier:indexPath];
}

- (UITableViewCell *)handleTableViewCellWithTableView: (UITableView *)tableView andIndetfier: (NSIndexPath *)indexPath {
    if (!indexPath.section) {
        HXBMY_PlanDtetail_Topcell *cell = [tableView dequeueReusableCellWithIdentifier:kTOPCELLID forIndexPath:indexPath];
        cell.planDetailViewModel = self.planDetailViewModel;
        return cell;
    }
    return  [self handleIndexPathTwoSctionWithTableView:tableView andRow:indexPath];
}
- (UITableViewCell *)handleIndexPathTwoSctionWithTableView:(UITableView *)tableView andRow: (NSIndexPath*)indexPath {
    switch (indexPath.row) {
        case 0:{
            HXBMY_PlanDetail_InfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kINFOCELLID forIndexPath:indexPath];
            cell.planDetailViewModel = self.planDetailViewModel;
            return cell;
        }
        case 1: {
            HXBMY_PlanDetail_TypeCell *typeCell = [tableView dequeueReusableCellWithIdentifier:kTYPECELLID forIndexPath:indexPath];
            [typeCell setupValueWithModel:self.planDetailViewModel andLeftStr:kTYPECELLID_INCOMETYPE andRightStr:self.planDetailViewModel.cashType andRightColor:[UIColor blueColor]];
            return typeCell;
        }
        case 2:{
            HXBMY_PlanDetail_TypeCell *typeCell = [tableView dequeueReusableCellWithIdentifier:kTYPECELLID forIndexPath:indexPath];
            [typeCell setupValueWithModel:self.planDetailViewModel andLeftStr:kTYPTCELLID_CONTRACT andRightStr:self.planDetailViewModel.contractName andRightColor:[UIColor blueColor]];
            return typeCell;
        }
        case 3:{
            HXBMY_PlanInvestmentRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:kINVESTMENTRECORD forIndexPath:indexPath];
            cell.textLabel.text = kINVESTMENTRECORDCELL_INVESTMENTRECORD;
            cell.accessibilityNavigationStyle = UIAccessibilityNavigationStyleAutomatic;
            return cell;
        }
    }
    return [tableView dequeueReusableCellWithIdentifier:kINVESTMENTRECORD forIndexPath:indexPath];;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 80;
    }
    switch (indexPath.row) {
        case 0:
            return 100;
            case 1:
            return 70;
            case 2:
            return 40;
        default:
            return 20;
    }
}
@end

