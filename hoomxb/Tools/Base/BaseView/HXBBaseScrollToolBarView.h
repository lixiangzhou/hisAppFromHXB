//
//  PYScrollToolBarView.h
//  PYToolBarView
//
//  Created by HXB on 2017/4/24.
//  Copyright © 2017年 liPengYue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBBaseToolBarView;
@interface HXBBaseScrollToolBarView : UIScrollView
///底部的view的集合
@property (nonatomic,strong) NSArray <UIView *>* bottomViewSet;

///中间的工具栏距离self左右两边的距离
@property (nonatomic,assign) CGFloat midToolBarViewMargin;

@property (nonatomic,assign) NSInteger selectToolBarViewIndex;



+ (instancetype) scrollToolBarViewWithFrame:(CGRect)frame
                                 andTopView:(UIView *)topView
                                andTopViewH:(CGFloat)topViewH
                          andMidToolBarView:(HXBBaseToolBarView *)midToolBarView
                    andMidToolBarViewMargin:(CGFloat)midToolBarViewMargin
                         andMidToolBarViewH:(CGFloat)midToolBarViewH
                           andBottomViewSet:(NSArray <UIView *>*)bottomViewSet;

- (instancetype) initWithFrame:(CGRect)frame
                    andTopView:(UIView *)topView
                   andTopViewH:(CGFloat)topViewH
             andMidToolBarView:(HXBBaseToolBarView *)midToolBarView
       andMidToolBarViewMargin:(CGFloat)midToolBarViewMargin
            andMidToolBarViewH:(CGFloat)midToolBarViewH
              andBottomViewSet:(NSArray <UIView *>*)bottomViewSet;
///对于中间的ToolBarView点击事件的回调
- (void)midToolBarViewClickWithBlock: (void(^)(NSInteger index, NSString *title,UIButton *option))clickMidToolBarViewBlock;

- (void)show;
@end
