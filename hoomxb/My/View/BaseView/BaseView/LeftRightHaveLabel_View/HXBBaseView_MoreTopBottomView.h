//
//  HXBBaseView_MoreTopBottomView.h
//  hoomxb
//
//  Created by HXB on 2017/6/23.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXBBaseView_MoreTopBottomViewManager;
@interface HXBBaseView_MoreTopBottomView : UIView

- (void)setUPViewManagerWithBlock: (HXBBaseView_MoreTopBottomViewManager *(^)(HXBBaseView_MoreTopBottomViewManager *viewManager))setUPViewManagerBlock;
/**
 左边的viewArray
 */
@property (nonatomic,strong,readonly) NSArray <UIView *> *leftViewArray;
/**
 右边的viewArray
 */
@property (nonatomic,strong,readonly) NSArray <UIView *> *rightViewArray;
/**
 所有的viewArray
 */
@property (nonatomic,strong,readonly) NSArray <UIView *> *allViewArray;


/**
 创建方法
 @param topBottomViewNumber 上下一共几层
 @param clas view的类型
 @param topBottomSpace 层级间的间距
 */
- (instancetype)initWithFrame:(CGRect)frame andTopBottomViewNumber:(NSInteger)topBottomViewNumber andViewClass: (Class)clas andViewHeight: (CGFloat)viewH andTopBottomSpace: (CGFloat)topBottomSpace;
@end

@interface  HXBBaseView_MoreTopBottomViewManager : NSObject
@property (nonatomic,assign) NSTextAlignment    leftLabelAlignment;
@property (nonatomic,assign) NSTextAlignment    rightLabelAlignment;
/**
 左侧的stringArray
 */
@property (nonatomic,strong) NSArray <NSString *>       *leftStrArray;
/**
 右侧的stringArray
 */
@property (nonatomic,strong) NSArray <NSString *>       *rightStrArray;
/**
 左侧的viewArray
 */
@property (nonatomic,strong,readonly) NSArray <UIView *>*leftViewArray;
/**
 右侧的viewArray
 */
@property (nonatomic,strong,readonly) NSArray <UIView *>*rightViewArray;
/**
 全部的viewArray
 */
@property (nonatomic,strong,readonly) NSArray <UIView *>*allViewArray;
@end
