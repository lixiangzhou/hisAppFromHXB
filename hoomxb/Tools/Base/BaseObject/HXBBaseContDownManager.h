//
//  PYTextModel.m
//  PYCountDown
//
//  Created by 李鹏跃 on 2017/4/19.
//  Copyright © 2017年 李鹏跃. All rights reserved.
//



//注意 需要做倒计时的model的储存剩余时间变量的key一定要是NSString类型
//关于更多，请看简书：http://www.jianshu.com/p/5d37adf1e03e
#import <UIKit/UIKit.h>


///传入的model中的用于倒计时时间的参数是剩余时间还是原始时间。
///如果是原始时间的话，还要比较时间差，然后在判断符不符合倒计时标准
typedef enum : NSUInteger {
    PYContDownManagerModelDateType_Remainder = 0,
    PYContDownManagerModelDateType_OriginalTime = 1,
} PYContDownManagerModelDateType;



@interface HXBBaseContDownManager : NSObject

/**
 * 请用这个方法（或者对应的init方法）创建对象
 * @param countDownStartTime 剩多少秒开始倒计时（默认剩余60分钟倒计时）
 * @param countDownUnit 倒计时单位时间（默认为1妙）
 * @param modelArray 需要倒计时的model数组
 * @param modelDateKey model储存到期时间的属性名
 * @param modelCountDownKey model储存剩余时间的属性名
 * @param modelDateType model中储存的到期时间是否为剩余时间
 */
+ (instancetype)countDownManagerWithCountDownStartTime: (long)countDownStartTime
                                      andCountDownUnit: (double)countDownUnit
                                         andModelArray: (NSArray *)modelArray
                                       andModelDateKey: (NSString *)modelDateKey
                                  andModelCountDownKey: (NSString *)modelCountDownKey
                                      andModelDateType: (PYContDownManagerModelDateType)modelDateType;
/**
 * 请用这个方法（或者对应的init方法）创建对象
 * @param countDownStartTime 剩多少秒开始倒计时
 * @param countDownUnit 倒计时单位时间
 * @param modelArray 需要倒计时的model数组
 * @param modelDateKey model储存到期时间的属性名
 * @param modelCountDownKey model储存剩余时间的属性名
 * @param modelDateType model中储存的到期时间是否为剩余时间
 */
- (instancetype)initWithCountDownStartTime: (long)countDownStartTime
                          andCountDownUnit: (double)countDownUnit
                             andModelArray: (NSArray *)modelArray
                           andModelDateKey: (NSString *)modelDateKey
                      andModelCountDownKey: (NSString *)modelCountDownKey
                          andModelDateType: (PYContDownManagerModelDateType)modelDateType;






// ------------------------ UI刷新的回调 ------------------------------------------
/**
 * 没次单位时间过后就会掉一次，可以在这里刷新UI（已经回到了主线程）
 * @param countdownDataFredbackWithBlock 给外界提供了model (这时候model已经赋值成功了)，
 */
- (void)countdownDataFredbackWithBlock: (void(^)())countdownDataFredbackWithBlock;

/**
 * 每个model的剩余值得改变都会调用
 * @param changeModelBlock 改变model时候的回调
 */
- (void)countDownWithChangeModelBlock: (void (^)(id model, NSIndexPath *index)) changeModelBlock;
/**
 * 刷新为单行刷新： [weakSelf.planListTableView reloadRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationNone];
 * 上拉加载时， 会出现卡顿，
 * 传入scrollView监听了偏移量，在滑动到底部的时候，会自动关闭Model的刷新和对外界的UI刷新，
 */
- (void)stopWenScrollViewScrollBottomWithTableView: (UIScrollView *)scrollView;







// ------------------------ 数组改变或者数组中的model改变 调用次方法 -----------------------------
/// 需要倒计时的model数组 （在model 改变后，会自动开启定时器）
@property (nonatomic,strong) NSArray *modelArray;

/**当数组发生变化的时候调用
* @param modelArray 需要倒计时的model数组
* @param modelDateKey model储存到期时间的属性名
* @param modelCountDownKey model储存剩余时间的属性名
 */
- (void)countDownWithModelArray: (NSArray *)modelArray andModelDateKey: (NSString *)modelDateKey
           andModelCountDownKey: (NSString *)modelCountDownKey;



// ----------------------- 定时器管理 -------------------------------------------------------
///取消定时器
- (void)cancelTimer;
/// 开启定时器
- (void)resumeTimer;
///是否自动停止 (在没有需要定时的时候，如果是，那么将不会自动开启默认是NO)
@property (nonatomic,assign) BOOL isAutoEnd;



// ----------------------- 服务器时间的协调 ----------------------
/**
 * 客户端时间,默认为手机的当前时间。如果有偏差可以在这里调整
 */
@property (nonatomic,strong) NSDate *clientTime;








@end
