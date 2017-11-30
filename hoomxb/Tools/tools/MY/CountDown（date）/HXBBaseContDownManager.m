//
//  PYTextModel.m
//  PYCountDown
//
//  Created by 李鹏跃 on 2017/4/19.
//  Copyright © 2017年 李鹏跃. All rights reserved.
//

#import "HXBBaseContDownManager.h"


@interface HXBBaseContDownManager()

///外界传入的开始倒计时时间(从什么时候开始倒计时)
@property (nonatomic,assign) long countDownStartTime;
///外界传入的倒计时基本单位
@property (nonatomic,assign) double countDownUnit;
/////外界传入的modelarray
//@property (nonatomic,strong) NSArray *modelArray;
///外界传入的model中计算倒计时时间的key
@property (nonatomic,copy) NSString *modelDateKey;
///外界传入的model中的用于倒计时显示的key
@property (nonatomic,copy) NSString *modelCountDownKey;
///传入的时间类型，是为原始时间还是剩余时间
@property (nonatomic,assign) PYContDownManagerModelDateType modelDateType;
///队列
@property(nonatomic,strong) dispatch_queue_t queue;
///用于对外刷新UI的接口
@property(nonatomic,copy) void(^countdownDataFredbackWithBlock)();
///每个model 的剩余时间属性改变的时候都会调用
@property(nonatomic,copy) void (^changeModelBlock)(id model, NSIndexPath *index);
//注意:此处应该使用强引用 strong
@property (nonatomic,strong) dispatch_source_t timer;
//记录了组数（暂时未用）
@property (nonatomic,assign) int column;
//记录需要倒计时的model
@property (nonatomic,strong) NSMutableArray *countDownArray;
//传入的model数组是否为二维数组
@property (nonatomic,assign) BOOL isTwo_DimensionalArray;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,assign) BOOL isPan;
//@property (nonatomic,strong) NSTimer *pyTimer;


@end



@implementation HXBBaseContDownManager
#pragma mark - setter

#pragma mark - getter

- (dispatch_source_t)timer {
    if (!_timer) {
        [self createTimer];
    }
    return _timer;
}
- (dispatch_queue_t)queue {
    if (!_queue) {
        _queue = dispatch_get_global_queue(0, 0);
    }
    return _queue;
}
- (double)countdownUnit {
    if (!_countDownUnit) {
        return 1;
    }
    return _countDownUnit;
}

- (long)countdownStartTime {
    if (!_countDownStartTime) {
        _countDownStartTime = 60 * 60;
    }
    return _countDownStartTime;
}

- (NSMutableArray *)countDownArray {
    if (!_countDownArray) {
        _countDownArray = [[NSMutableArray alloc]init];
    }
    return _countDownArray;
}


#pragma mark - setter 
- (void)setModelArray:(NSArray *)modelArray {
    _modelArray = modelArray;
    [self createTimer];
}
#pragma mark - 创建对象
+ (instancetype)countDownManagerWithCountDownStartTime: (long)countDownStartTime
                                      andCountDownUnit: (double)countDownUnit
                                         andModelArray: (NSArray *)modelArray
                                       andModelDateKey: (NSString *)modelDateKey
                                  andModelCountDownKey: (NSString *)modelCountDownKey
                                      andModelDateType: (PYContDownManagerModelDateType)modelDateType
{
    return [[self alloc]initWithCountDownStartTime:countDownStartTime
                                  andCountDownUnit:countDownUnit
                                     andModelArray:modelArray
                                   andModelDateKey:modelDateKey
                              andModelCountDownKey:modelCountDownKey
                                  andModelDateType:modelDateType];
}
- (instancetype)initWithCountDownStartTime: (long)countDownStartTime
                          andCountDownUnit: (double)countDownUnit
                             andModelArray: (NSArray *)modelArray
                           andModelDateKey: (NSString *)modelDateKey
                      andModelCountDownKey: (NSString *)modelCountDownKey
                          andModelDateType: (PYContDownManagerModelDateType)modelDateType
{
    self = [super init];
    if (self) {
        self.modelDateKey = modelDateKey;
        self.modelCountDownKey = modelCountDownKey;
        self.countDownStartTime = countDownStartTime;
        self.countDownUnit = countDownUnit;
        self.modelArray = modelArray;
        self.modelDateType = modelDateType;
        if (!self.timer){
            [self createTimer];
        }
    }
    return self;
}


