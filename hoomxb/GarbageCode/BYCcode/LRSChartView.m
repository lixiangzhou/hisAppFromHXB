//
//  LRSChartView.m
//  LRSChartView
//
//  Created by lreson on 16/7/21.
//  Copyright © 2016年 lreson. All rights reserved.
//

#import "LRSChartView.h"
#import "UIImage+Common.h"
#import "UIButton+EnlargeTouchArea.h"
#import "UIView+Common.h"
#import "YJYTouchCollectionView.h"
#import "YJYTouchScroll.h"
#import "YJYLinesCell.h"
#import "YJYLinesPaoPaoView.h"
#import "UIColor+Expanded.h"

#define btnW 12
#define titleWOfY 35
#define kPaoPaoWidth 75.f
#define KCircleRadius 5 //线条上圆圈半径
@interface LRSChartView ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    CGFloat currentPage;//当前页数
    //CGFloat Xmargin;//X轴方向的偏移
    CGFloat Ymargin;//Y轴方向的偏移
    CGPoint lastPoint;//最后一个坐标点
    UIButton *firstBtn;
    UIButton *lastBtn;
}

@property (nonatomic,strong)YJYTouchScroll *chartScrollView;
@property (nonatomic,strong)YJYTouchCollectionView * xAxiCollectionView;
@property (nonatomic,strong)UIPageControl *pageControl;//分页
@property (nonatomic,strong)NSMutableArray *leftPointArr;//左边的数据源
@property (nonatomic,strong)NSMutableArray *rightPointArr;//左边的数据源
@property (nonatomic,strong)NSMutableArray *leftBtnArr;//左边按钮
@property (nonatomic, strong)NSMutableArray *detailLabelArr;
@property (nonatomic,strong)NSArray *leftScaleArr;
@property (nonatomic,strong)NSArray *rightScaleArr;
@property (nonatomic,strong)NSMutableArray *leftScaleViewArr;//左边的点击显示图
@property (nonatomic,strong)UIView *scaleBgView;
@property (nonatomic,strong)UILabel *lineLabel;
@property (nonatomic,strong)UILabel *scaleLabel;
@property (nonatomic,strong)UILabel *dateTimeLabel;
@property (nonatomic,assign)NSInteger row;
@property (nonatomic,assign)CGFloat leftJiange;
@property (nonatomic,assign)CGFloat jiange;
@property (nonatomic,assign)CGFloat rightJiange;
@property (nonatomic,assign)BOOL showSelect;
@property (nonatomic,assign) NSInteger selectIndex;
@property (nonatomic,strong)UIView *selectView;
@property (nonatomic,strong)YJYLinesPaoPaoView * paopaoView;
@property (nonatomic,strong)NSMutableArray *charCircleViewArr;
@property (strong,nonatomic) UIBezierPath *circlePath;
@property (strong,nonatomic) CAGradientLayer *gradientlayer;
@property (strong,nonatomic) CAShapeLayer *percentLayer;

@end

@implementation LRSChartView


#pragma mark --------初始化-----------
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        currentPage = 0;
        _precisionScale = 1;
        self.leftPointArr = [NSMutableArray array];
        self.rightPointArr = [NSMutableArray array];
        self.leftBtnArr = [NSMutableArray array];
        self.detailLabelArr = [NSMutableArray array];
        self.leftScaleArr = [NSArray array];
        self.leftScaleViewArr = [NSMutableArray array];
        self.showSelect = NO;
        self.isFloating = NO;
        self.chartViewStyle = 0;
        self.chartLayerStyle = 0;
        self.lineLayerStyle = 0;
        self.proportion = 0.5;
        self.colors = [NSArray array];
        self.lineWidth = 1;
        _Xmargin = 50;
        _row = 2;
    }
    
    return self;
    
}

-(UILabel *)scaleLabel{
    if (!_scaleLabel) {
        _scaleLabel = [[UILabel alloc]init];
        _scaleLabel.textAlignment = 1;
        _scaleLabel.text = @"3.3681%";
        _scaleLabel.font = [UIFont systemFontOfSize:11];
        _scaleLabel.backgroundColor = [UIColor colorWithRed:255/255.0 green:159/255.0 blue:106/255.0 alpha:1];
        _scaleLabel.textColor = [UIColor whiteColor];
    }
    return _scaleLabel;
    
}

