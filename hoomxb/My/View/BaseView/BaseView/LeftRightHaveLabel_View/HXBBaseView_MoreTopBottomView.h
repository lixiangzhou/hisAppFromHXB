//
//  HXBBaseView_MoreTopBottomView.h
//  hoomxb
//
//  Created by HXB on 2017/6/23.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXBBaseView_MoreTopBottomViewManager;
typedef enum : NSUInteger {
    HXBBaseView_MoreTopBottomViewManager_Alignment_LeftRight = 1,
    HXBBaseView_MoreTopBottomViewManager_Alignment_center,
} HXBBaseView_MoreTopBottomViewManager_Alignment;
@interface HXBBaseView_MoreTopBottomView : UIView


- (void)setUPViewManagerWithBlock: (HXBBaseView_MoreTopBottomViewManager *(^)(HXBBaseView_MoreTopBottomViewManager *viewManager))setUPViewManagerBlock;
/**
 左边的viewArray
 */
@property (nonatomic,strong) NSArray <UIView *> *leftViewArray;
/**
 右边的viewArray
 */
@property (nonatomic,strong) NSArray <UIView *> *rightViewArray;
/**
 所有的viewArray
 */
@property (nonatomic,strong) NSArray <UIView *> *allViewArray;

@property (nonatomic,copy) NSString* cashType;//退出方式
/**
 创建方法
 @param topBottomViewNumber 上下一共几层
 @param clas view的类型
 @param topBottomSpace 层级间的间距
 @param leftProportion  左边占的总体长度的比例 （左 : 全部）
 */
- (instancetype)initWithFrame:(CGRect)frame andTopBottomViewNumber:(NSInteger)topBottomViewNumber andViewClass: (Class)clas andViewHeight: (CGFloat)viewH andTopBottomSpace: (CGFloat)topBottomSpace andLeftRightLeftProportion: (CGFloat)leftProportion;

//嵌入一个大的背景的view
/**
 创建方法 (尽量用这个比较好)
 @param topBottomViewNumber 上下一共几层
 @param clas view的类型
 @param topBottomSpace 层级间的间距
 @param leftProportion  左右 的间距
 @param space 上下左右的间距
 */
- (instancetype)initWithFrame:(CGRect)frame andTopBottomViewNumber:(NSInteger)topBottomViewNumber andViewClass: (Class)clas andViewHeight: (CGFloat)viewH andTopBottomSpace: (CGFloat)topBottomSpace andLeftRightLeftProportion: (CGFloat)leftProportion Space:(UIEdgeInsets)space;



@end

@interface  HXBBaseView_MoreTopBottomViewManager : NSObject
@property (nonatomic,assign) NSTextAlignment                leftLabelAlignment;
@property (nonatomic,assign) NSTextAlignment                rightLabelAlignment;
/**
 左侧的stringArray
如果用富文本那么必须从这个数组中取出
 */
@property (nonatomic,strong) NSArray <NSString *>           *leftStrArray;
/**
 右侧的stringArray
 */
@property (nonatomic,strong) NSArray <NSString *>           *rightStrArray;
/**
 左侧的viewArray
 */
@property (nonatomic,strong) NSArray <UIView *>    *leftViewArray;
/**
 右侧的viewArray
 */
@property (nonatomic,strong) NSArray <UIView *>    *rightViewArray;
/**
 全部的viewArray
 */
@property (nonatomic,strong) NSArray <UIView *>    *allViewArray;
/**
 对其方式
 */
@property (nonatomic,assign) HXBBaseView_MoreTopBottomViewManager_Alignment alignment;

/**
 颜色
 */
@property (nonatomic,strong) UIColor *leftTextColor;
@property (nonatomic,strong) UIColor *rightTextColor;

@property (nonatomic,strong) UIColor *leftViewColor;
@property (nonatomic,strong) UIColor *rightViewColor;

@property (nonatomic,strong) UIFont *leftFont;
@property (nonatomic,strong) UIFont *rightFont;
@end
