//
//  HXBBaseView_MYList_TableViewCell.m
//  hoomxb
//
//  Created by HXB on 2017/5/16.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseView_MYList_TableViewCell.h"

#import "HXBMYViewModel_MianPlanViewModel.h"///红利计划的viewmodel
/*
 ///投资期限
 @property (nonatomic,copy) NSString *lockPeriod;//": "1",
 ///已获收益
 @property (nonatomic,copy) NSString *earnAmount;//": "100.00",
 ///收益的状态
 @property (nonatomic,copy) NSString *status;//": "PURCHASE_END",
 ///转让金额
 @property (nonatomic,copy) NSString *redProgressLeft;//": "50000.00",
 ///完成时间
 @property (nonatomic,copy) NSString *redFinishTime;//": "2017-05-06 14:43:46.0",
 @property (nonatomic,copy) NSString *type;//": "HOLD_PLAN",
 ///退出时间
 @property (nonatomic,copy) NSString *endLockingTime;//": "1495283676000",
 @property (nonatomic,copy) NSString *ID;//": "156688",
 @property (nonatomic,copy) NSString *financeSubPointId;//": "1291978",
 @property (nonatomic,copy) NSString *statusCode;//": "PURCHASE_END",
 @property (nonatomic,copy) NSString *finalAmount;//": "50000.00",
 @property (nonatomic,copy) NSString *category;//": "A",
 ///预期收益率
 @property (nonatomic,copy) NSString *expectedRate;//": "4.50",
 ///计划名称
 @property (nonatomic,copy) NSString *name;//": "安琪发布计划11",
 @property (nonatomic,copy) NSString *subPointId;//": "1291978"
 */
@interface HXBBaseView_MYList_TableViewCell ()
    ///投资名称
    @property (nonatomic,strong) UILabel *nameLable;
    ///投资金额
    @property (nonatomic,strong) UILabel *investmentAmountLable;
    ///收本息的label
    @property (nonatomic,strong) UILabel *toBeReceived;
    ///下一还款日
    @property (nonatomic,strong) UILabel *nextRepaymentDay;
    ///还款期数
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

@end

@implementation HXBBaseView_MYList_TableViewCell

    
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}
    
- (void) setup {
    //创建UI 并布局
    [self setUPSubView];
    [self temp];//测试
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
    self.theNumberOfPeriods_const = [[UILabel alloc]init];
    
    [self.contentView addSubview:self.nameLable];
//    [self.contentView addSubview:self.nameLable_const];
    [self.contentView addSubview:self.investmentAmountLable];
    [self.contentView addSubview:self.investmentAmountLable_const];
    [self.contentView addSubview:self.toBeReceived];
    [self.contentView addSubview:self.toBeReceived_const];
    [self.contentView addSubview:self.nextRepaymentDay];
    [self.contentView addSubview:self.nextRepaymentDay_const];
    [self.contentView addSubview:self.theNumberOfPeriods];
    [self.contentView addSubview:self.theNumberOfPeriods_const];
    self.investmentAmountLable_const.text = @"加入金额(元)";
    self.toBeReceived_const.text = @"已获收益（元）";
    self.theNumberOfPeriods_const.text = @"退出";
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
        make.left.equalTo(weakSelf.contentView).offset(kScrAdaptationW(-20));
    }];
    [self.nextRepaymentDay_const mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakSelf.toBeReceived_const).offset(kScrAdaptationH(0));
        make.centerX.equalTo(weakSelf.nextRepaymentDay).offset(kScrAdaptationW(0));
    }];
    
    ///退出
    [self.theNumberOfPeriods_const mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakSelf.nameLable).offset(kScrAdaptationH(0));
        make.left.equalTo(weakSelf.contentView).offset(kScrAdaptationW(-20));
    }];
    ///退出日期
    [self.theNumberOfPeriods mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(weakSelf.nameLable).offset(kScrAdaptationH(0));
        make.centerX.equalTo(weakSelf.theNumberOfPeriods_const).offset(kScrAdaptationW(-20));
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
    self.theNumberOfPeriods_const.text = @"退出";
}



@end
