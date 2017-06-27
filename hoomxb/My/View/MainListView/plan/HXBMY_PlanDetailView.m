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
#import "HXBBaseView_TwoLable_View.h"///两个label的组件
#import "HXBBaseView_MoreTopBottomView.h"///多个topBottomView
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
/**
 顶部的VIew
 */
@property (nonatomic,strong) UIView                         *topView;
/**
 状态的Label
 */
@property (nonatomic,strong) UILabel                        *topStatusLabel;
/**
 topViewMassge
 */
@property (nonatomic,strong) HXBBaseView_TwoLable_View      *topViewMassge;
/**
  标信息的view
 */
@property (nonatomic,strong) HXBBaseView_MoreTopBottomView  *infoView;
/**
 type view
 */
@property (nonatomic,strong) HXBBaseView_MoreTopBottomView      *typeView;
/**
 合同view
 */
@property (nonatomic,strong) HXBBaseView_MoreTopBottomView      *contractView;
/**
 投资记录
 */
@property (nonatomic,strong) HXBBaseView_MoreTopBottomView      *loanRecordView;
/**
 管理者
 */
@property (nonatomic,strong) HXBMY_PlanDetailView_Manager *manager;
@end
@implementation HXBMY_PlanDetailView

- (void)setUPValueWithViewManagerBlock: (HXBMY_PlanDetailView_Manager *(^)(HXBMY_PlanDetailView_Manager *manager))viewManagerBlock{
    self.manager = viewManagerBlock(_manager);
    self.topStatusLabel.text = _manager.topViewStatusStr;
    kWeakSelf
//    [self.topViewMassge setUPViewManagerWithBlock:^HXBBaseView_MoreTopBottomViewManager *(HXBBaseView_MoreTopBottomViewManager *viewManager) {
//        return weakSelf.manager.topViewMassgeManager;
//    }];
    [self.topViewMassge setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
        return weakSelf.manager.topViewMassgeManager;
    }];
    [self.infoView setUPViewManagerWithBlock:^HXBBaseView_MoreTopBottomViewManager *(HXBBaseView_MoreTopBottomViewManager *viewManager) {
        return  weakSelf.manager.infoViewManager;
    }];
    [self.typeView setUPViewManagerWithBlock:^HXBBaseView_MoreTopBottomViewManager *(HXBBaseView_MoreTopBottomViewManager *viewManager) {
        return weakSelf.manager.typeViewManager;
    }];
    [self.contractView setUPViewManagerWithBlock:^HXBBaseView_MoreTopBottomViewManager *(HXBBaseView_MoreTopBottomViewManager *viewManager) {
        return weakSelf.manager.contractViewManager;
    }];
    [self.loanRecordView setUPViewManagerWithBlock:^HXBBaseView_MoreTopBottomViewManager *(HXBBaseView_MoreTopBottomViewManager *viewManager) {
        return weakSelf.manager.loanRecordViewManager;
    }];
}

- (void)setPlanDetailViewModel:(HXBMYViewModel_PlanDetailViewModel *)planDetailViewModel {
    _planDetailViewModel = planDetailViewModel;
//    [self reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _manager = [[HXBMY_PlanDetailView_Manager alloc]init];
    }
    return self;
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [self setUPViews];
}
- (void)setUPViews {
    [self setUPViews_Create];
    [self setUPViews_Frame];
}
- (void)setUPViews_Create {
    self.topView        = [[UIView alloc]init];
    self.topStatusLabel = [[UILabel alloc]init];
    self.topViewMassge  = [[HXBBaseView_TwoLable_View alloc]initWithFrame:CGRectZero];
    self.infoView       = [[HXBBaseView_MoreTopBottomView alloc]initWithFrame:CGRectNull andTopBottomViewNumber:4 andViewClass:[UILabel class] andViewHeight:20 andTopBottomSpace:0];
    self.typeView       = [[HXBBaseView_MoreTopBottomView alloc]initWithFrame:CGRectZero andTopBottomViewNumber:1 andViewClass:[UILabel class] andViewHeight:30 andTopBottomSpace:0];
    self.contractView   = [[HXBBaseView_MoreTopBottomView alloc]initWithFrame:CGRectZero andTopBottomViewNumber:1 andViewClass:[UILabel class] andViewHeight:30 andTopBottomSpace:0];
    self.loanRecordView = [[HXBBaseView_MoreTopBottomView alloc]initWithFrame:CGRectZero andTopBottomViewNumber:1 andViewClass:[UILabel class] andViewHeight:30 andTopBottomSpace:0];
    
    [self addSubview:self.topView];
    [self.topView addSubview:self.topViewMassge];
    [self.topView addSubview:self.topStatusLabel];
    [self addSubview:self.infoView];
    [self addSubview:self.typeView];
    [self addSubview:self.contractView];
    [self addSubview:_loanRecordView];
}