#pragma mark - 倒计时开始
//MARK: 计时器的创建
- (void)createTimer {
        //0.创建队列
        dispatch_queue_t queue = self.queue;
        [self.modelArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSString *countDownStr = [obj valueForKey:self.modelCountDownKey];
            
            if (countDownStr.floatValue <= 0 || countDownStr.floatValue >= self.countDownStartTime) {
                [obj setValue:@"0" forKey:self.modelCountDownKey];
            }
        }];
        //1.创建GCD中的定时器
        /*
         第一个参数:创建source的类型 DISPATCH_SOURCE_TYPE_TIMER:定时器
         第二个参数:0
         第三个参数:0
         第四个参数:队列
         */
        dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
         self.timer = timer;
        //2.设置定时器
        /*
         第一个参数:定时器对象
         第二个参数:DISPATCH_TIME_NOW 表示从现在开始计时
         第三个参数:间隔时间 GCD里面的时间最小单位为 纳秒
         第四个参数:精准度(表示允许的误差,0表示绝对精准)
         */
        dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, self.countDownUnit * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
        
        //3.要调用的任务
        dispatch_source_set_event_handler(timer, ^{
            dispatch_async(self.queue, ^{
                if (self.isPan) {
                    return;
                }
                [self lookingForATimelyModelArray:self.modelArray];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (self.countdownDataFredbackWithBlock) {
                        self.countdownDataFredbackWithBlock();
                    }
                });
            });
        });
        
        //4.开始执行
        dispatch_resume(timer);
}



- (void)lookingForATimelyModelArray: (NSArray *)modelArray {
    
    if (!modelArray.count) {
        [self cancelTimer];
        return;
    }
    kWeakSelf
    [modelArray enumerateObjectsUsingBlock:^(id  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
        //如果依然是数组那么就在遍历一次
        if ([[model class] isSubclassOfClass:NSClassFromString(@"NSArray")]) {
            weakSelf.isTwo_DimensionalArray = true;
            weakSelf.column ++;
            NSArray *modelArray = model;
            [modelArray enumerateObjectsUsingBlock:^(id  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
                [weakSelf enumerateWithModel:model andIndex:idx];
            }];
        } else {
            [weakSelf enumerateWithModel:model andIndex:idx];
        }
    }];
}
- (void)enumerateWithModel: (id)model andIndex: (NSUInteger) idx{
    //判断model中的关于时间类的类型
    NSString *datelastValue= [model valueForKey:self.modelCountDownKey];
    NSString *dateValue = [model valueForKey:self.modelDateKey];//传入的model中计算倒计时时间的key
    __block long long dateNumber = dateValue.longLongValue;
    
    if (dateNumber == 0 && datelastValue.integerValue == 0) {
        if (self.isTwo_DimensionalArray) {
            if (!(self.countDownArray.count == self.column + 1)) {
                return;
            }
        }else {
            if (!(self.countDownArray.count == idx + 1)) {
                return;
            }
        }
    }

    //判断是否需要计算时间差
    if (self.modelDateType == PYContDownManagerModelDateType_OriginalTime){
        dateNumber --;
    }else {
        //时间差计算
        dateNumber = [self computationTimeDifferenceWithDateNumber:dateNumber];
    }
    
    //判断是否需要计时
    //以前的判断条件是这个：dateNumber <= self.countdownStartTime && dateNumber >= 0
    //如果没有加dateNumber >= 0 这个条件，那么就不会再都是0的时候发出消息让外部进行UI刷新
    if (dateNumber <= self.countdownStartTime) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (dateNumber <= 0) dateNumber = 0;
            [model setValue:@(dateNumber).description forKey:self.modelCountDownKey];
            [model setValue:@(dateNumber) forKey:self.modelDateKey];
            if(self.changeModelBlock) {
                //如果小于0，就是零，如果是
                NSInteger section = self.column  < 0 ? 0 : self.column;

                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:idx inSection:section];
                self.changeModelBlock(model,indexPath);
            }
        });
    }
    
    //如果是二维数组，并且到达最后了，就置为-1
    if (self.isTwo_DimensionalArray && self.column >= self.modelArray.count) {
        self.column = -1;
    }
    
    //是否自动关闭定时器
    if (!self.isAutoEnd) {
        return;
    }
    __block NSInteger count = 0;
    for (id model in self.modelArray) {
        if ([model valueForKey:self.modelDateKey] <= 0) {
            count++;
        }
    }
