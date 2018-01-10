//
//  HXBFinPlanDetail_DetailView.m
//  hoomxb
//
//  Created by HXB on 2017/7/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinPlanDetail_DetailView.h"


@interface HXBFinPlanDetail_DetailView ()
/**
计划金额
 加入条件
 加入上线
 */
@property (nonatomic,strong) HXBBaseView_MoreTopBottomView *addView;
/**
 开始加入日期
 退出日期
 期限
 */
@property (nonatomic,strong) HXBBaseView_MoreTopBottomView *dateView;
/**
 到期退出方式
 安全屏障
 受益处理方式
 */
@property (nonatomic,strong) HXBBaseView_MoreTopBottomView *typeView;

@property (nonatomic,copy) NSString *cashType;//类型
@property (nonatomic,assign) NSUInteger typeViewCount;//类型上下层级
/**
 服务费
 */
@property (nonatomic,strong) HXBBaseView_MoreTopBottomView *serverView;

///点击了红利计划服务协议
@property (nonatomic,copy) void(^clickServerButtonBlock)(UILabel *button);
@end

@implementation HXBFinPlanDetail_DetailView

- (instancetype) initWithFrame:(CGRect)frame withCashType:(NSString *) cashType{
    if (self = [super initWithFrame:frame]) {
        self.cashType = cashType;
        self.typeViewCount = [self.cashType isEqualToString:FIN_PLAN_INCOMEAPPROACH_MONTHLY] ? 3 : 2;//是否按月付息
        [self setUP];
        _manager = [[HXBFinPlanDetail_DetailViewManager alloc]init];
    }
    return self;
}

- (instancetype) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setUP];
        _manager = [[HXBFinPlanDetail_DetailViewManager alloc]init];
    }
    return self;
}
- (void)setUP {
    self.backgroundColor = kHXBColor_BackGround;
    [self creatSubViews];
    [self setUPSubViewsFrame];
}


- (void)setValueManager_PlanDetail_Detail: (HXBFinPlanDetail_DetailViewManager *(^)(HXBFinPlanDetail_DetailViewManager *manager))planDDetailManagerBlock {
    self.manager = planDDetailManagerBlock(_manager);
    
}
- (void)setManager:(HXBFinPlanDetail_DetailViewManager *)manager {
    _manager = manager;
    [self.addView setUPViewManagerWithBlock:^HXBBaseView_MoreTopBottomViewManager *(HXBBaseView_MoreTopBottomViewManager *viewManager) {
        return manager.addViewManager;
    }];
    [self.dateView setUPViewManagerWithBlock:^HXBBaseView_MoreTopBottomViewManager *(HXBBaseView_MoreTopBottomViewManager *viewManager) {
        return manager.dateViewManager;
    }];
    [self.typeView setUPViewManagerWithBlock:^HXBBaseView_MoreTopBottomViewManager *(HXBBaseView_MoreTopBottomViewManager *viewManager) {
        return manager.typeViewManager;
    }];
    [self.serverView setUPViewManagerWithBlock:^HXBBaseView_MoreTopBottomViewManager *(HXBBaseView_MoreTopBottomViewManager *viewManager) {
        return manager.serverViewManager;
    }];
    /// 设置服务协议富文本
    UILabel *label = (UILabel *)self.serverView.rightViewArray.firstObject;
    label.attributedText = manager.serverViewAttributedStr;
}


