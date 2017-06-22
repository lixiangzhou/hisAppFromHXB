//
//  HxbMyViewHeaderView.h
//  hoomxb
//
//  Created by HXB-C on 2017/5/4.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MyViewHeaderDelegate <NSObject>
- (void)didClickLeftHeadBtn:(UIButton *_Nullable)sender;
- (void)didClickRightHeadBtn;
- (void)didClickTopUpBtn:(UIButton *_Nullable)sender;
- (void)didClickWithdrawBtn:(UIButton *_Nullable)sender;
@end

@interface HxbMyViewHeaderView : UIView
@property (nonatomic, strong) HXBRequestUserInfoViewModel * _Nonnull userInfoViewModel;
@property (nonatomic,weak,nullable)id<MyViewHeaderDelegate>delegate;
@end
