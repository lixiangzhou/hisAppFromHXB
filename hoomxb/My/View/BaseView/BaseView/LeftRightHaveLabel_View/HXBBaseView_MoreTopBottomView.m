//
//  HXBBaseView_MoreTopBottomView.m
//  hoomxb
//
//  Created by HXB on 2017/6/23.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseView_MoreTopBottomView.h"
@interface HXBBaseView_MoreTopBottomView ()

/**
 viewH
 */
@property (nonatomic,assign) CGFloat viewH;
/**
 上下间距
 */
@property (nonatomic,assign) CGFloat topBottomSpace;
/**
 左边占的总体长度的比例 （左 : 全部）
 */
@property (nonatomic,assign) CGFloat leftProportion;
/**
 管理者
 */
@property (nonatomic,strong) HXBBaseView_MoreTopBottomViewManager *viewManager;
/**
 对其方式
 */
@property (nonatomic,assign) HXBBaseView_MoreTopBottomViewManager_Alignment alignment;

@end

@implementation HXBBaseView_MoreTopBottomView
@synthesize viewManager = _viewManager;
- (HXBBaseView_MoreTopBottomViewManager *)viewManager {
    if (!_viewManager) {
        _viewManager = [[HXBBaseView_MoreTopBottomViewManager alloc]init];
    }
    return _viewManager;
}
- (void)setUPViewManagerWithBlock: (HXBBaseView_MoreTopBottomViewManager *(^)(HXBBaseView_MoreTopBottomViewManager *viewManager))setUPViewManagerBlock {
    self.viewManager = setUPViewManagerBlock(self.viewManager);
}
- (void)setViewManager:(HXBBaseView_MoreTopBottomViewManager *)viewManager {
    _viewManager = viewManager;
    self.alignment = self.viewManager.alignment;
    for (NSInteger i = 0; i < self.leftViewArray.count; i++) {
        BOOL isSetUPViewValue_Left = [self setValueWithView:self.leftViewArray[i]
                                                     andStr:self.viewManager.leftStrArray[i]
                                               andAlignment: self.viewManager.leftLabelAlignment
                                               andTextColor:self.viewManager.leftTextColor
                                         andBackGroundColor:self.viewManager.leftViewColor
                                                    andFont: self.viewManager.leftFont
                                                     andNum:i andLeftOrRight:@"left"];
        
        BOOL isSetUPViewValue_right = [self setValueWithView:self.rightViewArray[i]
                                                      andStr:self.viewManager.rightStrArray[i]
                                                andAlignment: self.viewManager.rightLabelAlignment
                                                andTextColor:self.viewManager.rightTextColor
                                          andBackGroundColor:self.viewManager.rightViewColor
                                                     andFont:self.viewManager.rightFont
                                                      andNum:i andLeftOrRight:@"right"];
        if(!isSetUPViewValue_Left) {
            NSLog(@"%@，左边的第 %ld个view赋值失败",self,i);
        }
        if (!isSetUPViewValue_right) {
            NSLog(@"%@, 右边的第 %ld个view赋值失败",self,i);
        }
    }
}

