//
//  BYCTestCode.m
//  hoomxb
//
//  Created by hxb on 2018/7/2.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "BYCTestCode.h"
#import "LRSChartView.h"
#import "UIColor+expanded.h"

@interface BYCTestCode ()
@property (nonatomic, strong) LRSChartView *incomeChartLineView;
@end

@implementation BYCTestCode

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

/**创建“收益走势”图*/
-(void)createIncomeChartLineView{
    
    //    NSArray *tempDataArrOfY = @[@[@"400",@"600",@"500",@"800",@"600",@"700",@"500"]];
    //    NSArray *tempDataArrOfY1 = @[@[@"30",@"50",@"30",@"90",@"40",@"50",@"40"]];
    //
    //    _incomeChartLineView = [[LRSChartView alloc]initWithFrame:CGRectMake(0, 40, self.view.bounds.size.width, 300)];
    //    //设置X轴坐标字体大小
    //    _incomeChartLineView.x_Font = [UIFont systemFontOfSize:10];
    //    //设置X轴坐标字体颜色
    //    _incomeChartLineView.x_Color = [UIColor colorWithHexString:@"0x999999"];
    //    //设置Y轴坐标字体大小
    //    _incomeChartLineView.y_Font = [UIFont systemFontOfSize:10];
    //    //设置Y轴坐标字体颜色
    //    _incomeChartLineView.y_Color = [UIColor colorWithHexString:@"0x999999"];
    //    //设置X轴数据间隔
    //    _incomeChartLineView.Xmargin = 50;
    //
    //    _incomeChartLineView.backgroundColor = [UIColor clearColor];
    //    _incomeChartLineView.chartViewStyle = LRSChartViewLeftRightLine;
    //    _incomeChartLineView.x_Font = [UIFont systemFontOfSize:10];
    //    _incomeChartLineView.x_Color = [UIColor colorWithHexString:@"0x999999"];
    //    _incomeChartLineView.isFloating = YES;
    //    //折线图数据
    //    _incomeChartLineView.leftDataArr = tempDataArrOfY;
    //    _incomeChartLineView.rightDataArr = tempDataArrOfY1;
    //    //设置图层效果
    //    _incomeChartLineView.chartLayerStyle = LRSChartProjection;
    //
    //    _incomeChartLineView.leftColorStrArr = @[@"#febf83"];
    //    _incomeChartLineView.rightColorStrArr = @[@"#53d2f8"];
    //
    //    //底部日期
    //    _incomeChartLineView.dataArrOfX = @[@"01-13",@"01-14",@"01-15",@"01-16",@"01-17",@"01-18",@"01-19"];//拿到X轴坐标
    //
    //    [_incomeChartLineView show];
    //    [self.view addSubview:_incomeChartLineView];
    
    NSArray *tempDataArrOfY = @[@[@"400",@"600",@"500",@"800",@"600",@"700",@"500",@"500",@"500",@"500"],@[@"300",@"500",@"400",@"700",@"500",@"600",@"400",@"400",@"400",@"400"],@[@"200",@"400",@"300",@"600",@"400",@"500",@"300",@"300",@"300",@"300"]];
    
    _incomeChartLineView = [[LRSChartView alloc]initWithFrame:CGRectMake(0, 40, self.view.bounds.size.width, 300)];
    
    
    //是否可以浮动
    _incomeChartLineView.isFloating = YES;
    //设置X轴坐标字体大小
    _incomeChartLineView.x_Font = [UIFont systemFontOfSize:10];
    //设置X轴坐标字体颜色
    _incomeChartLineView.x_Color = [UIColor colorWithHexString:@"0x999999"];
    //设置Y轴坐标字体大小
    _incomeChartLineView.y_Font = [UIFont systemFontOfSize:10];
    //设置Y轴坐标字体颜色
    _incomeChartLineView.y_Color = [UIColor colorWithHexString:@"0x999999"];
    //设置X轴数据间隔
    _incomeChartLineView.Xmargin = 50;
    //设置背景颜色
    _incomeChartLineView.backgroundColor = [UIColor clearColor];
    //是否根据折线数据浮动泡泡
    //_incomeChartLineView.isFloating = YES;
    //折线图数据
    _incomeChartLineView.leftDataArr = tempDataArrOfY;
    //折线图所有颜色
    _incomeChartLineView.leftColorStrArr = @[@"#febf83",@"#53d2f8",@"#7211df"];
    //设置折线样式
    _incomeChartLineView.chartViewStyle = LRSChartViewMoreClickLine;
    //设置图层效果
    _incomeChartLineView.chartLayerStyle = LRSChartProjection;
    //设置折现效果
    _incomeChartLineView.lineLayerStyle = LRSLineLayerNone;
    //渐变效果的颜色组
    _incomeChartLineView.colors = @[@[[UIColor colorWithHexString:@"#febf83"],[UIColor greenColor]],@[[UIColor colorWithHexString:@"#53d2f8"],[UIColor blueColor]],@[[UIColor colorWithHexString:@"#7211df"],[UIColor redColor]]];
    //渐变开始比例
    _incomeChartLineView.proportion = 0.5;
    //底部日期
    _incomeChartLineView.dataArrOfX = @[@"01-13",@"01-14",@"01-15",@"01-16",@"01-17",@"01-18",@"01-19",@"01-20",@"01-21",@"01-22"];
    //开始画图
//    [_incomeChartLineView show];
//    [self.view addSubview:_incomeChartLineView];
}

@end
