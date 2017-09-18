//
//  HXBFin_LoanTruansferDetail_TopView.m
//  hoomxb
//
//  Created by HXB on 2017/7/7.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_LoanTruansferDetail_TopView.h"
//#import "HXBFinDetail_TableView.h"

@interface HXBFin_LoanTruansferDetail_TopView ()

@property (nonatomic,strong) UIView *topMaskView;

@property (nonatomic, strong) UILabel *nextOneLabel;

@property (nonatomic, strong) UILabel *topLabelLeft;
@property (nonatomic, strong) UILabel *topLabelRight;
@property (nonatomic, strong) UILabel *leftLabelLeft;
@property (nonatomic, strong) UILabel *leftLabelRight;
@property (nonatomic, strong) UILabel *rightLabelLeft;
@property (nonatomic, strong) UILabel *rightLabelRight;

/**
 年利率 label
 品字形 上
 */
//@property (nonatomic,strong) HXBBaseView_TwoLable_View *interestLabel;
///**
// 剩余期限
// 品字形 左
// */
//@property (nonatomic,strong) HXBBaseView_TwoLable_View *remainTimeLabel;
///**
// 待转让金额
// 品字形 右
// */
//@property (nonatomic,strong) HXBBaseView_TwoLable_View *truansferAmountLabel;

//@property (nonatomic,strong) HXBFin_LoanTruansferDetail_TopViewManager *manager;

@end

@implementation HXBFin_LoanTruansferDetail_TopView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUP];
    }
    return self;
}

- (void)setInterestLabelLeftStr:(NSString *)interestLabelLeftStr {
    _interestLabelLeftStr = interestLabelLeftStr;
    _topLabelLeft.text = interestLabelLeftStr;
    NSString *interestStr = [NSString stringWithFormat:@"%.2lf%%", interestLabelLeftStr.floatValue];
    NSRange range = NSMakeRange(interestStr.length - 1, 1);
    _topLabelLeft.attributedText = [NSAttributedString setupAttributeStringWithString:interestStr WithRange:range andAttributeColor:[UIColor whiteColor] andAttributeFont:kHXBFont_PINGFANGSC_REGULAR(20)];

}

- (void)setRemainTimeLabelLeftStr:(NSString *)remainTimeLabelLeftStr {
    _remainTimeLabelLeftStr = remainTimeLabelLeftStr;
    _leftLabelLeft.text = remainTimeLabelLeftStr;
}

- (void)setTruansferAmountLabelLeftStr:(NSString *)truansferAmountLabelLeftStr {
    _truansferAmountLabelLeftStr = truansferAmountLabelLeftStr;
    _rightLabelLeft.text = truansferAmountLabelLeftStr;
}

//-(void)setTruansferAmountLabelManager:(HXBBaseView_TwoLable_View_ViewModel *)truansferAmountLabelManager {
//    _truansferAmountLabelManager = truansferAmountLabelManager;
//    [self.truansferAmountLabel setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
//        return truansferAmountLabelManager;
//    }];
//}
//
//- (void)setRemainTimeLabelManager:(HXBBaseView_TwoLable_View_ViewModel *)remainTimeLabelManager {
//    _remainTimeLabelManager = remainTimeLabelManager;
//    [self.remainTimeLabel setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
//        return remainTimeLabelManager;
//    }];
//}
//
//- (void)setInterestLabelManager:(HXBBaseView_TwoLable_View_ViewModel *)interestLabelManager {
//    _interestLabelManager = interestLabelManager;
//    kWeakSelf
//    [self.interestLabel setUP_TwoViewVMFunc:^HXBBaseView_TwoLable_View_ViewModel *(HXBBaseView_TwoLable_View_ViewModel *viewModelVM) {
//        NSString *interestStr = [NSString stringWithFormat:@"%.2lf%@", interestLabelManager.leftLabelStr.floatValue,@"%"];
//        NSRange range = NSMakeRange(interestStr.length - 1, 1);
//        weakSelf.interestLabel.leftLabel.attributedText = [NSAttributedString setupAttributeStringWithString:interestStr WithRange:range andAttributeColor:[UIColor whiteColor] andAttributeFont:kHXBFont_PINGFANGSC_REGULAR(20)];
//        return interestLabelManager;
//    }];
//}

- (void)setUP {
    [self creatViews];
    [self setUPFrame];
}


- (void)creatViews {
//    [self addSubview:self.topMaskView];
//    [self addSubview:self.nextOneLabel];
    [self addSubview:self.topLabelLeft];
    [self addSubview:self.topLabelRight];
    [self addSubview:self.leftLabelLeft];
    [self addSubview:self.leftLabelRight];
    [self addSubview:self.rightLabelLeft];
    [self addSubview:self.rightLabelRight];
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
    
    [self.topLabelLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kScrAdaptationH(20));
        make.left.right.equalTo(self);
        make.height.offset(kScrAdaptationH(40));
    }];
    
    [self.topLabelRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topLabelLeft.mas_bottom).offset(kScrAdaptationH(10));
        make.left.right.equalTo(self);
        make.height.offset(kScrAdaptationH(20));
    }];
    
    [self.leftLabelLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topLabelRight.mas_bottom).offset(kScrAdaptationH(30));
        make.left.equalTo(self);
        make.width.offset(kScreenWidth / 2);
        make.height.offset(kScrAdaptationH(20));
    }];
    
    [self.leftLabelRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.leftLabelLeft.mas_bottom).offset(kScrAdaptationH(5));
        make.left.equalTo(self);
        make.width.offset(kScreenWidth / 2);
        make.height.offset(kScrAdaptationH(20));
    }];
    
    [self.rightLabelLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leftLabelLeft);
        make.left.equalTo(self).offset(kScreenWidth / 2);
        make.width.offset(kScreenWidth / 2);
        make.height.offset(kScrAdaptationH(20));
    }];
    
    [self.rightLabelRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leftLabelRight);
        make.left.equalTo(self).offset(kScreenWidth / 2);
        make.width.offset(kScreenWidth / 2);
        make.height.offset(kScrAdaptationH(20));
    }];
}



