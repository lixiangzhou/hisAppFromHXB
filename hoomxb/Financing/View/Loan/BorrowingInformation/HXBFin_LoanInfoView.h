//
//  HXBFin_LoanInfoView.h
//  hoomxb
//
//  Created by HXB on 2017/7/28.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBFinDetailViewModel_LoanDetail;
@interface HXBFin_LoanInfoView : UIView
@property (nonatomic,strong) HXBFinDetailViewModel_LoanDetail *loan_finDatailModel;
@end




@interface HXBFin_LoanInfoView_Manager : NSObject
///借款说明
@property (nonatomic,copy) NSString *loanInstuctionView;
///借款人信息 (预留接口)
@property (nonatomic,assign) NSInteger loanPerson_infoView;
///基础信息
@property (nonatomic,strong) HXBBaseView_MoreTopBottomViewManager *loanInfoViewManager;
///财务信息
@property (nonatomic,strong) HXBBaseView_MoreTopBottomViewManager *loanFinViewManager;
///工作信息
@property (nonatomic,strong) HXBBaseView_MoreTopBottomViewManager *workInfoViewManager;
@end
