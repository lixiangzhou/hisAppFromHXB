//
//  HXBMY_PlanDetailView.h
//  hoomxb
//
//  Created by HXB on 2017/5/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBMYViewModel_PlanDetailViewModel;
@class HXBMY_PlanDetailView_Manager;
#import "HXBBaseView_TwoLable_View.h"///两个label的组件
#import "HXBBaseView_MoreTopBottomView.h"///多个topBottomView
@interface HXBMY_PlanDetailView : UIView
/**
 加入金额 
 ....
 的层数
 */
@property (nonatomic,assign) NSInteger cake;
- (instancetype) initWithFrame:(CGRect)frame andInfoHaveCake:(NSInteger)cake;
@property (nonatomic,strong) HXBMYViewModel_PlanDetailViewModel *planDetailViewModel;
/**
 投资记录的点击事件
 协议
 */
- (void)clickBottomTableViewCellBloakFunc:(void(^)(NSInteger index))clickBottomTableViewCell;

/**
 点击了 追加按钮
 */
- (void)clickAddButtonWithBlock:(void(^)(UIButton *button))clickAddButtonBlock;
- (void)setUPValueWithViewManagerBlock: (HXBMY_PlanDetailView_Manager *(^)(HXBMY_PlanDetailView_Manager *manager))viewManagerBlock;
@end

@interface HXBMY_PlanDetailView_Manager : NSObject
@property (nonatomic,copy) NSString                                 *typeImageName;
/**
 顶部的VIew状态
 */
@property (nonatomic,copy) NSString                                 *topViewStatusStr;
/**
 topViewMassge
 */
@property (nonatomic,strong) HXBBaseView_TwoLable_View_ViewModel      *topViewMassgeManager;
/**
 标信息的view
 */
@property (nonatomic,strong) HXBBaseView_MoreTopBottomViewManager     *infoViewManager;
/**
 type view
 */
@property (nonatomic,strong) HXBBaseView_MoreTopBottomViewManager      *typeViewManager;
///**
// // 投资记录
// */
//@property (nonatomic,strong) HXBBaseView_MoreTopBottomViewManager      *contractViewManager;
///**
// 投资记录
// */
//@property (nonatomic,strong) HXBBaseView_MoreTopBottomViewManager      *loanRecordViewManager;
/// 投资记录 ||  投资记录 str array
@property (nonatomic,strong) NSArray *strArray;
/**
 是否隐藏 加入按钮
 */
@property (nonatomic,assign) BOOL isHiddenAddButton;
@end
