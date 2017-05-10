//
//  HXBFinDetail_TableView.m
//  hoomxb
//
//  Created by HXB on 2017/5/8.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFinDetail_TableView.h"


@interface HXBFinDetail_TableView ()
<
UITableViewDelegate,
UITableViewDataSource
>
@end
static NSString *CELLID = @"CELLID";
@implementation HXBFinDetail_TableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self setup];
    }
    return self;
}
///MARK: 设置
- (void) setup {
    self.delegate = self;
    self.dataSource = self;

    [self registerClass:[HXBFinDetail_TableViewCell class] forCellReuseIdentifier:CELLID];
    self.rowHeight = 40;
}


#pragma mark - delegate 
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXBFinDetail_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor hxb_randomColor];
    cell.model = self.tableViewCellModelArray[indexPath.row];
    cell.textLabel.text = @(indexPath.row).description;
    return cell;
}
@end




@interface HXBFinDetail_TableViewCell ()
@property (nonatomic,strong) UILabel *optionLabel;
@property (nonatomic,strong) UIImageView *iconImageView;
@end

@implementation HXBFinDetail_TableViewCell
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
    }
    return self;
}
- (void)setup {
    kWeakSelf
    self.optionLabel = [[UILabel alloc]init];
    self.iconImageView = [[UIImageView alloc]init];
    
    [self.contentView addSubview:self.optionLabel];
    [self.contentView addSubview:self.iconImageView];
    
    [self.optionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.left.equalTo(weakSelf.contentView).offset(20);
    }];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.left.equalTo(weakSelf.contentView).offset(10);
        make.height.width.equalTo(@10);
    }];
}
@end

