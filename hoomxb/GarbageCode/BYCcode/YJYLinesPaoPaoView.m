//
//  YJYLinesPaoPaoView.m
//  YJYLinesView
//
//  Created by yuhuan on 2018/3/22.
//  Copyright © 2018年 YJY. All rights reserved.
//

#import "YJYLinesPaoPaoView.h"
#import "Masonry.h"
#import "NSString+Extension.h"
#import "UIColor+expanded.h"
#import "LinesSelectCell.h"
@interface YJYLinesPaoPaoView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *listTb;
@property (assign, nonatomic) CGFloat maxTitleWidth;
@property (assign, nonatomic) CGFloat maxTitleWidth1;
/** 遮罩 */
@property (nonatomic, strong) CAShapeLayer *maskLayer;
/** 路径 */
@property (nonatomic, strong) UIBezierPath *borderPath;
@end

@implementation YJYLinesPaoPaoView {
    NSArray *_dataArr;
    NSArray *_colorArr;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _beyondLeft = NO;
        _beyondRight = NO;
        [self setUp];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setUp];
    }
    return self;
}

- (void)setUp {
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    bgImageView.image = [UIImage imageNamed:@"m_home_paopao"];
    bgImageView.backgroundColor = [UIColor clearColor];
    [self addSubview:bgImageView];

    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];

    [self.listTb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.centerX.centerY.equalTo(self);
        make.height.mas_equalTo(14);
    }];
}

