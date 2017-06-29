//
//  HXBBaseView_MYList_TableViewCell.m
//  hoomxb
//
//  Created by HXB on 2017/5/16.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseView_MYList_TableViewCell.h"

#import "HXBMYViewModel_MianPlanViewModel.h"///红利计划的viewmodel
#import "HXBMYModel_MainPlanModel.h"//红利计划model
#import "HXBMYViewModel_MainLoanViewModel.h"//散标的ViewModel
#import "HXBMyModel_MainLoanModel.h"//散标的Model
@interface HXBBaseView_MYList_TableViewCell ()
    ///投资名称
    @property (nonatomic,strong) UILabel *nameLable;
    ///投资金额 (红利 加入金额)
    @property (nonatomic,strong) UILabel *investmentAmountLable;
    ///收本息的label  （红利：已获收益）
    @property (nonatomic,strong) UILabel *toBeReceived;
    ///下一还款日 （预期年利率）
    @property (nonatomic,strong) UILabel *nextRepaymentDay;
    ///还款期数 （状态）
    @property (nonatomic,strong) UILabel *theNumberOfPeriods;
    // ---------------- _const -------------
    ///投资名称
    @property (nonatomic,strong) UILabel *nameLable_const;
    ///投资金额
    @property (nonatomic,strong) UILabel *investmentAmountLable_const;
    ///收本息的label
    @property (nonatomic,strong) UILabel *toBeReceived_const;
    ///下一还款日
    @property (nonatomic,strong) UILabel *nextRepaymentDay_const;
    ///还款期数
    @property (nonatomic,strong) UILabel *theNumberOfPeriods_const;

@property (nonatomic,strong) HXBBaseView_MYList_TableViewCellManager *manager;

@end

@implementation HXBBaseView_MYList_TableViewCell

- (void)setUPValueWithManagerBlock:(HXBBaseView_MYList_TableViewCellManager *(^)(HXBBaseView_MYList_TableViewCellManager *))setUPValueManagerBlock {
    _manager = setUPValueManagerBlock(self.manager);
    
    self.nameLable                  .text = _manager.nameLable;
    self.investmentAmountLable      .text = _manager.investmentAmountLable;
    self.toBeReceived               .text = _manager.toBeReceived;
    self.nextRepaymentDay           .text = _manager.nextRepaymentDay;
    self.theNumberOfPeriods         .text = _manager.theNumberOfPeriods;
    self.investmentAmountLable_const.text = _manager.investmentAmountLable_const;
    self.toBeReceived_const         .text = _manager.toBeReceived_const;
    self.nextRepaymentDay_const     .text = _manager.nextRepaymentDay_const;
    
}
- (void)setPlanViewMode:(HXBMYViewModel_MianPlanViewModel *)planViewMode {
    _planViewMode = planViewMode;

    self.nameLable.text                     = planViewMode.planModelDataList.name;//名字
    self.investmentAmountLable.text         = planViewMode.planModelDataList.redProgressLeft;//左边的
    self.toBeReceived.text                  = planViewMode.planModelDataList.earnAmount;//计划的 已获利息
    self.nextRepaymentDay.text              =        planViewMode.planModelDataList.expectedRate;//预期年利率
    self.theNumberOfPeriods.text            = planViewMode.planModelDataList.status;//计划状态
    self.investmentAmountLable_const.text   = @"加入金额(元)";
    self.toBeReceived_const.text            = @"已获收益（元）";
    self.nextRepaymentDay_const.text        = @"预期年利率";

    self.nameLable.text = planViewMode.planModelDataList.name;//名字
    self.investmentAmountLable.text = planViewMode.planModelDataList.redProgressLeft;//左边的
    self.toBeReceived.text = planViewMode.planModelDataList.earnAmount;//计划的 已获利息
    self.nextRepaymentDay.text = planViewMode.planModelDataList.expectedRate;//预期年利率
    if ([planViewMode.status isEqualToString:@"等待计息"]) {
        self.theNumberOfPeriods.text = planViewMode.status;//计划状态
    }else
    {
        self.theNumberOfPeriods.text = [NSString stringWithFormat:@"%@%@",[[HXBBaseHandDate sharedHandleDate] millisecond_StringFromDate:planViewMode.planModelDataList.endLockingTime andDateFormat:@"yyyy-MM-dd"], planViewMode.status];//计划状态
    }
    

}
- (void)setLoanViewModel:(HXBMYViewModel_MainLoanViewModel *)loanViewModel {
    _loanViewModel = loanViewModel;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        _manager = [[HXBBaseView_MYList_TableViewCellManager alloc]init];
        [self setup];
    }
    return self;
}
    
