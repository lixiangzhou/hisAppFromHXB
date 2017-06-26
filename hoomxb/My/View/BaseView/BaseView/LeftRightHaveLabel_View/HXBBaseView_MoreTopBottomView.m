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
 管理者
 */
@property (nonatomic,strong) HXBBaseView_MoreTopBottomViewManager *viewManager;
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
    for (NSInteger i = 0; i < self.leftViewArray.count; i++) {
        BOOL isSetUPViewValue_Left = [self setValueWithView:self.leftViewArray[i] andStr:self.viewManager.leftStrArray[i] andAlignment: self.viewManager.leftLabelAlignment];
        BOOL isSetUPViewValue_right = [self setValueWithView:self.rightViewArray[i] andStr:self.viewManager.rightStrArray[i] andAlignment: self.viewManager.rightLabelAlignment];
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
- (instancetype)initWithFrame:(CGRect)frame andTopBottomViewNumber:(NSInteger)topBottomViewNumber andViewClass: (Class)clas andViewHeight: (CGFloat)viewH andTopBottomSpace: (CGFloat)topBottomSpace{
    if (self = [super initWithFrame:frame]) {
        _viewManager = [[HXBBaseView_MoreTopBottomViewManager alloc]init];
        [self setUPViewsCreatWithTopBottomViewNumber:topBottomViewNumber andViewClass:clas];
        self.viewH = viewH;
        self.topBottomSpace = topBottomSpace;
        [self setUPViews_frame];
    }
    return self;
}

- (void)setUPViewsCreatWithTopBottomViewNumber: (NSInteger)topBottomViewNumber andViewClass: (Class)class {
    NSMutableArray <UIView *>*leftViewArray = [[NSMutableArray alloc]init];
    NSMutableArray <UIView *>*rightViewArray = [[NSMutableArray alloc]init];
    NSMutableArray <UIView *>*allViewArray = [[NSMutableArray alloc]init];
    
    if (![class isSubclassOfClass:[UIView class]]) {
        NSLog(@"%@ 🌶 不能创建非 view类型",self);
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
- (BOOL) setValueWithView: (UIView *)view andStr: (NSString *)value andAlignment: (NSTextAlignment)alignment {
    if ([view isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)view;
        label.text = value;
        label.textAlignment = alignment;
        return true;
    }
    if ([view isKindOfClass:[UIButton class]]) {
        UIButton *button = (UIButton *)view;
        [button setTitle:value forState:UIControlStateNormal];
        return true;
    }
    return false;
}
//正在进行
- (void)setUPViews_frame {
   
    for (NSInteger i = 0; i < self.leftViewArray.count; i++) {
        if (i == 0) {
            [self.leftViewArray[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.equalTo(self);
                make.height.equalTo(@(self.viewH));
                make.right.equalTo(self.mas_centerX);
            }];
            [self.rightViewArray[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(self.leftViewArray[i]);
                make.left.equalTo(self.mas_centerX);
                make.right.equalTo(self);
            }];
        } else {
            [self.leftViewArray[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.leftViewArray[i - 1].mas_bottom).offset(self.topBottomSpace);
                make.left.equalTo(self);
                make.height.equalTo(@(self.viewH));
                make.right.equalTo(self.leftViewArray[i - 1].mas_right);
            }];
            [self.rightViewArray[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.top.equalTo(self.leftViewArray[i]);
                make.left.equalTo(self.leftViewArray[i].mas_right);
                make.right.equalTo(self);
            }];
        }
    }
}
@end


@implementation HXBBaseView_MoreTopBottomViewManager
- (void)setRightStrArray:(NSArray<NSString *> *)rightStrArray {
    if (!rightStrArray) {
        NSLog(@"🌶 没有数据 -- %@",self);
    }
    _rightStrArray = rightStrArray;
}

@end