- (void)creatSubViews {
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(kScrAdaptationH(15), kScrAdaptationW(15), 0, kScrAdaptationW(15));
    self.addView = [[HXBBaseView_MoreTopBottomView alloc]initWithFrame:CGRectZero andTopBottomViewNumber:3 andViewClass:[UILabel class] andViewHeight:kScrAdaptationH(15) andTopBottomSpace:kScrAdaptationH(20) andLeftRightLeftProportion:0 Space:edgeInsets andCashType:nil];
    
    self.dateView = [[HXBBaseView_MoreTopBottomView alloc]initWithFrame:CGRectZero andTopBottomViewNumber:3 andViewClass:[UILabel class] andViewHeight:kScrAdaptationH(15) andTopBottomSpace:kScrAdaptationH(20) andLeftRightLeftProportion:1.0/3 Space:edgeInsets andCashType:nil];
    
    self.typeView = [[HXBBaseView_MoreTopBottomView alloc]initWithFrame:CGRectZero andTopBottomViewNumber:self.typeViewCount andViewClass:[UILabel class] andViewHeight:kScrAdaptationH(15) andTopBottomSpace:kScrAdaptationH(20) andLeftRightLeftProportion:1.0/3 Space:edgeInsets andCashType:self.cashType];//2
    UILabel * rightView = (UILabel *)self.typeView.rightViewArray[1];
    if ([self.typeView.cashType isEqualToString:FIN_PLAN_INCOMEAPPROACH_MONTHLY] && rightView.subviews.count > 1) {
        UIButton *infoBtn = nil;
        UILabel *lab = nil;
        for (UIView *view in rightView.subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
                infoBtn = (UIButton *)view;
                infoBtn.userInteractionEnabled = NO;
            }
            if ([view isKindOfClass:[UILabel class]]) {
                lab = (UILabel *)view;
                lab.userInteractionEnabled = NO;
            }
        }
        [infoBtn setImage:[UIImage imageNamed:@"lightblue_tip"] forState:UIControlStateNormal];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickInfoBtn)];
        rightView.userInteractionEnabled = YES;
        [rightView addGestureRecognizer:tap1];
        
        UILabel * leftView = (UILabel *)self.typeView.leftViewArray[1];
        UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickInfoBtn)];
        leftView.userInteractionEnabled = YES;
        [leftView addGestureRecognizer:tap2];
    }
    
    self.serverView =  [[HXBBaseView_MoreTopBottomView alloc]initWithFrame:CGRectZero andTopBottomViewNumber:1 andViewClass:[UILabel class] andViewHeight:kScrAdaptationH(15) andTopBottomSpace:kScrAdaptationH(20) andLeftRightLeftProportion:1.0/3 Space:edgeInsets andCashType:nil];
    UILabel *button = (UILabel *)self.serverView.rightViewArray.firstObject;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickServerButton:)];
    [button addGestureRecognizer:tap];
    
    self.addView.backgroundColor = [UIColor whiteColor];
    self.dateView.backgroundColor = [UIColor whiteColor];
    self.typeView.backgroundColor = [UIColor whiteColor];
    self.serverView.backgroundColor = [UIColor whiteColor];
}

- (void)clickInfoBtn{
    NSLog(@"点击infoBtn");
    NSString *titleStr = self.cashType && [self.cashType isEqualToString:FIN_PLAN_INCOMEAPPROACH_MONTHLY] ? @"按月付息" : @"";
    HXBXYAlertViewController *alertVC = [[HXBXYAlertViewController alloc] initWithTitle:titleStr Massage:@"购买该计划产品的用户，收益将会按当月时间返回到账内即可提取，如当月无此付息日，则统一为当月最后一天为该月付息日。" force:2 andLeftButtonMassage:@"" andRightButtonMassage:@"确定"];
    alertVC.isHIddenLeftBtn = YES;
    alertVC.isCenterShow = YES;
    [alertVC setClickXYRightButtonBlock:^{
        [[UIApplication sharedApplication].keyWindow.rootViewController dismissViewControllerAnimated:YES completion:nil];
    }];
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
}

- (void)clickServerButton : (UITapGestureRecognizer *)tap
{
    if (self.clickServerButtonBlock) {
        self.clickServerButtonBlock((UILabel *)tap.view);
    }
}
//点击事件
- (void)clickServerButtonWithBlock:(void (^)(UILabel *))clickServerButtonBlock {
    self.clickServerButtonBlock = clickServerButtonBlock;
}