- (UILabel *)topLabelLeft {
    if (!_topLabelLeft) {
        _topLabelLeft = [[UILabel alloc]init];
        _topLabelLeft.textAlignment = NSTextAlignmentCenter;
        _topLabelLeft.textColor = [UIColor whiteColor];
        _topLabelLeft.font = kHXBFont_PINGFANGSC_REGULAR(45);
    }
    return _topLabelLeft;
}

- (UILabel *)topLabelRight {
    if (!_topLabelRight) {
        _topLabelRight = [[UILabel alloc]init];
        _topLabelRight.text = @"年利率";
        _topLabelRight.textAlignment = NSTextAlignmentCenter;
        _topLabelRight.textColor = [UIColor colorWithWhite:1 alpha:0.6];
        _topLabelRight.font = kHXBFont_PINGFANGSC_REGULAR(12);
    }
    return _topLabelRight;
}

- (UILabel *)leftLabelLeft {
    if (!_leftLabelLeft) {
        _leftLabelLeft = [[UILabel alloc]init];
        _leftLabelLeft.textAlignment = NSTextAlignmentCenter;
        _leftLabelLeft.textColor = [UIColor whiteColor];
        _leftLabelLeft.font = kHXBFont_PINGFANGSC_REGULAR(15);
    }
    return _leftLabelLeft;
}

- (UILabel *)leftLabelRight {
    if (!_leftLabelRight) {
        _leftLabelRight = [[UILabel alloc]init];
        _leftLabelRight.text = @"剩余期限";
        _leftLabelRight.textAlignment = NSTextAlignmentCenter;
        _leftLabelRight.textColor = [UIColor colorWithWhite:1 alpha:0.6];
        _leftLabelRight.font = kHXBFont_PINGFANGSC_REGULAR(12);
    }
    return _leftLabelRight;
}

- (UILabel *)rightLabelLeft {
    if (!_rightLabelLeft) {
        _rightLabelLeft = [[UILabel alloc]init];
        _rightLabelLeft.textAlignment = NSTextAlignmentCenter;
        _rightLabelLeft.textColor = [UIColor whiteColor];
        _rightLabelLeft.font = kHXBFont_PINGFANGSC_REGULAR(15);
    }
    return _rightLabelLeft;
}

- (UILabel *)rightLabelRight {
    if (!_rightLabelRight) {
        _rightLabelRight = [[UILabel alloc]init];
        _rightLabelRight.text = @"待转让金额";
        _rightLabelRight.textAlignment = NSTextAlignmentCenter;
        _rightLabelRight.textColor = [UIColor colorWithWhite:1 alpha:0.6];
        _rightLabelRight.font = kHXBFont_PINGFANGSC_REGULAR(12);
    }
    return _rightLabelRight;
}


@end


//@implementation HXBFin_LoanTruansferDetail_TopViewManager
//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        /**
//         年利率 label
//         品字形 上
//         */
//        self.interestLabelManager = [[HXBBaseView_TwoLable_View_ViewModel alloc] init];
//        self.interestLabelManager.leftFont= kHXBFont_PINGFANGSC_REGULAR(45);
//        self.interestLabelManager.rightFont= kHXBFont_PINGFANGSC_REGULAR(12);
//        self.interestLabelManager.rightLabelStr = @"年利率";
//        self.interestLabelManager.leftViewColor = [UIColor whiteColor];
//        self.interestLabelManager.rightViewColor =  [UIColor colorWithWhite:1 alpha:0.6];
//        /**
//         剩余期限
//         品字形 左
//         */
//        self.remainTimeLabelManager = [[HXBBaseView_TwoLable_View_ViewModel alloc]init];
//        self.remainTimeLabelManager.leftFont= kHXBFont_PINGFANGSC_REGULAR(15);
//        self.remainTimeLabelManager.rightFont= kHXBFont_PINGFANGSC_REGULAR(12);
//        self.remainTimeLabelManager.rightLabelStr = @"剩余期限";
//        self.remainTimeLabelManager.leftViewColor = [UIColor whiteColor];
//        self.remainTimeLabelManager.rightViewColor = [UIColor colorWithWhite:1 alpha:0.6];
//
//        /**
//         待转让金额
//         品字形 右
//         */
//        self.truansferAmountLabelManager = [[HXBBaseView_TwoLable_View_ViewModel alloc] init];
//        self.truansferAmountLabelManager.leftFont= kHXBFont_PINGFANGSC_REGULAR(15);
//        self.truansferAmountLabelManager.rightFont= kHXBFont_PINGFANGSC_REGULAR(12);
//        self.truansferAmountLabelManager.rightLabelStr = @"待转让金额";
//        self.truansferAmountLabelManager.leftViewColor = [UIColor whiteColor];
//        self.truansferAmountLabelManager.rightViewColor = [UIColor colorWithWhite:1 alpha:0.6];
//    }
//    return self;
//}
//@end
