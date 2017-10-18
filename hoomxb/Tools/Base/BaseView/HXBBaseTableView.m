//
//  HXBBaseTableView.m
//  hoomxb
//
//  Created by HXB on 2017/4/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseTableView.h"
@interface HXBBaseTableView ()
@property (nonatomic,copy) void (^clickCellBlock)(NSIndexPath *index, id model);
@end

//static NSString *const BaseTableViewCellID = @"BaseTableViewCellID";
@implementation HXBBaseTableView
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.tableFooterView = [[UIView alloc]init];
//        self.delegate = self;
//        self.dataSource = self;
//    self registerClass:[] forCellReuseIdentifier:<#(nonnull NSString *)#>
    }
    return self;
}
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//}
@end
