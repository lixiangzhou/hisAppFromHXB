//
//  HXBMYCapitalRecord_TableViewCell.m
//  hoomxb
//
//  Created by HXB on 2017/5/23.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBMYCapitalRecord_TableViewCell.h"
#import "HXBMYViewModel_MainCapitalRecordViewModel.h"///资金记录的MOdel
/**
 ///收入金额
 @property (nonatomic,strong) UILabel *income_Label;
 ///标id
 @property (nonatomic,strong) UILabel *loanId_Label;
 ///标的标题
 @property (nonatomic,strong) UILabel *loanTitle_Label;
 ///理财计划id
 @property (nonatomic,strong) UILabel *financePlanId_Label;
 ///理财计划名称
 @property (nonatomic,strong) UILabel *financePlanName_Label;
 ///理财计划子账户id
 @property (nonatomic,strong) UILabel *financePlanSubPointId_Label;
 */
#import "HXBMYViewModel_MainCapitalRecordViewModel.h"///资金记录的ViewModel
#import "HXBMYModel_CapitalRecordDetailModel.h"
@interface HXBMYCapitalRecord_TableViewCell ()

///资金记录显示类型
@property (nonatomic,strong) UILabel *pointDisplayType_Label;
///金额
@property (nonatomic,strong) UILabel *amount_Label;
///账户余额
@property (nonatomic,strong) UILabel *balance_Label;
///交易时间
@property (nonatomic,strong) UILabel *time_Label;
///是否是收入
@property (nonatomic,strong) UILabel *isPlus_Label;
///支出金额
@property (nonatomic,strong) UILabel *pay_Label;
///摘要
@property (nonatomic,strong) UILabel *notes_Label;

@property (nonatomic, strong) UIView *cellLineView;

@end

@implementation HXBMYCapitalRecord_TableViewCell

- (void)setCapitalRecortdDetailViewModel:(HXBMYViewModel_MainCapitalRecordViewModel *)capitalRecortdDetailViewModel {
    _capitalRecortdDetailViewModel = capitalRecortdDetailViewModel;
    self.pointDisplayType_Label.text = capitalRecortdDetailViewModel.capitalRecordModel.pointDisplayType;
    self.pay_Label.text = capitalRecortdDetailViewModel.income;
    self.pay_Label.textColor = capitalRecortdDetailViewModel.inComeStrColor;
    self.time_Label.text = capitalRecortdDetailViewModel.time;
    self.balance_Label.text = capitalRecortdDetailViewModel.balance;
}

- (void)setIsShowCellLine:(int)isShowCellLine {
    _isShowCellLine = isShowCellLine;
    NSLog(@"_+_+_+_+_+%d", isShowCellLine);
    if (_isShowCellLine) {
        self.cellLineView.hidden = NO;
    } else {
        self.cellLineView.hidden = YES;
    }
}


- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUP];
    }
    return self;
}
- (void)setUP {
    [self createSubView];
}

- (void)createSubView {
    self.pointDisplayType_Label = [[UILabel alloc]init];
    self.isPlus_Label = [[UILabel alloc]init];
    self.pay_Label = [[UILabel alloc]init];
    self.amount_Label = [[UILabel alloc]init];
    self.balance_Label = [[UILabel alloc]init];
    self.time_Label = [[UILabel alloc]init];
    self.notes_Label = [[UILabel alloc]init];
    self.cellLineView = [[UIView alloc] init];
    self.cellLineView.backgroundColor = kHXBColor_Font0_5;
    [self.contentView addSubview:self.pointDisplayType_Label];
//    [self.contentView addSubview:self.amount_Label];
    [self.contentView addSubview:self.balance_Label];
    [self.contentView addSubview:self.time_Label];
//    [self.contentView addSubview:self.isPlus_Label];
    [self.contentView addSubview:self.pay_Label];
//    [self.contentView addSubview:self.notes_Label];
    [self.contentView addSubview:self.cellLineView];
    __weak typeof (self)weakSelf = self;
    [self.pointDisplayType_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.contentView).offset(kScrAdaptationW750(30));
        make.top.equalTo(weakSelf.contentView).offset(kScrAdaptationH750(28));
    }];
    [self.pay_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.contentView).offset(kScrAdaptationH750(28));
        make.right.equalTo(weakSelf.contentView).offset(-kScrAdaptationW750(30));
    }];
    [self.time_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.contentView).offset(-kScrAdaptationH750(28));
        make.left.equalTo(weakSelf.contentView).offset(kScrAdaptationW750(30));
    }];
    [self.balance_Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.contentView).offset(-kScrAdaptationH750(28));
        make.right.equalTo(weakSelf.contentView).offset(-kScrAdaptationW750(30));
    }];
    [self.cellLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.contentView).offset(-kScrAdaptationH(0.5));
        make.width.offset(kScreenWidth - kScrAdaptationW(30));
        make.left.equalTo(weakSelf.contentView).offset(kScrAdaptationW(15));
        make.height.offset(kScrAdaptationH(0.5));
    }];
    self.pointDisplayType_Label.font = kHXBFont_PINGFANGSC_REGULAR_750(28);
    self.pointDisplayType_Label.textColor = COLOR(51, 51, 51, 1);
    self.pay_Label.font = kHXBFont_PINGFANGSC_REGULAR_750(28);
    self.time_Label.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
    self.time_Label.textColor = kHXBColor_Font0_6;
    self.balance_Label.font = kHXBFont_PINGFANGSC_REGULAR_750(24);
    self.balance_Label.textColor = kHXBColor_Font0_6;
}
///测试
- (void) temp {
    self.pointDisplayType_Label.text = @"haha";
    self.pay_Label.text = @"haha";
    self.time_Label.text = @"2001 12:23";
    self.balance_Label.text = @"账户余额45.12元";
}
@end
