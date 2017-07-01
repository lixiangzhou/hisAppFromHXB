//
//  HXBBaseTableView.h
//  hoomxb
//
//  Created by HXB on 2017/4/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBBaseTableView : UITableView
@property (nonatomic,assign) BOOL isOpenRefresh;
/**
 点击了cell
 */
- (void)clickCellWithBlock: (void (^)(id cellModel,NSIndexPath *index))clickCellBlock;
@end