- (void)setUPViews_Frame {
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH(80)));
    }];
    [self.topViewMassge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.topView.mas_centerX);
        make.centerY.equalTo(self.topView.mas_centerY);
        make.height.equalTo(@(kScrAdaptationH(80)));
        make.width.equalTo(self);
    }];
    [self.topStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self.topView);
        make.height.equalTo(@(kScrAdaptationH(90)));
    }];
    [self.topStatusLabel sizeToFit];
    [self.infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom).offset(kScrAdaptationH(8));
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH(80)));
    }];
    [self.typeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.infoView.mas_bottom).offset(kScrAdaptationH(8));
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH(40)));
    }];
    [self.contractView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeView.mas_bottom).offset(kScrAdaptationH(8));
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH(20)));
    }];
    [self.loanRecordView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contractView.mas_bottom).offset(kScrAdaptationH(8));
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH(20)));
    }];
}

- (void)setUPValue{

}


//- (void)setUP {
//    self.dataSource = self;
//    self.delegate = self;
//    
//    [self registerClass:[HXBMY_PlanDtetail_Topcell class] forCellReuseIdentifier:kTOPCELLID];
//    [self registerClass:[HXBMY_PlanDetail_InfoCell class] forCellReuseIdentifier:kINFOCELLID];
//    [self registerClass:[HXBMY_PlanDetail_TypeCell class] forCellReuseIdentifier:kTYPECELLID];
//    [self registerClass:[HXBMY_PlanInvestmentRecordCell class] forCellReuseIdentifier:kINVESTMENTRECORD];
//}
//
//- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
//    return 2;
//}
//- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (!self.planDetailViewModel) {
//        return 0;
//    }
//    switch (section) {
//        case 0:
//            return 1;
//            break;
//        case 1:
//            return 4;
//            break;
//    }
//    return 0;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return [self handleTableViewCellWithTableView:tableView andIndetfier:indexPath];
//}
//
//- (UITableViewCell *)handleTableViewCellWithTableView: (UITableView *)tableView andIndetfier: (NSIndexPath *)indexPath {
//    if (!indexPath.section) {
//        HXBMY_PlanDtetail_Topcell *cell = [tableView dequeueReusableCellWithIdentifier:kTOPCELLID forIndexPath:indexPath];
//        cell.planDetailViewModel = self.planDetailViewModel;
//        return cell;
//    }
//    return  [self handleIndexPathTwoSctionWithTableView:tableView andRow:indexPath];
//}
//- (UITableViewCell *)handleIndexPathTwoSctionWithTableView:(UITableView *)tableView andRow: (NSIndexPath*)indexPath {
//    switch (indexPath.row) {
//        case 0:{
//            HXBMY_PlanDetail_InfoCell *cell = [tableView dequeueReusableCellWithIdentifier:kINFOCELLID forIndexPath:indexPath];
//            cell.planDetailViewModel = self.planDetailViewModel;
//            return cell;
//        }
//        case 1: {
//            HXBMY_PlanDetail_TypeCell *typeCell = [tableView dequeueReusableCellWithIdentifier:kTYPECELLID forIndexPath:indexPath];
//            [typeCell setupValueWithModel:self.planDetailViewModel andLeftStr:kTYPECELLID_INCOMETYPE andRightStr:self.planDetailViewModel.cashType andRightColor:[UIColor blueColor]];
//            return typeCell;
//        }
//        case 2:{
//            HXBMY_PlanDetail_TypeCell *typeCell = [tableView dequeueReusableCellWithIdentifier:kTYPECELLID forIndexPath:indexPath];
//            [typeCell setupValueWithModel:self.planDetailViewModel andLeftStr:kTYPTCELLID_CONTRACT andRightStr:self.planDetailViewModel.contractName andRightColor:[UIColor blueColor]];
//            return typeCell;
//        }
//        case 3:{
//            HXBMY_PlanInvestmentRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:kINVESTMENTRECORD forIndexPath:indexPath];
//            cell.textLabel.text = kINVESTMENTRECORDCELL_INVESTMENTRECORD;
//            cell.accessibilityNavigationStyle = UIAccessibilityNavigationStyleAutomatic;
//            return cell;
//        }
//    }
//    return [tableView dequeueReusableCellWithIdentifier:kINVESTMENTRECORD forIndexPath:indexPath];;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.section == 0) {
//        return 80;
//    }
//    switch (indexPath.row) {
//        case 0:
//            return 100;
//            case 1:
//            return 80;
//            case 2:
//            return 40;
//        default:
//            return 20;
//    }
//}
//
//
//

@end

@implementation HXBMY_PlanDetailView_Manager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.topViewMassgeManager   = [[HXBBaseView_TwoLable_View_ViewModel alloc]init];
        self.infoViewManager        = [[HXBBaseView_MoreTopBottomViewManager alloc] init];
        self.typeViewManager        = [[HXBBaseView_MoreTopBottomViewManager alloc]init];;
        self.contractViewManager    = [[HXBBaseView_MoreTopBottomViewManager alloc]init];
        self.loanRecordViewManager  = [[HXBBaseView_MoreTopBottomViewManager alloc]init];;
    }
    return self;
}
@end