-(UILabel *)dateTimeLabel{
    if (!_dateTimeLabel) {
        _dateTimeLabel = [[UILabel alloc]init];
        _dateTimeLabel.textAlignment = 1;
        _dateTimeLabel.text = @"2016.04.16";
        _dateTimeLabel.font = [UIFont systemFontOfSize:11];
        _dateTimeLabel.backgroundColor = [UIColor whiteColor];
        _dateTimeLabel.textColor = [UIColor colorWithRed:181/255.0 green:181/255.0 blue:181/255.0 alpha:1];
    }
    return _dateTimeLabel;
}

-(NSMutableArray *)charCircleViewArr{
    if (!_charCircleViewArr) {
        _charCircleViewArr = [NSMutableArray new];
    }
    return _charCircleViewArr;
}

-(YJYTouchCollectionView *)xAxiCollectionView{
    if (!_xAxiCollectionView) {
        UICollectionViewFlowLayout *collectionViewLayout = [[UICollectionViewFlowLayout alloc]init];
        collectionViewLayout.minimumInteritemSpacing = 0;
        collectionViewLayout.minimumLineSpacing = 0;
        collectionViewLayout.sectionInset = UIEdgeInsetsMake(0, 4, 0, 0);
        collectionViewLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _xAxiCollectionView = [[YJYTouchCollectionView alloc]initWithFrame:CGRectMake(CGRectGetMinX(_chartScrollView.frame), CGRectGetMaxY(_chartScrollView.frame) + 10, CGRectGetWidth(_chartScrollView.frame), 20) collectionViewLayout:collectionViewLayout];
        _xAxiCollectionView.backgroundColor = [UIColor whiteColor];
        [_xAxiCollectionView registerNib:[UINib nibWithNibName:@"YJYLinesCell" bundle:nil] forCellWithReuseIdentifier:@"YJYLinesCell"];
        _xAxiCollectionView.delegate = self;
        _xAxiCollectionView.dataSource = self;
        _xAxiCollectionView.showsHorizontalScrollIndicator = NO;
        _xAxiCollectionView.userInteractionEnabled = YES;
        [self addSubview:_xAxiCollectionView];
    }
    return _xAxiCollectionView;
}

- (UIView *)selectView {
    if (!_selectView) {
        _selectView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, self.chartScrollView.frame.size.height)];
        _selectView.backgroundColor = [UIColor colorWithHexString:@"#dddddd"];
        [self.chartScrollView addSubview:_selectView];
    }
    return _selectView;
}

-(YJYLinesPaoPaoView *)paopaoView{
    if (!_paopaoView) {
        _paopaoView = [[YJYLinesPaoPaoView alloc] initWithFrame:CGRectZero];
        self.paopaoView.backgroundColor = [UIColor whiteColor];
        self.paopaoView.layer.shadowColor = [UIColor blackColor].CGColor;
        self.paopaoView.layer.shadowOffset = CGSizeMake(0, 3);
        self.paopaoView.layer.shadowOpacity = 0.5;
        [self.chartScrollView addSubview:_paopaoView];
    }
    return _paopaoView;
}

-(UILabel *)lineLabel{
    
    if (!_lineLabel) {
        _lineLabel = [[UILabel alloc]init];
        _lineLabel.backgroundColor = [UIColor colorWithRed:255/255.0 green:159/255.0 blue:106/255.0 alpha:1];
    }
    return _lineLabel;
}

#pragma -mark -------------scrollViewDelegate----------------
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == _chartScrollView) {
        _xAxiCollectionView.contentOffset = scrollView.contentOffset;
    }else{
        _chartScrollView.contentOffset = scrollView.contentOffset;
    }
}
#pragma -mark --------------collViewDelegate----------------
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArrOfX.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    YJYLinesCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YJYLinesCell" forIndexPath:indexPath];
    cell.titleLB.font = self.x_Font;
    cell.titleLB.textColor = self.x_Color;
    cell.titleLB.text = self.dataArrOfX[indexPath.row];
    cell.titleLB.textAlignment=NSTextAlignmentCenter;
    return cell;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(_Xmargin, 20);
}

-(void)setLeftDataArr:(NSArray *)leftDataArr{
    _leftDataArr = leftDataArr;
}

-(void)setRightDataArr:(NSArray *)rightDataArr{
    _rightDataArr = rightDataArr;
    self.pageControl.numberOfPages = 1;
    _rightJiange = 0;
    
}


