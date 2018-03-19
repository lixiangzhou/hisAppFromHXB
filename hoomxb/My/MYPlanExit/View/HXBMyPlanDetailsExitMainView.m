//
//  HXBMyPlanDetailsExitMainView.m
//  hoomxb
//
//  Created by hxb on 2018/3/12.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBMyPlanDetailsExitMainView.h"

@interface HXBMyPlanDetailsExitMainView ()

/**
 加入本金
 当前已赚
 退出时间
 */
@property (nonatomic,strong) HXBBaseView_MoreTopBottomView *topView;
@property (nonatomic,strong) UIImageView *iconImgV;
@property (nonatomic,strong) UILabel *descLab;
@property (nonatomic,strong) UIButton *exitBtn;     /// 确认退出
@property (nonatomic,strong) UIButton *cancelBtn;   /// 暂不退出
@end

@implementation HXBMyPlanDetailsExitMainView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUPViews];
        _manager = [[HXBMyPlanDetailsExitMainViewManager alloc]init];
    }
    return self;
}

- (void)setValueManager_PlanDetail_Detail:(HXBMyPlanDetailsExitMainViewManager *(^)(HXBMyPlanDetailsExitMainViewManager *))planDDetailManagerBlock {
    self.manager = planDDetailManagerBlock(_manager);
}

- (void)setManager:(HXBMyPlanDetailsExitMainViewManager *)manager {
    _manager = manager;
    kWeakSelf
    [self.topView setUPViewManagerWithBlock:^HXBBaseView_MoreTopBottomViewManager *(HXBBaseView_MoreTopBottomViewManager *viewManager) {
        
        return weakSelf.manager.topViewManager;
    }];
}

- (void)setUPViews {
    self.backgroundColor = kHXBColor_BackGround;
    [self setUPViewsCreate];
    [self setUPSubViewsFrame];
}

- (void)setUPSubViewsFrame {
    [self addSubview:self.topView];
    [self addSubview:self.iconImgV];
    [self addSubview:self.descLab];
    [self addSubview:self.cancelBtn];
    [self addSubview:self.exitBtn];
    
    kWeakSelf
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf).offset(kScrAdaptationH(10));//make.top.equalTo(weakSelf.pursuitsView.mas_bottom).offset(kScrAdaptationH(10));
        make.left.right.equalTo(weakSelf);
        make.height.equalTo(@(kScrAdaptationH750(258)));
    }];
    [self.iconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.topView.mas_bottom).offset(kScrAdaptationH750(34));
        make.left.equalTo(weakSelf).offset(kScrAdaptationW750(28));
        make.width.height.equalTo(@(kScrAdaptationH750(28)));
    }];
    [self.descLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.topView.mas_bottom).offset(kScrAdaptationH750(30));
        make.left.equalTo(weakSelf.iconImgV.mas_right).offset(kScrAdaptationW750(10));
        make.right.equalTo(weakSelf.mas_right).offset(kScrAdaptationW750(-28));
        make.height.equalTo(@(kScrAdaptationH750(108)));
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.descLab.mas_bottom).offset(kScrAdaptationH750(150));
        make.left.equalTo(weakSelf).offset(kScrAdaptationW750(30));
        make.right.equalTo(weakSelf).offset(kScrAdaptationW750(-30));
        make.height.equalTo(@(kScrAdaptationH750(82)));
    }];
    [self.exitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.cancelBtn.mas_bottom).offset(kScrAdaptationH750(40));
        make.left.right.height.equalTo(weakSelf.cancelBtn);
    }];
    self.cancelBtn.hidden = YES;
    self.exitBtn.hidden = YES;
    self.iconImgV.hidden = YES;
    self.descLab.hidden = YES;
}

- (void)setUPViewsCreate {
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(kScrAdaptationH(15), kScrAdaptationW(15), 0, kScrAdaptationW(15));
    self.topView = [[HXBBaseView_MoreTopBottomView alloc]initWithFrame:CGRectZero andTopBottomViewNumber:3 andViewClass:[UILabel class] andViewHeight:kScrAdaptationH(15) andTopBottomSpace:kScrAdaptationH(20) andLeftRightLeftProportion:0 Space:edgeInsets andCashType:nil];
    self.topView.backgroundColor = [UIColor whiteColor];
}

