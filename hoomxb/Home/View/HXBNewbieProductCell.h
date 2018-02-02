//
//  HXBNewbieProductCell.h
//  hoomxb
//
//  Created by HXB-C on 2018/1/19.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HxbHomePageModel_DataList;
@interface HXBNewbieProductCell : UITableViewCell

@property (nonatomic, strong) HxbHomePageModel_DataList *homePageModel_DataList;

/**
 倒计时labeltest
 */
@property (nonatomic, copy) NSString *countDownString;
@end