//    [self.modelArray enumerateObjectsUsingBlock:^(id  _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
//        if ([model valueForKey:self.modelDateKey] <= 0) {
//            count++;
//        }
//    }];
    if (count == self.modelArray.count) {
        [self cancelTimer];
    }
}

//MARK: 时间差的计算
- (long long)computationTimeDifferenceWithDateNumber: (long long)dateNumber {
    NSDate *date = [[NSDate alloc]init];
    if (self.clientTime) {
        date = self.clientTime;
    }
    NSTimeInterval timeInterval = [date timeIntervalSince1970];
    return (dateNumber - timeInterval);
}

//MARK: 外部刷新UI的接口
- (void)countdownDataFredbackWithBlock: (void(^)())countdownDataFredbackWithBlock {
    self.countdownDataFredbackWithBlock = countdownDataFredbackWithBlock;
}

//MARK: model改变的时候会调用
- (void)countDownWithChangeModelBlock:(void (^)(id, NSIndexPath *))changeModelBlock {
    self.changeModelBlock = changeModelBlock;
}

//MARK: 取消定时器
- (void)cancelTimer {
    @try {
        dispatch_cancel(self.timer);
    } @catch (NSException *exception) {
    } @finally {
        self.column = -1;
        self.timer = nil;
    }
    
    
}
//MARK: 开启定时器
- (void)resumeTimer {
    if (!self.timer){
        self.column = -1;
        [self createTimer];
    }
}
//MARK: 数组发生变化了
- (void)countDownWithModelArray:(NSArray *)modelArray andModelDateKey:(NSString *)modelDateKey andModelCountDownKey:(NSString *)modelCountDownKey {
    if (modelArray.count) {
        self.modelArray = modelArray;
    }
    if (modelDateKey) {
        self.modelDateKey = modelDateKey;
    }
    if (modelCountDownKey) {
        _modelCountDownKey = modelCountDownKey;
    }
    [self cancelTimer];
    [self resumeTimer];
}


- (void)stopWenScrollViewScrollBottomWithTableView: (UIScrollView *)scrollView {
    self.scrollView = scrollView;
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
        if ([keyPath isEqualToString:@"contentOffset"]) {
            UIScrollView *scrollView = (UIScrollView *)object;
            NSNumber *contentOffset = change[NSKeyValueChangeNewKey];
            CGFloat contentOffsetY = contentOffset.CGPointValue.y;
            //表示滑动到了底部
            BOOL isScrollViewBottom = (scrollView.contentSize.height - contentOffsetY) <= 1 + scrollView.frame.size.height - 2;
            if (isScrollViewBottom) {
                self.isPan = true;
            }else {
                self.isPan = false;
            }
        }
}

- (void)dealloc
{
    @try {
        [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
    } @catch (NSException *exception) {
        NSLog(@"%@--观察者异常被销毁", exception);
    } @finally {
        NSLog(@"");
    }
    NSLog(@"%@ - ✅被销毁",self.class);
}
@end