- (void)setUPSubViewsFrame {
    [self addSubview:self.addView];
    [self addSubview:self.dateView];
    [self addSubview:self.typeView];
    [self addSubview:self.serverView];
    
    [self.addView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kScrAdaptationH(10));
        make.left.right.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH(115)));
    }];
    [self.dateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.addView.mas_bottom).offset(kScrAdaptationH(10));
        make.left.right.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH(115)));
    }];
    [self.typeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dateView.mas_bottom).offset(kScrAdaptationH(10));
        make.left.right.equalTo(self);
        if (self.typeViewCount == 3) {
            make.height.equalTo(@(kScrAdaptationH(115)));
        } else {
            make.height.equalTo(@(kScrAdaptationH(75)));
        }
    }];
    [self.serverView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeView.mas_bottom).offset(kScrAdaptationH(10));
        make.left.right.equalTo(self);
        make.height.equalTo(@(kScrAdaptationH(45)));
    }];
}
@end



@implementation HXBFinPlanDetail_DetailViewManager

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
    self.addViewManager = [[HXBBaseView_MoreTopBottomViewManager alloc]init];
    self.addViewManager.leftLabelAlignment = NSTextAlignmentLeft;
    self.addViewManager.rightLabelAlignment = NSTextAlignmentRight;
    self.addViewManager.leftTextColor = kHXBColor_Grey_Font0_2;
    self.addViewManager.rightTextColor = kHXBColor_Font0_6;
    self.addViewManager.leftFont = kHXBFont_PINGFANGSC_REGULAR(15);
    self.addViewManager.rightFont = kHXBFont_PINGFANGSC_REGULAR(13);
    /**
     开始加入日期
     退出日期
     期限
     */
    self.dateViewManager = [[HXBBaseView_MoreTopBottomViewManager alloc]init];
    self.dateViewManager = [[HXBBaseView_MoreTopBottomViewManager alloc]init];
    self.dateViewManager.leftLabelAlignment = NSTextAlignmentLeft;
    self.dateViewManager.rightLabelAlignment = NSTextAlignmentRight;
    self.dateViewManager.leftTextColor = kHXBColor_Grey_Font0_2;
    self.dateViewManager.rightTextColor = kHXBColor_Font0_6;
    self.dateViewManager.leftFont = kHXBFont_PINGFANGSC_REGULAR(15);
    self.dateViewManager.rightFont = kHXBFont_PINGFANGSC_REGULAR(13);
    /**
     到期退出方式
     安全屏障
     受益处理方式
     */
    self.typeViewManager = [[HXBBaseView_MoreTopBottomViewManager alloc]init];
    self.typeViewManager = [[HXBBaseView_MoreTopBottomViewManager alloc]init];
    self.typeViewManager.leftLabelAlignment = NSTextAlignmentLeft;
    self.typeViewManager.rightLabelAlignment = NSTextAlignmentRight;
    self.typeViewManager.leftTextColor = kHXBColor_Grey_Font0_2;
    self.typeViewManager.rightTextColor = kHXBColor_Font0_6;
    self.typeViewManager.leftFont = kHXBFont_PINGFANGSC_REGULAR(15);
    self.typeViewManager.rightFont = kHXBFont_PINGFANGSC_REGULAR(13);
    
    /**
     服务费
     */
    self.serverViewManager = [[HXBBaseView_MoreTopBottomViewManager alloc]init];
    self.serverViewManager.leftLabelAlignment = NSTextAlignmentLeft;
    self.serverViewManager.rightLabelAlignment = NSTextAlignmentRight;
    self.serverViewManager.leftTextColor = kHXBColor_Grey_Font0_2;
    self.serverViewManager.rightTextColor = kHXBColor_Font0_6;
    self.serverViewManager.leftFont = kHXBFont_PINGFANGSC_REGULAR(15);
    self.serverViewManager.rightFont = kHXBFont_PINGFANGSC_REGULAR(13);
}
@end