// 获取数据最大值,并计算每一行间隔值
- (CGFloat)spaceValue:(NSArray *)array{
    CGFloat minValue = MAXFLOAT;
    CGFloat maxValue = -MAXFLOAT;
    for (int i = 0; i < [array count]; i++) {
        if ([array[i] floatValue] * _precisionScale> maxValue) {
            maxValue = [array[i] floatValue] * _precisionScale;
        }
        if ([array[i] floatValue] * _precisionScale < minValue) {
            minValue = [array[i] floatValue] * _precisionScale;
        }
    }
    int max = (int)[self getNumber:maxValue];
    NSInteger tenValue = 0;
    while (max / 10) {max = max / 10;tenValue++;}
    CGFloat space_Value = ((max + 1) * pow(10, tenValue)) / _row;
    return space_Value / _precisionScale;
}

// 只取小数点之前的数字
- (CGFloat)getNumber:(CGFloat)value{
    NSString *string = [NSString stringWithFormat:@"%f",value];
    if (![[NSMutableString stringWithString:string] containsString:@"."]) {
        return value;
    }
    return [[[string componentsSeparatedByString:@"."] firstObject] floatValue];
}


#pragma mark ----------显示---------------
-(void)show{
    [self addDetailViews];
    [self.xAxiCollectionView reloadData];
    [self addLines1With:self.chartScrollView];
    
    if (self.dataArrOfX.count > 0) {
        self.chartScrollView.contentSize = CGSizeMake(_Xmargin*self.dataArrOfX.count, 0);
    }
    
    switch (_chartViewStyle) {
        case 0:
            [self showLeftRightView];
            break;
        case 1:
            [self showLeftRightView];
            break;
        case 2:
            [self showLeftRightView];
            break;
            
        default:
            break;
    }
    
    

}
//显示左右两种标线
-(void)showLeftRightView{

    if (_leftDataArr.count > 0) {
        
        for (int i = 0; i < _leftDataArr.count; i++) {
            CGFloat jiange1 = [self spaceValue:_leftDataArr[i]];
            if (jiange1 > _leftJiange) {
                _leftJiange = jiange1;
            }
        }

        NSMutableArray * marr = [NSMutableArray array];
        for (int i = 0; i < _leftDataArr.count; i++) {
            NSArray * arr = _leftDataArr[i];
            [marr addObject:[self addDataPointWith:self.chartScrollView andArr:arr andInterval:_leftJiange]];//添加点
        }
        ;//添加点
        [self.leftPointArr addObjectsFromArray:marr];
        for (int i = 0; i<marr.count; i++) {
            NSArray * arr = [NSArray array];
            if (i < _colors.count) {
                arr = _colors[i];
            }
            [self addBezierPoint:marr[i] andColorStr:_leftColorStrArr[i] andColors:arr];
        }
        ////添加连线
        [self addLeftViews];
    }
    
    if (_rightDataArr.count > 0) {
        
        for (int i = 0; i < _rightDataArr.count; i++) {
            CGFloat jiange1 = [self spaceValue:_rightDataArr[i]];
            if (jiange1 > _rightJiange) {
                _rightJiange = jiange1;
            }
        }
        
        NSMutableArray * marr = [NSMutableArray array];
        for (int i = 0; i < _rightDataArr.count; i++) {
            NSArray * arr = _rightDataArr[i];
            [marr addObject:[self addDataPointWith:self.chartScrollView andArr:arr andInterval:_rightJiange]];//添加点
        }
        [self.leftPointArr addObjectsFromArray:marr];
        for (int i = 0; i<marr.count; i++) {
            NSArray * arr = [NSArray array];
            if (i < _colors.count) {
                arr = _colors[i];
            }
            [self addBezierPoint:marr[i] andColorStr:_rightColorStrArr[i] andColors:arr];
        }
        ////添加连线
        [self addRightViews];
    }
    
    if (self.leftPointArr.count > 0) {
        for (int i = 0; i < self.leftPointArr.count; i++) {
            NSMutableArray * marr = [NSMutableArray arrayWithArray:self.leftPointArr[i]];
            if (marr.count > 2) {
                [marr removeObjectAtIndex:0];
                [marr removeObjectAtIndex:marr.count - 1];
            }
            
            self.leftPointArr[i] = marr;
        }
    }
    
    
    [self addBottomViewsWith:self.chartScrollView];
}


#pragma mark *******************数据源************************

-(void)setDataArrOfX:(NSArray *)dataArrOfX{
    
    _dataArrOfX = dataArrOfX;
}



#pragma mark *******************分割线************************
-(void)addDetailViews{
    self.chartScrollView = [[YJYTouchScroll alloc]initWithFrame:CGRectMake(titleWOfY, 0, self.bounds.size.width-titleWOfY * 2, self.bounds.size.height - 40)];
    self.chartScrollView.backgroundColor = [UIColor clearColor];
    self.chartScrollView.delegate = self;
    self.chartScrollView.showsHorizontalScrollIndicator = NO;
    self.chartScrollView.userInteractionEnabled = YES;
    [self addSubview:self.chartScrollView];
    [self addSubview:self.xAxiCollectionView];

}


