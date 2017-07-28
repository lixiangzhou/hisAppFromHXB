//
//  HXBMyBankCellTableViewCell.h
//  HongXiaoBao
//
//  Created by 牛严 on 16/7/26.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HXBBankCardModel;
@interface HXBMyBankCell : UITableViewCell

@property (nonatomic, strong) HXBBankCardModel *bankCardModel;

@property (nonatomic, strong) HXBRequestUserInfoViewModel *userInfoViewModel;

@end
