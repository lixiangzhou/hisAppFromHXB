//
//  HXBHomePageProductCell.h
//  HongXiaoBao
//
//  Created by 牛严 on 16/7/12.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HxbHomePageModel_DataList;
#import "HxbHomePageViewModel_dataList.h"

@interface HXBHomePageProductCell : UITableViewCell

@property (nonatomic, strong) HxbHomePageModel_DataList *homePageModel_DataList;

/**
 倒计时labeltest
 */
@property (nonatomic, copy) NSString *countDownString;

/**
 cell点击按钮回调的Block
 */
@property (nonatomic, copy) void(^purchaseButtonClickBlock)();
@end