- (void)show:(NSArray *)dataArr and:(NSString *)title colorArr:(NSArray *)color {
    self.maxTitleWidth = 0;
    NSMutableArray *titleArray = [NSMutableArray array];
    for (int i = 0; i < dataArr.count; i++) {
        id obj = dataArr[i];
        NSMutableArray * marr = [NSMutableArray array];
        if ([obj isKindOfClass:[NSString class]]) {
            
            NSString *title = [NSString roundUpFloorfNum:[dataArr[i] floatValue] unit:@""];
            CGSize titleSize = CGSizeMake(0, 0);
            titleSize = [NSString getAttributeSizeWithText:title fontSize:12];
            
            self.maxTitleWidth = titleSize.width > self.maxTitleWidth ? titleSize.width : self.maxTitleWidth;
            [marr addObject:title];
        }else if([obj isKindOfClass:[NSArray class]]){
            NSArray * arr = obj;
            for (int o = 0 ; o < arr.count ; o++) {
                NSString * str = [NSString roundUpFloorfNum:[arr[o] floatValue] unit:@""];
                CGSize titleSize = CGSizeMake(0, 0);
                if (o == 0) {
                    
                    titleSize = [NSString getAttributeSizeWithText:str fontSize:12];
                    
                    self.maxTitleWidth = titleSize.width > self.maxTitleWidth ? titleSize.width : self.maxTitleWidth;
                    
                }else{
                    
                    titleSize = [NSString getAttributeSizeWithText:str fontSize:12];
                    
                    self.maxTitleWidth1 = titleSize.width > self.maxTitleWidth ? titleSize.width : self.maxTitleWidth;
                    
                }
                [marr addObject:str];
            }
            
        }
        
        [titleArray addObject:marr];

    }
    
    _dataArr = titleArray;
    _colorArr = color;
    
    if (title && title.length > 0) {
        
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), 22)];
        
        UILabel * lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, CGRectGetWidth(view.frame) - 20, CGRectGetHeight(view.frame))];
        
        lab.font = [UIFont systemFontOfSize:12];
        
        lab.textColor = [UIColor colorWithHexString:@"#d3d3d3"];
        
        lab.text = title;
        
        [view addSubview:lab];
        
        self.listTb.tableHeaderView = view;
        
    }
    __weak typeof(_dataArr) weakDataArr = _dataArr;
    [self.listTb mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo((weakDataArr.count + 1) * 22);
    }];
    self.listTb.rowHeight = 22;
    [self.listTb reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LinesSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LinesSelectCell"];

    if (!cell) {
        cell = [[LinesSelectCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LinesSelectCell"];
        cell.width1 = self.maxTitleWidth;
        cell.width2 = self.maxTitleWidth1;
    }
    
    NSArray * arr = _dataArr[indexPath.row];
    if (arr.count == 1) {
        [cell showTitle:arr[0] andTitleColor:_colorArr[indexPath.row] andTitleFont:[UIFont systemFontOfSize:12] andDescTile:nil andDescTileColor:nil andDescTitleFont:nil];
    }else if (arr.count == 2){
        [cell showTitle:arr[0] andTitleColor:_colorArr[indexPath.row] andTitleFont:[UIFont systemFontOfSize:12] andDescTile:arr[1] andDescTileColor:_colorArr[indexPath.row] andDescTitleFont:[UIFont systemFontOfSize:12]];
    }

    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 22;
}

+(CGSize)getWidthAndHeight:(NSArray *)dataArray{
    CGFloat width = 0;
    CGFloat height = 0;
    if (dataArray.count > 0) height = 22 * (dataArray.count + 1);
    for (int i = 0; i < dataArray.count; i++) {
        id obj = dataArray[i];
        if ([obj isKindOfClass:[NSString class]]) {
            CGSize size = [NSString getAttributeSizeWithText:(NSString *)obj fontSize:12];

            width = size.width < width ? 80 : size.width;
        }else if ([obj isKindOfClass:[NSArray class]]){
            NSArray * arr = obj;
            if (arr.count > 0) width += (arr.count - 1) * 10;
            for (int i = 0; i < arr.count; i++) {
                CGSize size = [NSString getAttributeSizeWithText:arr[i] fontSize:12];
                width = size.width < width ? 80 : size.width;
            }
        }
    }
    
    if (width < 80) width = 80;
    
    width += 20;
    
    return CGSizeMake(width, height);
}

- (UITableView *)listTb {
    if (!_listTb) {
        _listTb = [[UITableView alloc]init];
        _listTb.backgroundColor = [UIColor clearColor];
        _listTb.separatorStyle = UITableViewCellSeparatorStyleNone;
        _listTb.allowsSelection = NO;
        _listTb.dataSource = self;
        _listTb.delegate = self;
        [self addSubview:_listTb];
    }
    return _listTb;
}

#pragma mark ---------画边框并填充颜色-------------
-(void)drawBoxWithDirection:(Direction)direction{
    
    UIView * view = [[UIView alloc] initWithFrame:self.bounds];
    
    view.backgroundColor = self.backgroundColor;
    
    self.backgroundColor = [UIColor clearColor];
    
    [self addSubview:view];
    
    [self bringSubviewToFront:self.listTb];
    // 初始化遮罩
    self.maskLayer = [CAShapeLayer layer];
    // 设置遮罩
    [view.layer setMask:self.maskLayer];
    // 初始化路径
    self.borderPath = [UIBezierPath bezierPath];
    // 遮罩层frame
    self.maskLayer.frame = view.bounds;
    
    CGFloat pathX = 0;
    if (_beyondLeft) {
        pathX = _margin/2;
    }else if (_beyondRight) {
        pathX = self.bounds.size.width - _margin/2;
    }else{
        pathX = self.bounds.size.width/2;
    }
    
    if (direction == directionTop) {
        [self.listTb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
        }];
        // 设置path起点
        [self.borderPath moveToPoint:CGPointMake(5, 5)];
        // 左上角的圆角
        [self.borderPath addQuadCurveToPoint:CGPointMake(10, 0) controlPoint:CGPointMake(5, 0)];
        // 直线，到右上角
        [self.borderPath addLineToPoint:CGPointMake(self.bounds.size.width - 10, 0)];
        // 右上角的圆角
        [self.borderPath addQuadCurveToPoint:CGPointMake(self.bounds.size.width -5, 5) controlPoint:CGPointMake(self.bounds.size.width - 5, 0)];
        // 直线，到右下角
        [self.borderPath addLineToPoint:CGPointMake(self.bounds.size.width - 5, self.bounds.size.height - 10)];
        // 右下角的圆角
        [self.borderPath addQuadCurveToPoint:CGPointMake(self.bounds.size.width - 10, self.bounds.size.height - 5) controlPoint:CGPointMake(self.bounds.size.width - 5, self.bounds.size.height - 5)];
        // 底部的小三角形
        [self.borderPath addLineToPoint:CGPointMake(pathX + 5, self.bounds.size.height - 5)];
        [self.borderPath addLineToPoint:CGPointMake(pathX, self.bounds.size.height)];
        [self.borderPath addLineToPoint:CGPointMake(pathX - 5, self.bounds.size.height - 5)];
        
        // 直线，到左下角
        [self.borderPath addLineToPoint:CGPointMake(10, self.bounds.size.height - 5)];
        // 左下角的圆角
        [self.borderPath addQuadCurveToPoint:CGPointMake(5, self.bounds.size.height - 10) controlPoint:CGPointMake(5, self.bounds.size.height - 5)];
        // 直线，回到起点
        [self.borderPath addLineToPoint:CGPointMake(5, 5)];
    }else{
        [self.listTb mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
        }];
        // 设置path起点
        [self.borderPath moveToPoint:CGPointMake(5, 5)];
        // 左上角的圆角
        [self.borderPath addQuadCurveToPoint:CGPointMake(10, 5) controlPoint:CGPointMake(0, 5)];
        // 顶部的小三角形
        [self.borderPath addLineToPoint:CGPointMake(pathX - 5, 5)];
        [self.borderPath addLineToPoint:CGPointMake(pathX, 0)];
        [self.borderPath addLineToPoint:CGPointMake(pathX + 5, 5)];
        // 直线，到右上角
        [self.borderPath addLineToPoint:CGPointMake(self.bounds.size.width - 10, 5)];
        // 右上角的圆角
        [self.borderPath addQuadCurveToPoint:CGPointMake(self.bounds.size.width - 5, 10) controlPoint:CGPointMake(self.bounds.size.width - 5, 5)];
        // 直线，到右下角
        [self.borderPath addLineToPoint:CGPointMake(self.bounds.size.width - 5, self.bounds.size.height - 5)];
        // 右下角的圆角
        [self.borderPath addQuadCurveToPoint:CGPointMake(self.bounds.size.width - 10, self.bounds.size.height) controlPoint:CGPointMake(self.bounds.size.width - 5, self.bounds.size.height)];
        // 直线，到左下角
        [self.borderPath addLineToPoint:CGPointMake(10, self.bounds.size.height)];
        // 左下角的圆角
        [self.borderPath addQuadCurveToPoint:CGPointMake(5, self.bounds.size.height - 5) controlPoint:CGPointMake(5, self.bounds.size.height)];
        // 直线，回到起点
        [self.borderPath addLineToPoint:CGPointMake(5, 5)];
    }
    // 将这个path赋值给maskLayer的path
    self.maskLayer.path = self.borderPath.CGPath;
    
   
    

}
@end
