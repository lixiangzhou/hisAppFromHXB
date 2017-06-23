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
- (void)setUPViewManagerWithBlock: (HXBBaseView_MoreTopBottomViewManager *(^)(HXBBaseView_MoreTopBottomViewManager *viewManager))setUPViewManagerBlock {
    self.viewManager = setUPViewManagerBlock(self.viewManager);
}
- (void)setViewManager:(HXBBaseView_MoreTopBottomViewManager *)viewManager {
    _viewManager = viewManager;
    [self setUPViews_frame];
}
- (instancetype)initWithFrame:(CGRect)frame andTopBottomViewNumber:(NSInteger)topBottomViewNumber andViewClass: (Class)clas andViewHeight: (CGFloat)viewH andTopBottomSpace: (CGFloat)topBottomSpace{
    if (self = [super initWithFrame:frame]) {
        _viewManager = [[HXBBaseView_MoreTopBottomViewManager alloc]init];
        [self setUPViewsCreatWithTopBottomViewNumber:topBottomViewNumber andViewClass:clas];
        self.viewH = viewH;
        self.topBottomSpace = topBottomSpace;
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
    for (NSInteger i = 0; i < topBottomViewNumber; i ++) {
        if (i % 2 == 0) {
            UIView * rightView = [[class alloc]init];
            [rightViewArray addObject:rightView];
            [allViewArray addObject:rightView];
        }else {
            UIView *leftView = [[class alloc] init];
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
- (BOOL) setValueWithView: (UIView *)view andStr: (NSString *)value {
    if ([view isKindOfClass:[UILabel class]]) {
        UILabel *label = (UILabel *)view;
        label.text = value;
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
        BOOL isSetUPViewValue_Left = [self setValueWithView:self.leftViewArray[i] andStr:self.viewManager.leftStrArray[i]];
        BOOL isSetUPViewValue_right = [self setValueWithView:self.rightViewArray[i] andStr:self.viewManager.rightStrArray[i]];
        if(!isSetUPViewValue_Left) {
            NSLog(@"%@，左边的第 %ld个view赋值失败",self,i);
        }
        if (!isSetUPViewValue_right) {
            NSLog(@"%@, 右边的第 %ld个view赋值失败",self,i);
        }
        if (i == 0) {
            [self.leftViewArray[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.left.equalTo(self);
                make.height.equalTo(@(self.viewH));
                make.left.equalTo(self.mas_centerX);
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
                make.left.equalTo(self.leftViewArray[i - 1].mas_centerX);
            }];
            [self.rightViewArray[i] mas_makeConstraints:^(MASConstraintMaker *make) {
                make.bottom.top.equalTo(self.leftViewArray[i]);
                make.left.equalTo(self.mas_centerX);
                make.right.equalTo(self);
            }];
        }
    }
}
@end


@implementation HXBBaseView_MoreTopBottomViewManager


@end