#pragma mark 渐变线条
-(void)buildBGCircleLayer:(NSArray *)colors
{
    CAShapeLayer *bgCircleLayer = [CAShapeLayer layer];
    bgCircleLayer.path = _circlePath.CGPath;
    bgCircleLayer.strokeColor = [UIColor lightGrayColor].CGColor;
    bgCircleLayer.fillColor = [UIColor clearColor].CGColor;
    bgCircleLayer.lineWidth = _lineWidth;
    bgCircleLayer.lineCap = kCALineCapRound; // 截面形状
    //[self.layer setMask:bgCircleLayer];
    //    [self.layer addSublayer:_bgCircleLayer];
    
    [self addShowPercentLayer:colors];
    [self percentAnimation];
    
}

-(void)addShowPercentLayer:(NSArray *)colors
{
    _gradientlayer = (id)[CAGradientLayer layer];
    if (colors && colors.count > 0) {
        NSMutableArray * marr = [NSMutableArray array];
        for (int i = 0; i < colors.count; i++) {
            UIColor * color = colors[i];
            [marr addObject:(id)color.CGColor];
        }
        _gradientlayer.colors = marr;
    }else{
        _gradientlayer.colors = [NSArray arrayWithObjects:(id)[[UIColor redColor]CGColor],(id)[[UIColor blueColor]CGColor], nil];
    }
    
    _gradientlayer.startPoint= CGPointMake(0.10, 1);
    _gradientlayer.endPoint = CGPointMake(0.90, 1);
    _gradientlayer.locations = @[[NSNumber numberWithFloat:_proportion]];
    NSLog(@"%f-----------%f",self.chartScrollView.contentSize.width,self.chartScrollView.contentSize.height);
    _gradientlayer.frame = CGRectMake(0, 0, self.chartScrollView.contentSize.width, CGRectGetHeight(self.chartScrollView.frame));
    
    _percentLayer = [CAShapeLayer layer];
    _percentLayer.path = _circlePath.CGPath;
    _percentLayer.strokeColor = [UIColor redColor].CGColor;
    _percentLayer.fillColor = [UIColor clearColor].CGColor;
    _percentLayer.lineWidth = _lineWidth;
    _percentLayer.strokeStart = 0;
    _percentLayer.strokeEnd = 1;
    _percentLayer.lineCap = kCALineCapRound;
    
    if (_chartLayerStyle == 2) {
        _percentLayer.shadowColor = [UIColor redColor].CGColor;
        _percentLayer.shadowOffset = CGSizeMake(0,5);
        _percentLayer.shadowOpacity = 0.5;
    }
   
    
    [_gradientlayer setMask:_percentLayer];
    [self.chartScrollView.layer addSublayer:_gradientlayer];
    
}
-(void)percentAnimation
{
    CABasicAnimation *anmi = [CABasicAnimation animation];
    anmi.keyPath = @"strokeEnd";
    anmi.fromValue = [NSNumber numberWithFloat:0];
    anmi.toValue = [NSNumber numberWithFloat:1.0f];
    anmi.duration =2.0f;
    anmi.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anmi.autoreverses = NO;
    [_percentLayer addAnimation:anmi forKey:@"stroke"];
}
//等动画结束之后的操作
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSLog(@"动画结束时机");
    
}
#pragma mark ----------绘画折现----------------
-(void)addBezierPoint:(NSArray *)pointArray andColorStr:(NSString *)colorStr andColors:(NSArray *)colors{

    //取得起始点
    CGPoint p1 = [[pointArray objectAtIndex:0] CGPointValue];
    CGPoint p2 = [[pointArray objectAtIndex:0] CGPointValue];
    p2.y = p2.y + 5 < CGRectGetHeight(self.chartScrollView.frame) ? p2.y + 5 : CGRectGetHeight(self.chartScrollView.frame);

    //直线的连线
    UIBezierPath *beizer = [UIBezierPath bezierPath];
    [beizer moveToPoint:p1];
    _circlePath = beizer;

    //直线的连线
    UIBezierPath *beizer2 = [UIBezierPath bezierPath];
    [beizer2 moveToPoint:p1];
    [beizer2 addLineToPoint:CGPointMake(100, 10)];

    //遮罩层的形状
    UIBezierPath *bezier1 = [UIBezierPath bezierPath];
    bezier1.lineCapStyle = kCGLineCapRound;
    bezier1.lineJoinStyle = kCGLineJoinMiter;
    [bezier1 moveToPoint:p1];


    for (int i = 0;i<pointArray.count;i++ ) {
        if (i != 0) {

            CGPoint prePoint = [[pointArray objectAtIndex:i-1] CGPointValue];
            CGPoint nowPoint = [[pointArray objectAtIndex:i] CGPointValue];
            //            [beizer addLineToPoint:point];
            [beizer addCurveToPoint:nowPoint controlPoint1:CGPointMake((nowPoint.x+prePoint.x)/2, prePoint.y) controlPoint2:CGPointMake((nowPoint.x+prePoint.x)/2, nowPoint.y)];


            if (_chartLayerStyle == LRSChartGradient) [bezier1 addCurveToPoint:nowPoint controlPoint1:CGPointMake((nowPoint.x+prePoint.x)/2, prePoint.y) controlPoint2:CGPointMake((nowPoint.x+prePoint.x)/2, nowPoint.y)];

            if (i == pointArray.count-1) {
                [beizer moveToPoint:nowPoint];//添加连线
                lastPoint = nowPoint;
            }

        }
    }


    CGFloat bgViewHeight = self.chartScrollView.bounds.size.height;

    //获取最后一个点的X值
    CGFloat lastPointX = lastPoint.x;

    //最后一个点对应的X轴的值

    CGPoint lastPointX1 = CGPointMake(lastPointX, bgViewHeight);

    [bezier1 addLineToPoint:lastPointX1];

    //回到原点

    [bezier1 addLineToPoint:CGPointMake(p1.x, bgViewHeight)];

    [bezier1 addLineToPoint:p1];
    
    if (_lineLayerStyle == 1) {
        
        if (_chartLayerStyle == 1) {
            [self addGradientWithBezierPath:bezier1 andColorStr:colorStr];
        }
        
        [self buildBGCircleLayer:colors];
        return;
    }

//    //*****************添加动画连线******************//
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = beizer.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeColor = [UIColor colorWithHexString:colorStr andAlpha:1.0].CGColor;
    shapeLayer.lineWidth = 3;


    switch (_chartLayerStyle) {
        case 0:
            break;
        case 1:
            [self addGradientWithBezierPath:bezier1 andColorStr:colorStr];
            break;
        case 2:
#pragma mark ------------阴影投影---------------
            shapeLayer.shadowOffset = CGSizeMake(0, 10);
            shapeLayer.shadowColor = [UIColor colorWithHexString:colorStr andAlpha:1.0].CGColor;
            shapeLayer.shadowOpacity = 0.5;
            break;
        default:
            break;
    }

    [self.chartScrollView.layer addSublayer:shapeLayer];

    CABasicAnimation *anmi = [CABasicAnimation animation];
    anmi.keyPath = @"strokeEnd";
    anmi.fromValue = [NSNumber numberWithFloat:0];
    anmi.toValue = [NSNumber numberWithFloat:1.0f];
    anmi.duration =2.0f;
    anmi.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anmi.autoreverses = NO;
    [shapeLayer addAnimation:anmi forKey:@"stroke"];





}
#pragma mark    ------------渐变图层---------------
-(void)addGradientWithBezierPath:(UIBezierPath *)beizer andColorStr:(NSString *)colorStr{
    //遮罩层
    CAShapeLayer *shadeLayer = [CAShapeLayer layer];
    shadeLayer.path = beizer.CGPath;
    shadeLayer.fillColor = [UIColor greenColor].CGColor;
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = CGRectMake(0, 0, 0, self.chartScrollView.bounds.size.height);
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(0, 1);
    gradientLayer.cornerRadius = 5;
    gradientLayer.masksToBounds = YES;
    gradientLayer.colors = @[(__bridge id)[UIColor colorWithHexString:colorStr andAlpha:0.05].CGColor,(__bridge id)[UIColor colorWithHexString:colorStr andAlpha:0].CGColor];
    gradientLayer.locations = @[@(0.5f)];

    CALayer *baseLayer = [CALayer layer];
    [baseLayer addSublayer:gradientLayer];
    [baseLayer setMask:shadeLayer];
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 40, self.chartScrollView.bounds.size.width-5, self.chartScrollView.bounds.size.height)];
    [self.chartScrollView addSubview:view];
    [self.chartScrollView.layer addSublayer:baseLayer];


    CABasicAnimation *anmi1 = [CABasicAnimation animation];
    anmi1.keyPath = @"bounds";
    anmi1.duration = 2.f;
    anmi1.toValue = [NSValue valueWithCGRect:CGRectMake(5, 0, 2*lastPoint.x, self.chartScrollView.bounds.size.height-60)];
    anmi1.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    anmi1.fillMode = kCAFillModeForwards;
    anmi1.autoreverses = NO;
    anmi1.removedOnCompletion = NO;

    [gradientLayer addAnimation:anmi1 forKey:@"bounds"];
}
#pragma mark ----------获取所有坐标点-------------
-(NSMutableArray *)addDataPointWith:(UIView *)view andArr:(NSArray *)DataArr andInterval:(CGFloat)interval{
    
    //self.leftScaleArr = leftData;
    
    CGFloat height = self.chartScrollView.bounds.size.height;
    
    //初始点
    NSMutableArray *arr = [NSMutableArray arrayWithArray:DataArr];

    NSMutableArray * marr = [NSMutableArray array];
    for (int i = 0; i<arr.count; i++) {
        
       
        
        float tempHeight = [arr[i] floatValue] / (interval * 2) ;

        NSLog(@"%f",tempHeight);
        NSValue *point = [NSValue valueWithCGPoint:CGPointMake(((_Xmargin)*i + _Xmargin / 2) , (height *(1 - tempHeight)))];
        
        if (i == 0) {
            NSValue *point1 = [NSValue valueWithCGPoint:CGPointMake(0 , (height *(1 - tempHeight)))];
            
            [marr addObject:point1];
        }
        [marr addObject:point];
        
        if (i + 1 == arr.count) {
            NSValue *point1 = [NSValue valueWithCGPoint:CGPointMake((_Xmargin)* (i + 1) , (height *(1 - tempHeight)))];
            
            [marr addObject:point1];
        }
        
    }
    
    
    
    return marr;
    
}
#pragma mark ---------添加左侧Y轴标注--------------
-(void)addLeftViews{
    
    for (NSInteger i = 0;i<= _row ;i++ ) {
        UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(_chartScrollView.frame) - i * Ymargin - 10, titleWOfY - 5, 20)];
        leftLabel.font = _y_Font;
        leftLabel.textColor = _y_Color;
        leftLabel.textAlignment = NSTextAlignmentRight;
        switch (_chartViewStyle) {
            case 0:
                leftLabel.text = [NSString stringWithFormat:@"%.0f",_jiange * i];
                break;
                
            case 1:
                leftLabel.text = [NSString stringWithFormat:@"%.0f",_jiange * i];
                break;
                
            case 2:
                leftLabel.text = [NSString stringWithFormat:@"%.0f",_leftJiange * i];
                break;
                
            default:
                break;
        }
        
        [self addSubview:leftLabel];
        
    }

}
#pragma mark ---------添加右侧Y轴标注--------------
-(void)addRightViews{
    
    for (NSInteger i = 0;i<= _row ;i++ ) {
        UILabel *leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame) - titleWOfY + 5, CGRectGetHeight(_chartScrollView.frame) - i * Ymargin - 10, titleWOfY - 5, 20)];
        leftLabel.font = [UIFont systemFontOfSize:10.0f];
        leftLabel.textColor = [UIColor colorWithHexString:@"0x999999"];
        leftLabel.textAlignment = NSTextAlignmentLeft;
        leftLabel.text = [NSString stringWithFormat:@"%.0f",_rightJiange * i];
        [self addSubview:leftLabel];
        
    }
    
    
}


