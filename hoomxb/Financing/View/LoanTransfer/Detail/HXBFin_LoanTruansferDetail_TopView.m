//
//  HXBFin_LoanTruansferDetail_TopView.m
//  hoomxb
//
//  Created by HXB on 2017/7/7.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_LoanTruansferDetail_TopView.h"
#import "HXBFinDetail_TableView.h"
@interface HXBFin_LoanTruansferDetail_TopView ()
/**
顶部的后面的遮罩
 */
@property (nonatomic,strong) UIView *topMaskView;
/**
 下个还款日 05-31 
 品字形 上右
 */
@property (nonatomic,strong) UILabel *nextOneLabel;
/**
 年利率 label
 品字形 上
 */
@property (nonatomic,strong) HXBBaseView_TwoLable_View *interestLabel;
/**
 剩余期限
 品字形 左
 */
@property (nonatomic,strong) HXBBaseView_TwoLable_View *remainTimeLabel;
/**
 待转让金额
 品字形 右
 */
@property (nonatomic,strong) HXBBaseView_TwoLable_View *truansferAmountLabel;
@property (nonatomic,strong) HXBFin_LoanTruansferDetail_TopViewManager *manager;
@end
@implementation HXBFin_LoanTruansferDetail_TopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUP];
        _manager = [[HXBFin_LoanTruansferDetail_TopViewManager alloc]init];
    }
    return self;
}

- (void)setUP {
    [self creatViews];
    [self setUPFrame];
}
- (void)setUPValueWithManager: (HXBFin_LoanTruansferDetail_TopViewManager *(^)(HXBFin_LoanTruansferDetail_TopViewManager *manager))setUPValueManagerBlock {
    self.manager = setUPValueManagerBlock(self.manager);
}
- (void)setManager:(HXBFin_LoanTruansferDetail_TopViewManager *)manager {
    self.nextOneLabel.text = manager.nextOneLabel;
    [self.interestLabel setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
        return manager.interestLabelManager;
    }];
    [self.remainTimeLabel setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
        return manager.remainTimeLabelManager;
    }];
    [self.truansferAmountLabel setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
        return manager.truansferAmountLabelManager;
    }];
    
    NSString *interestStr = [NSString stringWithFormat:@"%.2lf%@", manager.interestLabelManager.leftLabelStr.floatValue,@"%"];
    NSRange range = NSMakeRange(interestStr.length - 1, 1);
    self.interestLabel.leftLabel.attributedText = [NSAttributedString setupAttributeStringWithString:interestStr WithRange:range andAttributeColor:[UIColor whiteColor] andAttributeFont:kHXBFont_PINGFANGSC_REGULAR(20)];
}


- (void)creatViews {
    self.topMaskView = [[UIView alloc]init];
    self.nextOneLabel = [[UILabel alloc]init];
    self.interestLabel = [[HXBBaseView_TwoLable_View alloc]initWithFrame:CGRectZero andSpacing:15];
    self.remainTimeLabel = [[HXBBaseView_TwoLable_View alloc]initWithFrame:CGRectZero];
    self.truansferAmountLabel = [[HXBBaseView_TwoLable_View alloc]initWithFrame:CGRectZero];

    [self addSubview:self.topMaskView];
    [self addSubview:self.nextOneLabel];
    [self addSubview:self.interestLabel];
    [self addSubview:self.remainTimeLabel];
    [self addSubview:self.truansferAmountLabel];
}

- (void)setUPFrame {
//    [self.topMaskView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self);
//        make.top.equalTo(self).offset(kScrAdaptationH(44));
//        make.height.equalTo(@(kScrAdaptationH(72)));
//    }];
//    [self.nextOneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self).offset(kScrAdaptationH(23));
//        make.right.equalTo(self).offset(kScrAdaptationH(-20));
//        make.left.equalTo(self).offset(0);
//        make.height.equalTo(@(kScrAdaptationH(38)));
//    }];
//    [self.nextOneLabel sizeToFit];
    
    [self.interestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(kScrAdaptationH(-81));
        make.height.equalTo(@(kScrAdaptationH(72)));
    }];
    
    [self.remainTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(kScrAdaptationH(-20));
        make.left.equalTo(self);
        make.width.equalTo(self).multipliedBy(1/2.0).offset(kScrAdaptationW(0));
    }];
    
    [self.truansferAmountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.remainTimeLabel);
        make.left.equalTo(self.remainTimeLabel.mas_right).offset(kScrAdaptationW(0));
        make.right.equalTo(self);
    }];
}
@end
@implementation HXBFin_LoanTruansferDetail_TopViewManager
- (instancetype)init
{
    self = [super init];
    if (self) {
        /**
         年利率 label
         品字形 上
         */
        self.interestLabelManager = [[HXBBaseView_TwoLable_View_ViewModel alloc] init];
        self.interestLabelManager.leftFont= kHXBFont_PINGFANGSC_REGULAR(45);
        self.interestLabelManager.rightFont= kHXBFont_PINGFANGSC_REGULAR(12);
        self.interestLabelManager.leftViewColor = [UIColor whiteColor];
        self.interestLabelManager.rightViewColor =  [UIColor colorWithWhite:1 alpha:0.6];
        /**
         剩余期限
         品字形 左
         */
        self.remainTimeLabelManager = [[HXBBaseView_TwoLable_View_ViewModel alloc]init];
        self.remainTimeLabelManager.leftFont= kHXBFont_PINGFANGSC_REGULAR(15);
        self.remainTimeLabelManager.rightFont= kHXBFont_PINGFANGSC_REGULAR(12);
        self.remainTimeLabelManager.leftViewColor = [UIColor whiteColor];
        self.remainTimeLabelManager.rightViewColor = [UIColor colorWithWhite:1 alpha:0.6];

        /**
         待转让金额
         品字形 右
         */
        self.truansferAmountLabelManager = [[HXBBaseView_TwoLable_View_ViewModel alloc] init];
        self.truansferAmountLabelManager.leftFont= kHXBFont_PINGFANGSC_REGULAR(15);
        self.truansferAmountLabelManager.rightFont= kHXBFont_PINGFANGSC_REGULAR(12);
        self.truansferAmountLabelManager.leftViewColor = [UIColor whiteColor];
        self.truansferAmountLabelManager.rightViewColor = [UIColor colorWithWhite:1 alpha:0.6];
    }
    return self;
}
@end
