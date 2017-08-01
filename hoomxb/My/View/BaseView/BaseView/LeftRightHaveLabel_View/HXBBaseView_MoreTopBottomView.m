//
//  HXBBaseView_MoreTopBottomView.m
//  hoomxb
//
//  Created by HXB on 2017/6/23.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
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
    self.alignment = self.viewManager.alignment;
    for (NSInteger i = 0; i < self.leftViewArray.count; i++) {
        BOOL isSetUPViewValue_Left = [self setValueWithView:self.leftViewArray[i]
                                                     andStr:self.viewManager.leftStrArray[i]
                                               andAlignment: self.viewManager.leftLabelAlignment
                                               andTextColor:self.viewManager.leftTextColor
                                         andBackGroundColor:self.viewManager.leftViewColor
                                                    andFont: self.viewManager.leftFont];
       
        BOOL isSetUPViewValue_right = [self setValueWithView:self.rightViewArray[i]
                                                      andStr:self.viewManager.rightStrArray[i]
                                                andAlignment: self.viewManager.rightLabelAlignment
                                                andTextColor:self.viewManager.rightTextColor
                                          andBackGroundColor:self.viewManager.rightViewColor
                                                     andFont:self.viewManager.rightFont];
        if(!isSetUPViewValue_Left) {
            NSLog(@"%@，左边的第 %ld个view赋值失败",self,i);
        }
        if (!isSetUPViewValue_right) {
            NSLog(@"%@, 右边的第 %ld个view赋值失败",self,i);
        }
    }
}
//- (void)setViewManager:(HXBBaseView_MoreTopBottomViewManager *)viewManager {
//    _viewManager = viewManager;
//    for (NSInteger i = 0; i < self.leftViewArray.count; i++) {
//        BOOL isSetUPViewValue_Left = [self setValueWithView:self.leftViewArray[i] andStr:self.viewManager.leftStrArray[i]];
//        BOOL isSetUPViewValue_right = [self setValueWithView:self.rightViewArray[i] andStr:self.viewManager.rightStrArray[i]];
//        if(!isSetUPViewValue_Left) {
//            NSLog(@"%@，左边的第 %ld个view赋值失败",self,i);
//        }
//        if (!isSetUPViewValue_right) {
//            NSLog(@"%@, 右边的第 %ld个view赋值失败",self,i);
//        }
//    }
//}

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

- (instancetype)initWithFrame:(CGRect)frame andTopBottomViewNumber:(NSInteger)topBottomViewNumber andViewClass:(Class)clas andViewHeight:(CGFloat)viewH andTopBottomSpace:(CGFloat)topBottomSpace andLeftRightLeftProportion:(CGFloat)leftProportion Space:(UIEdgeInsets)space {
    if (self = [super initWithFrame:frame]) {
        _viewManager = [[HXBBaseView_MoreTopBottomViewManager alloc]init];
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
            UIView * rightView = [[class alloc]init];
            [self addSubview:rightView];
            [rightViewArray addObject:rightView];
            [allViewArray addObject:rightView];
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
- (BOOL) setValueWithView: (UIView *)view andStr: (NSString *)value andAlignment: (NSTextAlignment)alignment andTextColor:(UIColor *)textColor andBackGroundColor: (UIColor *)backGroundColor andFont: (UIFont *)font{
    view.userInteractionEnabled = true;
    if(!backGroundColor) {
        backGroundColor = [UIColor whiteColor];
    }
    if ([view isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)view;
        label.text = value;
        label.textAlignment = alignment;
        label.textColor = textColor;
        label.backgroundColor = backGroundColor;
        label.font = font;
        return true;
    }
    if ([view isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)view;
        [button setTitle:value forState:UIControlStateNormal];
        [button setTitleColor:textColor forState:UIControlStateNormal];
        button.backgroundColor = backGroundColor;
        button.titleLabel.font = font;
        return true;
    }
    return false;
}

- (void) setUPViewsFrameWithRightViewNotTitle {
    
}

//正在进行
- (void)setUPViews_frameWithSpace:(UIEdgeInsets)space {
    
    for (NSInteger i = 0; i < self.leftViewArray.count; i++) {
        [self.leftViewArray[i] sizeToFit];
        [self.rightViewArray[i] sizeToFit];
        if (i == 0) {
            [self.leftViewArray[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self).offset(space.top);
                make.left.equalTo(self).offset(space.left);
                make.height.equalTo(@(self.viewH));
            }];
            [self.rightViewArray[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(self.leftViewArray[i]);
                make.left.equalTo(self.leftViewArray[i].mas_right).offset(self.leftProportion);
                make.right.equalTo(self).offset(-space.right);
            }];
        } else {
            [self.leftViewArray[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.leftViewArray[i - 1].mas_bottom).offset(self.topBottomSpace);
                make.left.equalTo(self.leftViewArray[i - 1]);
                make.height.equalTo(self.leftViewArray[i - 1]);
//                make.width.equalTo(self.leftViewArray[i - 1]);
            }];
            [self.rightViewArray[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.top.equalTo(self.leftViewArray[i]);
                make.left.equalTo(self.leftViewArray[i].mas_right).offset(self.leftProportion);
                make.right.equalTo(self.rightViewArray[i - 1]);
            }];
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