-(void)addBottomViewsWith:(UIView *)View{
    
    NSArray *bottomArr;
    
    if (View == self.chartScrollView) {
        bottomArr = _dataArrOfX;
        
    }else{
        
    }
}



-(void)TopBtnAction:(UIButton *)sender{
    
    for (UIButton*btn in _leftBtnArr) {
        if (sender.tag == btn.tag) {
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
    }
    [self showDetailLabel:sender];
    
}

-(void)showDetailLabel:(UIButton *)sender{
    
    for (UILabel * label in _detailLabelArr) {
        if (sender.tag+200 == label.tag) {
            label.hidden = NO;
        }else{
            label.hidden = YES;
        }
    }
    
}

#define mark - 点击屏幕事件
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if (_chartViewStyle == 0) return;
    UITouch *touch=[touches anyObject];
    
    if (touch.view == self.chartScrollView || touch.view.superview == self.chartScrollView) {
        
        [self.paopaoView removeFromSuperview];
        self.paopaoView = nil;
        CGPoint point = [touch locationInView:self.chartScrollView];
        float indexF = (point.x-_Xmargin / 2) / _Xmargin;
        
        NSInteger index = (point.x-_Xmargin / 2) / _Xmargin;
        float disparity = indexF - index;
        if (disparity>0.5) {
            index = index+1;
        }
        [self drawOtherLin:index AndPoint:point];
        return;
    }
    
    UIView *parentView = [touch.view superview];
    while (![parentView isKindOfClass:[UICollectionViewCell class]] && parentView!=nil) {
        parentView = parentView.superview;
    }
    if ([parentView isKindOfClass:[UICollectionViewCell class]]) {
        CGPoint point = [touch locationInView:self.xAxiCollectionView];
        float indexF = (point.x-_Xmargin / 2) / _Xmargin;
        
        NSInteger index = (point.x-_Xmargin / 2) / _Xmargin;
        float disparity = indexF - index;
        if (disparity>0.5) {
            index = index+1;
        }
        [self drawOtherLin:index AndPoint:point];
        return;
    }
}