- (void) setup {
    //创建UI 并布局
    [self setUPSubView];
//    [self temp];//测试
}

    //创建布局子控件
- (void) setUPSubView {
    self.nameLable = [[UILabel alloc]init];
//    self.nameLable_const = [[UILabel alloc]init];
    self.investmentAmountLable = [[UILabel alloc]init];
    self.investmentAmountLable_const = [[UILabel alloc]init];
    self.toBeReceived = [[UILabel alloc]init];
    self.toBeReceived_const = [[UILabel alloc]init];
    self.nextRepaymentDay = [[UILabel alloc]init];
    self.nextRepaymentDay_const = [[UILabel alloc]init];
    self.theNumberOfPeriods = [[UILabel alloc]init];
//    self.theNumberOfPeriods_const = [[UILabel alloc]init];
    
    [self.contentView addSubview:self.nameLable];
//    [self.contentView addSubview:self.nameLable_const];
    [self.contentView addSubview:self.investmentAmountLable];
    [self.contentView addSubview:self.investmentAmountLable_const];
    [self.contentView addSubview:self.toBeReceived];
    [self.contentView addSubview:self.toBeReceived_const];
    [self.contentView addSubview:self.nextRepaymentDay];
    [self.contentView addSubview:self.nextRepaymentDay_const];
    [self.contentView addSubview:self.theNumberOfPeriods];
//    [self.contentView addSubview:self.theNumberOfPeriods_const];
    self.investmentAmountLable_const.text = @"加入金额(元)";
    self.toBeReceived_const.text = @"已获收益（元）";
    self.nextRepaymentDay_const.text = @"预期年利率";
    [self setUPLaoutSubView];
}
    //布局子控件
- (void)setUPLaoutSubView {
    kWeakSelf
    //名字的label
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.contentView).offset(kScrAdaptationH(20));
        make.left.equalTo(weakSelf.contentView).offset(kScrAdaptationW(20));
    }];
//    [self.nameLable_const mas_makeConstraints:^(MASConstraintMaker *make) {
//        //名字的label
//        make.top.equalTo(weakSelf).offset(kScrAdaptationH(20));
//        make.left.equalTo(weakSelf.contentView).offset(kScrAdaptationW(20));
//    }];
    
    ///加入金额
    [self.investmentAmountLable mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.nameLable.mas_bottom).offset(kScrAdaptationH(20));
        make.left.equalTo(weakSelf.contentView).offset(kScrAdaptationW(20));
    }];
    [self.investmentAmountLable_const mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.investmentAmountLable.mas_bottom).offset(kScrAdaptationH(20));
        make.centerX.equalTo(weakSelf.investmentAmountLable);
    }];
    
    ///已获收益
    [self.toBeReceived mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(weakSelf.investmentAmountLable).offset(kScrAdaptationH(0));
        make.centerX.equalTo(weakSelf.contentView).offset(kScrAdaptationW(0));
    }];
    [self.toBeReceived_const mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(weakSelf.investmentAmountLable_const).offset(kScrAdaptationH(0));
        make.centerX.equalTo(weakSelf.contentView).offset(kScrAdaptationW(0));
    }];
    
    //预期年利率
    [self.nextRepaymentDay mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(weakSelf.investmentAmountLable).offset(kScrAdaptationH(0));
        make.right.equalTo(weakSelf.contentView.mas_right).offset(kScrAdaptationW(-20));
    }];
    [self.nextRepaymentDay_const mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.toBeReceived_const).offset(kScrAdaptationH(0));
        make.centerX.equalTo(weakSelf.nextRepaymentDay).offset(kScrAdaptationW(0));
    }];
    
//    ///退出
//    [self.theNumberOfPeriods_const mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.centerY.equalTo(weakSelf.nameLable).offset(kScrAdaptationH(0));
//        make.right.equalTo(weakSelf.contentView).offset(kScrAdaptationW(-20));
//    }];
    ///退出日期
    [self.theNumberOfPeriods mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakSelf.nameLable).offset(kScrAdaptationH(0));
        make.right.equalTo(weakSelf).offset(kScrAdaptationW(-20));
    }];
}


- (void)temp {
    self.nameLable.text = @"红利计划";
    self.investmentAmountLable.text = @"24000";
    
    self.toBeReceived.text = @"0.00";
    
    self.nextRepaymentDay.text = @"12.80%";
  
    self.theNumberOfPeriods.text = @"12.08%";
    self.investmentAmountLable_const.text = @"加入金额(元)";
    self.toBeReceived_const.text = @"已获收益（元）";
//    self.theNumberOfPeriods_const.text = @"退出";
}



@end


@implementation HXBBaseView_MYList_TableViewCellManager


@end
