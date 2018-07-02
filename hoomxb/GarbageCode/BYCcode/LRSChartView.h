//
//  LRSChartView.h
//  LRSChartView
//
//  Created by lreson on 16/7/21.
//  Copyright © 2016年 lreson. All rights reserved.
//

#import <UIKit/UIKit.h>
#define NS_ENUM(...) CF_ENUM(__VA_ARGS__)


typedef NS_ENUM(NSInteger,LRSChartViewStyle){
    LRSChartViewMoreNoClickLine, //多条折现不可以点击 暂时没做
    LRSChartViewMoreClickLine,  //多条折现可以点击
    LRSChartViewLeftRightLine,  //左右两种不同数据
};

typedef NS_ENUM(NSInteger,LRSChartLayerStyle){
    LRSChartNone,   //没有
    LRSChartGradient, //渐变
    LRSChartProjection,  //投影
};

typedef NS_ENUM(NSInteger,LRSLineLayerStyle){
    LRSLineLayerNone,   //没有
    LRSLineLayerGradient, //渐变
};

@interface LRSChartView : UIView

/** X轴坐标数据 */
@property (nonatomic, strong) NSArray *dataArrOfX;
/** Y轴左边数据 */
@property (nonatomic,strong) NSArray *leftDataArr;
/** Y轴右边数据 没有不用传递 */
@property (nonatomic,strong) NSArray *rightDataArr;
/** X轴标题 */
@property (nonatomic, strong) UILabel *titleOfX;
/** Y轴标题 */
@property (nonatomic, strong) UILabel *titleOfY;
//线条宽度，默认为1
@property (nonatomic, assign) CGFloat lineWidth;
// 计算精度,10,100,1000,默认是1
@property (nonatomic,assign)NSInteger precisionScale;
//折线图样式 默认不可点击
@property (nonatomic,assign)LRSChartViewStyle chartViewStyle;
//气泡是否根据折线位置可以浮动，默认不可以
@property (nonatomic,assign)BOOL isFloating;
//图层样式 默认没有
@property (nonatomic,assign) LRSChartLayerStyle chartLayerStyle;
//左侧标注折线颜色组
@property (nonatomic, strong) NSArray *leftColorStrArr;
//右侧标注折线颜色组
@property (nonatomic, strong) NSArray *rightColorStrArr;
//X轴坐标字体大小
@property (nonatomic, strong) UIFont *x_Font;
//X轴坐标字体颜色
@property (nonatomic, strong) UIColor *x_Color;
//Y轴坐标字体大小
@property (nonatomic, strong) UIFont *y_Font;
//Y轴坐标字体颜色
@property (nonatomic, strong) UIColor *y_Color;
//X轴间隔大小
@property (nonatomic, assign) CGFloat Xmargin;
//折现样式  默认没有
@property (nonatomic, assign) LRSLineLayerStyle lineLayerStyle;
//折现渐变颜色组
@property (nonatomic, strong) NSArray * colors;
//渐变比例 0-1  初始化0.5
@property (nonatomic, assign) CGFloat proportion;
-(void)show;
@end