//点击之后画出重点线以及数值
-(void)drawOtherLin:(NSInteger)index AndPoint:(CGPoint)touchpoint{
    if(index > self.dataArrOfX.count-1 || index<0 || self.dataArrOfX.count == 0){
        return ;
    }
    if (self.showSelect && self.selectIndex== index) {
        self.selectView.hidden = YES;
        self.paopaoView.hidden = YES;
        for (UIView *view in self.charCircleViewArr) {
            [view removeFromSuperview];
        }
        self.showSelect = NO;
        return;
    }
    self.showSelect = YES;
    self.selectIndex = index;
    [self setPaopaoUI:index];
    
}

-(void)setPaopaoUI:(NSInteger)index{

    [self.chartScrollView bringSubviewToFront:self.selectView];
    self.selectView.hidden = NO;
    self.selectView.frame = CGRectMake(_Xmargin*index+_Xmargin / 2, 0, self.selectView.frame.size.width, self.selectView.frame.size.height);
    
    
    
    [self.chartScrollView bringSubviewToFront:self.paopaoView];
    self.paopaoView.hidden = NO;
    
    [self.chartScrollView bringSubviewToFront:self.selectView];
    
    NSMutableArray *dataArr = [NSMutableArray new];
    if (_chartViewStyle == LRSChartViewLeftRightLine) {
        [self.leftDataArr enumerateObjectsUsingBlock:^(NSArray<NSArray *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (index < obj.count) {
                [dataArr addObject:obj[index]];
            }
        }];
        
        [self.rightDataArr enumerateObjectsUsingBlock:^(NSArray<NSArray *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (index < obj.count) {
                [dataArr addObject:obj[index]];
            }
        }];
    }else{
        [self.leftDataArr enumerateObjectsUsingBlock:^(NSArray<NSArray *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (index < obj.count) {
                [dataArr addObject:obj[index]];
            }
        }];
    }
    
    

    
    NSMutableArray *colorArr = [NSMutableArray array];
    
    
    
    for (int i = 0; i < self.leftColorStrArr.count; i++) {
        [colorArr addObject:[UIColor colorWithHexString:self.leftColorStrArr[i]]];
    }
    
    for (int i = 0; i < self.rightColorStrArr.count ; i++) {
         [colorArr addObject:[UIColor colorWithHexString:self.rightColorStrArr[i]]];
    }
    
    CGSize size = [YJYLinesPaoPaoView getWidthAndHeight:dataArr];
    
    float paopao_x = index * _Xmargin + _Xmargin / 2 - size.width * 0.5;
    NSLog(@"%f",self.chartScrollView.contentSize.width);
    if (paopao_x < 0) {
        paopao_x = 0;
    }else if (paopao_x > self.chartScrollView.contentSize.width - size.width) {
        paopao_x = self.chartScrollView.contentSize.width - size.width;
    }
   
    self.paopaoView.frame = CGRectMake(paopao_x, self.paopaoView.frame.origin.y, size.width, size.height + 5);
    self.paopaoView.margin = _Xmargin;
    
    if (paopao_x == 0 && size.width > _Xmargin) {
        self.paopaoView.beyondLeft = YES;
    }else if (index * _Xmargin + _Xmargin / 2 - size.width * 0.5 > self.chartScrollView.contentSize.width - size.width && size.width > _Xmargin){
        self.paopaoView.beyondRight = YES;
    }
    
    [self.paopaoView show:dataArr and:self.dataArrOfX[index] colorArr:colorArr];
    
    [self addCircle:index];
}
//圆圈
- (void)addCircle:(NSInteger)index{
    for (UIView *view in self.charCircleViewArr) {
        [view removeFromSuperview];
    }
    NSMutableArray * leftColorArr = [NSMutableArray array];
    
    switch (_chartViewStyle) {
        case 0:
            for (int i = 0; i < _leftColorStrArr.count; i++) {
                [leftColorArr addObject:[UIColor colorWithHexString:_leftColorStrArr[i]]];
            }
            
            [self.charCircleViewArr removeAllObjects];
            [self drawCircle:index arr:self.leftPointArr color:leftColorArr];
            break;
        case 1:
            for (int i = 0; i < _leftColorStrArr.count; i++) {
                [leftColorArr addObject:[UIColor colorWithHexString:_leftColorStrArr[i]]];
            }
            
            [self.charCircleViewArr removeAllObjects];
            [self drawCircle:index arr:self.leftPointArr color:leftColorArr];
            break;
        
        case 2:
            for (int i = 0; i < _leftColorStrArr.count; i++) {
                [leftColorArr addObject:[UIColor colorWithHexString:_leftColorStrArr[i]]];
            }
            
            
            for (int i = 0; i < _rightColorStrArr.count; i++) {
                [leftColorArr addObject:[UIColor colorWithHexString:_rightColorStrArr[i]]];
            }
            
            
            [self.charCircleViewArr removeAllObjects];
            [self drawCircle:index arr:self.leftPointArr color:leftColorArr];
            break;
            
        default:
            break;
    }
    
    
    //[self.chartScrollView bringSubviewToFront:self.paopaoView];
}