- (void)setAlignment:(HXBBaseView_MoreTopBottomViewManager_Alignment)alignment {
    if (alignment) {
        switch (alignment) {
                //左右模式 左-》左边，右边-》右边
            case HXBBaseView_MoreTopBottomViewManager_Alignment_LeftRight:
                
                break;
                
            default:
                break;
        }
    }
}
- (instancetype)initWithFrame:(CGRect)frame andTopBottomViewNumber:(NSInteger)topBottomViewNumber andViewClass: (Class)clas andViewHeight: (CGFloat)viewH andTopBottomSpace: (CGFloat)topBottomSpace andLeftRightLeftProportion: (CGFloat)leftProportion{
    if (self = [super initWithFrame:frame]) {
        _viewManager = [[HXBBaseView_MoreTopBottomViewManager alloc]init];
        [self setUPViewsCreatWithTopBottomViewNumber:topBottomViewNumber andViewClass:clas];
        self.viewH = viewH;
        self.topBottomSpace = topBottomSpace;
        self.leftProportion = leftProportion;
        UIEdgeInsets space = UIEdgeInsetsMake(0, 0, 0, 0);
        [self setUPViews_frameWithSpace:space];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame andTopBottomViewNumber:(NSInteger)topBottomViewNumber andViewClass:(Class)clas andViewHeight:(CGFloat)viewH andTopBottomSpace:(CGFloat)topBottomSpace andLeftRightLeftProportion:(CGFloat)leftProportion Space:(UIEdgeInsets)space andCashType:(NSString *)cashType{
    if (self = [super initWithFrame:frame]) {
        _viewManager = [[HXBBaseView_MoreTopBottomViewManager alloc]init];
        self.cashType = cashType;
        [self setUPViewsCreatWithTopBottomViewNumber:topBottomViewNumber andViewClass:clas];
        self.viewH = viewH;
        self.topBottomSpace = topBottomSpace;
        self.leftProportion = leftProportion;
        [self setUPViews_frameWithSpace:space];
    }
    return self;
}


- (void)setUPViewsCreatWithTopBottomViewNumber: (NSInteger)topBottomViewNumber andViewClass: (Class)class {
    NSMutableArray <UIView *>*leftViewArray = [[NSMutableArray alloc]init];
    NSMutableArray <UIView *>*rightViewArray = [[NSMutableArray alloc]init];
    NSMutableArray <UIView *>*allViewArray = [[NSMutableArray alloc]init];
    
    if (![class isSubclassOfClass:[UIView class]]) {
        NSLog(@"%@ 🌶 不能创建非 view类型  - setUPViewsCreatWithTopBottomViewNumber -",self);
        return;
    }
    for (NSInteger i = 1; i < topBottomViewNumber * 2 + 1; i ++) {
        if (i % 2 == 0) {
            if ([self.cashType isEqualToString:FIN_PLAN_INCOMEAPPROACH_MONTHLY] && 4 == i) {

                UILabel * rightView = [[UILabel alloc]init];
                UILabel *infoLab = [[UILabel alloc]init];
                [rightView addSubview:infoLab];
                UIButton *infoBtn = [[UIButton alloc]init];
                [rightView addSubview:infoBtn];
                
                [self addSubview:rightView];
                [rightViewArray addObject:rightView];
                [allViewArray addObject:rightView];
            } else {
                UIView * rightView = [[class alloc]init];
                [self addSubview:rightView];
                [rightViewArray addObject:rightView];
                [allViewArray addObject:rightView];
            }
        }else {
            UIView *leftView = [[class alloc] init];
            [self addSubview:leftView];
            [leftViewArray addObject:leftView];
            [allViewArray addObject:leftView];
        }
    }
    [self setValue:leftViewArray forKey:@"leftViewArray"];
    [self setValue:rightViewArray forKey:@"rightViewArray"];
    [self setValue:allViewArray forKey:@"allViewArray"];

    [self.viewManager setValue:self.leftViewArray forKey:@"leftViewArray"];
    [self.viewManager setValue:self.leftViewArray forKey:@"rightViewArray"];
    [self.viewManager setValue:self.leftViewArray forKey:@"allViewArray"];
}
///给view 赋值，并且返回是否赋值成功
- (BOOL) setValueWithView: (UIView *)view andStr: (NSString *)value andAlignment: (NSTextAlignment)alignment andTextColor:(UIColor *)textColor andBackGroundColor: (UIColor *)backGroundColor andFont: (UIFont *)font andNum: (NSInteger)i andLeftOrRight:(NSString *)location{
    view.userInteractionEnabled = YES;
    if(!backGroundColor) {
        backGroundColor = [UIColor whiteColor];
    }
    if ([view isKindOfClass:[UILabel class]]) {
        if ([self.cashType isEqualToString:FIN_PLAN_INCOMEAPPROACH_MONTHLY] && 1 == i &&  [location isEqualToString:@"right"] && self.rightViewArray[i].subviews.count>1) {
            UILabel *infoLab = nil;
            for (UIView *view in self.rightViewArray[i].subviews) {
                if ([view isKindOfClass:[UILabel class]]) {
                    infoLab = (UILabel *)view;
                    infoLab.text = value;
                    infoLab.textAlignment = alignment;
                    infoLab.textColor = textColor;
                    infoLab.backgroundColor = backGroundColor;
                    infoLab.font = font;
//                    infoLab.userInteractionEnabled = YES;
//                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickInfoBtn)];
//                    [infoLab addGestureRecognizer:tap];
                    
                    return YES;
                }
            }
        }
        UILabel *label = (UILabel *)view;
        label.text = value;
        label.textAlignment = alignment;
        label.textColor = textColor;
        label.backgroundColor = backGroundColor;
        label.font = font;
        return YES;
    }
    if ([view isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)view;
        [button setTitle:value forState:UIControlStateNormal];
        [button setTitleColor:textColor forState:UIControlStateNormal];
        button.backgroundColor = backGroundColor;
        button.titleLabel.font = font;
        return YES;
    }
    return NO;
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

- (void) setUPViewsFrameWithRightViewNotTitle {
    
}

//正在进行
- (void)setUPViews_frameWithSpace:(UIEdgeInsets)space {
    kWeakSelf
    for (NSInteger i = 0; i < self.leftViewArray.count; i++) {
        [self.leftViewArray[i] sizeToFit];
        [self.rightViewArray[i] sizeToFit];
        if (i == 0) {
            [self.leftViewArray[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf).offset(space.top);
                make.left.equalTo(weakSelf).offset(space.left);
                make.height.equalTo(@(weakSelf.viewH));
            }];
            [self.rightViewArray[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(weakSelf.leftViewArray[i]);
                make.left.equalTo(weakSelf.leftViewArray[i].mas_right).offset(weakSelf.leftProportion);
                make.right.equalTo(weakSelf).offset(-space.right);
            }];
        } else {
            [self.leftViewArray[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(weakSelf.leftViewArray[i - 1].mas_bottom).offset(weakSelf.topBottomSpace);
                make.left.equalTo(weakSelf.leftViewArray[i - 1]);
                make.height.equalTo(weakSelf.leftViewArray[i - 1]);
//                make.width.equalTo(self.leftViewArray[i - 1]);
            }];
            [self.rightViewArray[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.top.equalTo(weakSelf.leftViewArray[i]);
                make.left.equalTo(weakSelf.leftViewArray[i].mas_right).offset(weakSelf.leftProportion);
                make.right.equalTo(weakSelf.rightViewArray[i - 1]);
            }];
            
            if ([self.cashType isEqualToString:FIN_PLAN_INCOMEAPPROACH_MONTHLY] && 1 == i && self.rightViewArray[i].subviews.count>1) {
                UIButton *infoBtn = nil;
                UILabel *infoLab = nil;
                for (UIView *view in self.rightViewArray[i].subviews) {
                    if ([view isKindOfClass:[UILabel class]]) {
                        infoLab = (UILabel *)view;
                    }
                    if ([view isKindOfClass:[UIButton class]]) {
                        infoBtn = (UIButton *)view;
                    }
                }
                [infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.right.mas_equalTo(weakSelf.rightViewArray[i].right).offset(-kScrAdaptationH(20));
                    make.left.equalTo(weakSelf.rightViewArray[i]);
                    make.bottom.top.equalTo(weakSelf.rightViewArray[i]);
                }];
                [infoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.top.equalTo(weakSelf.rightViewArray[i]);
                    make.width.mas_equalTo(kScrAdaptationW(14));
                    make.left.equalTo(infoLab.mas_right).offset(kScrAdaptationW(5));
                }];
            }
        }
    }
}
@end


@implementation HXBBaseView_MoreTopBottomViewManager
- (void)setRightStrArray:(NSArray<NSString *> *)rightStrArray {
    if (!rightStrArray.count) {
        NSLog(@"🌶 没有数据 -- %@",self);
    }
    _rightStrArray = rightStrArray;
}
@end
