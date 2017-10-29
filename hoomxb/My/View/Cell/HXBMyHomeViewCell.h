//
//  HXBMyHomeViewCell.h
//  hoomxb
//
//  Created by HXB-C on 2017/8/7.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBMyHomeViewCell : UITableViewCell

/**
 是否显示底部线条
 */
@property (nonatomic, assign) BOOL isShowLine;

@property (nonatomic, strong) UILabel *descLab;
@end