- (void)drawCircle:(NSInteger)index arr:(NSArray *)pointArr color:(NSArray<UIColor *> *)colors{
    for (int i = 0; i<pointArr.count; i++) {
        NSArray *arr = pointArr[i];
        if (arr.count > index){
            CGPoint point = [arr[index] CGPointValue];
            UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KCircleRadius*2, KCircleRadius*2)];
            view.center = point;
            if (i == 0 && self.isFloating) {
                if (point.y - CGRectGetHeight(self.paopaoView.frame) - KCircleRadius >= 0) {
                    CGRect frame = self.paopaoView.frame;
                    frame.origin.y = point.y - CGRectGetHeight(self.paopaoView.frame) - KCircleRadius;
                    [self.paopaoView setFrame:frame];
                    [self.paopaoView drawBoxWithDirection:directionTop];
                    
                }else{
                    CGRect frame = self.paopaoView.frame;
                    frame.origin.y = point.y + KCircleRadius;
                    [self.paopaoView setFrame:frame];
                    [self.paopaoView drawBoxWithDirection:directionBottom];
                    
                    
                }
            }else if(i == 0){
                 [self.paopaoView drawBoxWithDirection:directionTop];
            }
            view.backgroundColor = colors[i];
            view.layer.cornerRadius = KCircleRadius;
            view.layer.borderColor = [UIColor whiteColor].CGColor;
            view.layer.borderWidth = 1;
            view.layer.masksToBounds = YES;
            [self.chartScrollView addSubview:view];
            [self.charCircleViewArr addObject:view];
        }
    }
    [self.chartScrollView bringSubviewToFront:self.paopaoView];
}

