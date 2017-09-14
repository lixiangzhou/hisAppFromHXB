//
//  HXBWithdrawCardView.h
//  hoomxb
//
//  Created by HXB-C on 2017/7/7.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBCardBinModel;
@interface HXBWithdrawCardView : UIView

/**
 bankName
 */
//@property (nonatomic, copy) NSString *bankName;

/**
 bankCode
 */
//@property (nonatomic, copy) NSString *bankCode;

/**
 卡bin数据
 */
@property (nonatomic, strong) HXBCardBinModel *cardBinModel;

/**
 bankNameBtnClickBlock
 */
@property (nonatomic, copy) void(^bankNameBtnClickBlock)();

/**
 nextButtonClickBlcok
 */
@property (nonatomic, copy) void(^nextButtonClickBlock)(NSDictionary *dic);

/**
 卡bin校验
 */
@property (nonatomic, copy) void(^checkCardBin)(NSString *bankNumber);



@end