- (void)setMyPlanDetailsExitModel:(HXBMyPlanDetailsExitModel *)myPlanDetailsExitModel {
    self.descLab.text = myPlanDetailsExitModel.quitDesc ? myPlanDetailsExitModel.quitDesc:@"";
    self.cancelBtn.hidden = !myPlanDetailsExitModel;
    self.exitBtn.hidden = !myPlanDetailsExitModel;
    self.iconImgV.hidden = !myPlanDetailsExitModel;
    self.descLab.hidden = !myPlanDetailsExitModel;
}

- (void)exitBtnClick {
    if (self.exitBtnClickBlock) {
        self.exitBtnClickBlock();
    }
}

- (void)cancelBtnClick {
    if (self.cancelBtnClickBlock) {
        self.cancelBtnClickBlock();
    }
}

- (UIButton *)exitBtn {
    if (!_exitBtn) {
        _exitBtn = [[UIButton alloc]initWithFrame:CGRectZero];
        [_exitBtn setTitle:@"确认退出" forState:UIControlStateNormal];
        [_exitBtn.layer setBorderColor:kHXBFountColor_F55151_100.CGColor];
        [_exitBtn.layer setBorderWidth:1.0f];
        [_exitBtn setTitleColor:kHXBFountColor_F55151_100 forState:UIControlStateNormal];
        [_exitBtn setBackgroundColor:kHXBColor_BackGround];
        _exitBtn.userInteractionEnabled = YES;
        _exitBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(32);
        _exitBtn.layer.cornerRadius = 5.0f;
        _exitBtn.layer.masksToBounds = YES;
        
        [_exitBtn addTarget:self action:@selector(exitBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _exitBtn;
}
- (UIButton *)cancelBtn {
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc]initWithFrame:CGRectZero];
        [_cancelBtn setTitle:@"暂不退出" forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:RGB(255, 255, 255) forState:UIControlStateNormal];
        [_cancelBtn setBackgroundColor:kHXBFountColor_F55151_100];
        _cancelBtn.userInteractionEnabled = YES;
        _cancelBtn.titleLabel.font = kHXBFont_PINGFANGSC_REGULAR_750(32);
        _cancelBtn.layer.cornerRadius = 5.0f;
        _cancelBtn.layer.masksToBounds = YES;
        [_cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
- (UIImageView *)iconImgV {
    if (!_iconImgV) {
        _iconImgV = [[UIImageView alloc]init];
        _iconImgV.image = [UIImage imageNamed:@"myPlanDetailsExitIcon"];
    }
    return _iconImgV;
}
- (UILabel *)descLab {
    if (!_descLab) {
        _descLab = [[UILabel alloc]init];
        _descLab.numberOfLines = 0;
        _descLab.textColor = kHXBColor_999999_100;
        _descLab.font = kHXBFont_PINGFANGSC_REGULAR_750(26);
        _descLab.text = @"";
    }
    return _descLab;
}
@end


@implementation HXBMyPlanDetailsExitMainViewManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUP];
    }
    return self;
}
- (void)setUP {
    
    /**
     计划金额
     加入条件
     加入上线
     */
    self.topViewManager = [[HXBBaseView_MoreTopBottomViewManager alloc]init];
    self.topViewManager.leftLabelAlignment = NSTextAlignmentLeft;
    self.topViewManager.rightLabelAlignment = NSTextAlignmentRight;
    self.topViewManager.leftTextColor = kHXBColor_Grey_Font0_2;
    self.topViewManager.rightTextColor = kHXBColor_Font0_6;
    self.topViewManager.leftFont = kHXBFont_PINGFANGSC_REGULAR_750(30);
    self.topViewManager.rightFont = kHXBFont_PINGFANGSC_REGULAR_750(30);
}
@end