-(void)addLines1With:(UIView *)view{
    
    CGFloat magrginHeight = (view.bounds.size.height)/ _row;
    Ymargin = magrginHeight;
    
    CAShapeLayer * dashLayer = [CAShapeLayer layer];
    dashLayer.strokeColor = [UIColor colorWithRed:224/255.0f green:224/255.0f blue:224/255.0f alpha:1].CGColor;
    // 默认设置路径宽度为0，使其在起始状态下不显示
    dashLayer.lineWidth = 0.5;
    
    UIBezierPath * path = [[UIBezierPath alloc]init];
    path.lineWidth = 1.0;
    
    [path moveToPoint:CGPointMake(titleWOfY, CGRectGetHeight(_chartScrollView.frame))];
    [path addLineToPoint:CGPointMake(titleWOfY,0)];
    [path moveToPoint:CGPointMake(titleWOfY, CGRectGetHeight(_chartScrollView.frame))];
    [path addLineToPoint:CGPointMake(CGRectGetMaxX(_chartScrollView.frame),CGRectGetHeight(_chartScrollView.frame))];
    if (_chartViewStyle == LRSChartViewLeftRightLine) {
        [path moveToPoint:CGPointMake(CGRectGetMaxX(_chartScrollView.frame) + 1, CGRectGetHeight(_chartScrollView.frame))];
        [path addLineToPoint:CGPointMake(CGRectGetMaxX(_chartScrollView.frame) + 1,0)];
    }
    dashLayer.path = path.CGPath;
    [self.layer addSublayer:dashLayer];

}





@end
