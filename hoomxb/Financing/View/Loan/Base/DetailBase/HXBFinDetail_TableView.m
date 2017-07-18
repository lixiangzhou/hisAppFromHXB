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
@property (nonatomic,copy) void (^clickBottomTabelViewCellBlock)(NSIndexPath *index, HXBFinDetail_TableViewCellModel *model);
@end
static NSString *CELLID = @"CELLID";
@implementation HXBFinDetail_TableView
//MARK: 事件的传递
- (void)clickBottomTableViewCellBloakFunc:(void (^)(NSIndexPath *, HXBFinDetail_TableViewCellModel *))clickBottomTabelViewCellBlock {
    self.clickBottomTabelViewCellBlock = clickBottomTabelViewCellBlock;
}
#define mark - stter
- (void)setTableViewCellModelArray:(NSArray<HXBFinDetail_TableViewCellModel *> *)tableViewCellModelArray {
    _tableViewCellModelArray = tableViewCellModelArray;
    [self reloadData];
}
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        [self setup];
        self.rowHeight = kScrAdaptationH(45);
        self.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HXBFinDetail_TableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    HXBFinDetail_TableViewCellModel *model = cell.model;
    if (self.clickBottomTabelViewCellBlock) {
        self.clickBottomTabelViewCellBlock(indexPath,model);
    }
}
#pragma mark - datesource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HXBFinDetail_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CELLID forIndexPath:indexPath];
    cell.model = self.tableViewCellModelArray[indexPath.row];
    return cell;
}
@end




@interface HXBFinDetail_TableViewCell ()
@property (nonatomic,strong) UILabel *optionLabel;
@property (nonatomic,strong) UIImageView *iconImageView;
@end

@implementation HXBFinDetail_TableViewCell
- (void)setModel:(HXBFinDetail_TableViewCellModel *)model {
    _model = model;
    self.optionLabel.text = model.optionTitle;
    self.iconImageView.image = [UIImage imageNamed:model.imageName];
}
- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.separatorInset = UIEdgeInsetsMake(kScrAdaptationH(1), kScrAdaptationW(15), 0, kScrAdaptationW(15));
        [self setup];
    }
    return self;
}
- (void)setup {
    kWeakSelf
    self.optionLabel = [[UILabel alloc]init];
    self.optionLabel.font = kHXBFont_PINGFANGSC_REGULAR(15);
    self.optionLabel.textColor = kHXBColor_RGB(0.2, 0.2, 0.2, 1);
    self.iconImageView = [[UIImageView alloc]init];
    
    [self.contentView addSubview:self.optionLabel];
    [self.contentView addSubview:self.iconImageView];
    
//    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(weakSelf.contentView);
//        make.left.equalTo(weakSelf.contentView).offset(10);
//        make.height.width.equalTo(@10);
//    }];
    [self.optionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.contentView);
        make.right.equalTo(weakSelf.contentView);
        make.left.equalTo(weakSelf.contentView).offset(kScrAdaptationW(15));
    }];
}
@end


@implementation HXBFinDetail_TableViewCellModel
+ (instancetype)finDetail_TableViewCellModelWithImageName: (NSString *)imageName andOptionIitle: (NSString *)optionTitle {
    return [[self alloc]initWithImageName:imageName andOptionIitle:optionTitle];
}
- (instancetype)initWithImageName: (NSString *)imageName andOptionIitle: (NSString *)optionTitle {
    if (self = [super init]) {
        self.imageName = imageName;
        self.optionTitle = optionTitle;
    }
    return self;
}
@end
