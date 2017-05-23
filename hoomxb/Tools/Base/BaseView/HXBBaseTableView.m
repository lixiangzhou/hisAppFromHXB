//
//  HXBBaseTableView.m
//  hoomxb
//
//  Created by HXB on 2017/4/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseTableView.h"
@interface HXBBaseTableView ()
@property (nonatomic,copy) void (^clickCellBlock)(NSIndexPath *index, id model);
@end
@implementation HXBBaseTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.tableFooterView = [[UIView alloc]init];
    }
    return self;
}
- (void)clickCellBlockFunc:(void (^)(NSIndexPath *, id))clickCellBlock {
    self.clickCellBlock = clickCellBlock;
}
@end
