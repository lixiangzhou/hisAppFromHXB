//
//  NSDate+MTCompareDate.m
//  MTHD
//
//  Created by 李鹏跃 on 16/12/23.
//  Copyright © 2016年 13lipengyue. All rights reserved.
//

#import "NSDate+CompareDate.h"

@implementation NSDate (CompareDate)


#pragma mark - 比较当前时间与传入时间的方法
+ (BOOL)isLateCurrentDateWithDate: (NSObject *)date_OBJ{
    
    NSDate *compareDate = [self returnDateWithOBJ:date_OBJ];
    //2、表示事件格式转化完毕 比较时间
        //1.0 获取当前时间
    NSDate *currentDate = [[NSDate alloc]init];
        //2.0 比较时间
        //NSOrderedAscending 升序
        // NSOrderedSame 相同
        // NSOrderedDescending 降序
    //升序表示比现在事件要晚
   BOOL isTrue = [currentDate compare:compareDate] == NSOrderedAscending;
    
    return isTrue;
}


#pragma mark - 获取时间的年月日
+ (void)date: (NSObject *)getDate andDateBlock: (void(^)(NSInteger year, NSInteger month, NSInteger day, NSInteger hour,NSInteger minute, NSInteger second))dateBlock{
    
    
    //1.时间
    NSDate *get_Date = [self returnDateWithOBJ:getDate];

    
    //3.判断是否为时间对象
    if (!get_Date) {
        NSLog(@"传入的对象转化时间对象失败");
        return;
    }
    
    //4.引入当前的日历
    NSCalendar *crrentCalender = [NSCalendar currentCalendar];
    
    //5.通过日历 创建NSDateComponents
    //里面储存了对应的年月日 compareDate的
    NSDateComponents *compareDateComponents = [crrentCalender components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:get_Date];
    
    //年
    NSInteger year = compareDateComponents.year;
    //月
    NSInteger month = compareDateComponents.month;
    //日
    NSInteger day = compareDateComponents.day;
    //时
    NSInteger hour = compareDateComponents.hour;
    //分
    NSInteger minute = compareDateComponents.minute;
    //秒
    NSInteger second = compareDateComponents.second;
    
    //7. 比较并返回结果
    if (dateBlock) {
        dateBlock(year,month,day,hour,minute,second);
    }
}
/**
 * 开始到结束的时间差
 */
#pragma mark - 比较两个时间并且返回字符串
+ (NSString *)compareDateGapWithCompareDate: (NSObject *)startTime andSecondCompareDate: (NSObject *)endTime {
    
    
    
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *startD =[self returnDateWithOBJ:startTime];
    NSDate *endD = [self returnDateWithOBJ:endTime];
    
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    NSTimeInterval value = end - start;
    int second = (int)value %60;//秒
    int minute = (int)value /60%60;
    int house = (int)value / (24 * 3600)%3600;
    int day = (int)value / (24 * 3600);
    
    
    
    
    NSString *str;
    if (day != 0) {
        str = [NSString stringWithFormat:@"%d天%d小时%d分%d秒",day,house,minute,second];
    }else if (day==0 && house != 0) {
        str = [NSString stringWithFormat:@"%d小时%d分%d秒",house,minute,second];
    }else if (day== 0 && house== 0 && minute!=0) {
        str = [NSString stringWithFormat:@"%d分%d秒",minute,second];
    }else{
        str = [NSString stringWithFormat:@"%d秒",second];
    }
    return str;
    
}




#pragma mark - 转化把对象转化成时间对象的方法
+ (NSDate *)returnDateWithOBJ: (NSObject *)date_OBJ andDateFormatter: (NSString *)dateFormatterStr{
    //1、创建时间
    NSDate *returnDate = [[NSDate alloc]init];
    
    if ([date_OBJ isKindOfClass:[NSString class]]){//是字符串
        NSString *dateStr = (NSString *)date_OBJ;
        
        //1. 把字符串 转化成事件对象
        //1.0时间格式化对象
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateFormat = dateFormatterStr;
        //2.0时间格式化
        returnDate = [dateFormatter dateFromString:dateStr];
    }else if ([date_OBJ isKindOfClass: [NSDate class]]){
        returnDate = (NSDate *)date_OBJ;
    }else{
        NSLog(@"传入是--%@--类型不能转化成时间的对象",NSStringFromClass(date_OBJ));
        return nil;
        
    }
    return returnDate;
}




#pragma mark - 两个时间相比的差值
+ (NSString *)compareDateWithandDateFormatter: (NSString *)dateFormatterStr andCompareDate: (NSString *)startTime andSecondCompareDate: (NSString *)endTime andDateBlock: (void(^)(NSInteger year, NSInteger month, NSInteger day, NSInteger hour,NSInteger minute, NSInteger second))dateBlock {
    
    if (!dateFormatterStr){
        dateFormatterStr = @"yyyy-MM-dd HH:mm:ss";
    }
    
    //1；保证格式统一
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    dateFomatter.dateFormat = dateFormatterStr;
    
    // 截止时间data格式
    NSDate *startDateTemp = [NSDate returnDateWithOBJ:startTime];
     // 截止时间data格式
    NSDate *endDateTemp = [NSDate returnDateWithOBJ:endTime];
    // 开始时间字符串格式
    NSString *startDateStr = [dateFomatter stringFromDate:startDateTemp];
    // 截止时间字符串格式
    NSString *endDateStr = [dateFomatter stringFromDate:endDateTemp];
    //转成统一的格式
    NSDate *nowDate = [dateFomatter dateFromString:startDateStr];
    NSDate *expireDate = [dateFomatter dateFromString:endDateStr];
    
    //2. 比较数据
    // 当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 需要对比的时间数据
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth
    | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 对比时间差
    NSDateComponents *dateCom = [calendar components:unit fromDate:nowDate toDate:expireDate options:NSCalendarWrapComponents ];
    
    //年
    NSInteger year = dateCom.year;
    //月
    NSInteger month = dateCom.month;
    //日
    NSInteger day = dateCom.day;
    //时
    NSInteger hour = dateCom.hour;
    //分
    NSInteger minute = dateCom.minute;
    //秒
    NSInteger second = dateCom.second;
    
    // 比较并返回结果
    if (dateBlock) {
        dateBlock(year,month,day,hour,minute,second);
    }
    // 伪代码
//    年差额 = dateCom.year, 月差额 = dateCom.month, 日差额 = dateCom.day, 小时差额 = dateCom.hour, 分钟差额 = dateCom.minute, 秒差额 = dateCom.second
    
    
    NSString *str;
    if (year != 0) {
        str = [NSString stringWithFormat:@"%zd年%zd月%zd天%zd小时%zd分%zd秒",year,month,day,hour,minute,second];
    }else if(year == 0 && month != 0) {
        str = [NSString stringWithFormat:@"%zd月%zd天%zd小时%zd分%zd秒",month,day,hour,minute,second];
    }else if (year == 0 && month == 0 && day != 0){
        str = [NSString stringWithFormat:@"%zd天%zd小时%zd分%zd秒",day,hour,minute,second];
    }else if (year == 0 && month == 0 && day == 0 && hour != 0){
        str = [NSString stringWithFormat:@"%zd小时%zd分%zd秒",hour,minute,second];
    }else if (year == 0 && month == 0 && day == 0 && hour != 0){
        str = [NSString stringWithFormat:@"%zd小时%zd分%zd秒",hour,minute,second];
    }else if (year == 0 && month == 0 && day == 0 && hour == 0 && minute!=0) {
        str = [NSString stringWithFormat:@"%zd分%zd秒",minute,second];
    }else{
        str = [NSString stringWithFormat:@"%zd秒",second];
    }
    return str;
}




- (void) 关于事件的学习 {
    /*
     
     iOS时间那点事
     
     NSCalendar + NSDateComponents
     
     历法能使人类确定每一日再无限的时间中的确切位置并记录历史。
     日历，历法，一般历法都是遵循固定的规则的，具有周期性。日历都是已知的或可预测的。
     任何一种具体的历法，首先必须明确规定起始点，即开始计算的年代，这叫“纪元”；以及规定一年的开端，这叫“岁首”。此外，还要规定每年所含的日数，如何划分月份，每月有多少天等等。
     NSCalendar对世界上现存的常用的历法进行了封装，既提供了不同历法的时间信息，又支持日历的计算。
     NSDateFomatter表示的时间默认以公历（即阳历）为参考，可以通过设置calendar属性变量获得特定历法下的时间表示。
     NSDate是独立与任何历法的，它只是时间相对于某个时间点的时间差；NSDate是进行日历计算的基础。
     NSDateComponents将时间表示成适合人类阅读和使用的方式，通过NSDateComponents可以快速而简单地获取某个时间点对应的“年”，“月”，“日”，“时”，“分”，“秒”，“周”等信息。当然一旦涉及了年月日时分秒就要和某个历法绑定，因此NSDateComponents必须和NSCalendar一起使用，默认为公历。
     NSDateComponents除了像上面说的表示一个时间点外，还可以表示时间段，例如：两周，三个月，20年，7天，10分钟，50秒等等。时间段用于日历的计算，例如：获取当前历法下，三个月前的某个时间点。
     可以说，要获取某个时间点在某个历法下的表示，需要NSDateComponents；要计算当前时间点在某个历法下对应的一个时间段前或后的时间点，需要NSDateComponents。
     NSDateComponents返回的day, week, weekday, month, year这一类数据都是从1开始的。因为日历是给人看的，不是给计算机看的，从0开始就是个错误。
     */
    
    //    先定义一个遵循某个历法的日历对象
    NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    //    通过已定义的日历对象，获取某个时间点的NSDateComponents表示，并设置需要表示哪些信息（NSYearCalendarUnit, NSMonthCalendarUnit, NSDayCalendarUnit等）
    NSDateComponents *dateComponents = [greCalendar components:NSYearCalendarUnit | NSMonthCalendarUnit|NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit |NSSecondCalendarUnit | NSWeekCalendarUnit | NSWeekdayCalendarUnit|NSWeekOfMonthCalendarUnit | NSWeekOfYearCalendarUnit fromDate:[NSDate date]];
    NSLog(@"year(年份): %li", (long)dateComponents.year);
    NSLog(@"quarter(季度):%li", (long)dateComponents.quarter);
    NSLog(@"month(月份):%li", dateComponents.month);
    NSLog(@"day(日期):%li", dateComponents.day);
    NSLog(@"hour(小时):%li", dateComponents.hour);
    NSLog(@"minute(分钟):%li", dateComponents.minute);
    NSLog(@"second(秒):%li", dateComponents.second);
    
    //    Sunday:1, Monday:2, Tuesday:3, Wednesday:4, Friday:5, Saturday:6
    NSLog(@"weekday(星期):%li", dateComponents.weekday);
    
    //    苹果官方不推荐使用week
    NSLog(@"week(该年第几周):%li", dateComponents.week);
    NSLog(@"weekOfYear(该年第几周):%li", dateComponents.weekOfYear);
    NSLog(@"weekOfMonth(该月第几周):%li", dateComponents.weekOfMonth);
}


- (NSString *)compareDateWithandDateFormatter: (NSString *)dateFormatterStr andSecondCompareDate: (NSString *)endTime andDateBlock: (void(^)(NSInteger year, NSInteger month, NSInteger day, NSInteger hour,NSInteger minute, NSInteger second))dateBlock {
    
    if (!dateFormatterStr){
        dateFormatterStr = @"yyyy-MM-dd HH:mm:ss";
    }
    
    //1；保证格式统一
    NSDateFormatter *dateFomatter = [[NSDateFormatter alloc] init];
    dateFomatter.dateFormat = dateFormatterStr;
    
    // 截止时间data格式
    NSDate *endDateTemp = [NSDate returnDateWithOBJ:endTime];
    
    // 开始时间字符串格式
    NSString *startDateStr = [dateFomatter stringFromDate:self];
    // 截止时间字符串格式
    NSString *endDateStr = [dateFomatter stringFromDate:endDateTemp];
    //转成统一的格式
    NSDate *nowDate = [dateFomatter dateFromString:startDateStr];
    NSDate *expireDate = [dateFomatter dateFromString:endDateStr];
    
    //2. 比较数据
    // 当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 需要对比的时间数据
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth
    | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 对比时间差
    NSDateComponents *dateCom = [calendar components:unit fromDate:nowDate toDate:expireDate options:NSCalendarWrapComponents ];
    
    //年
    NSInteger year = dateCom.year;
    //月
    NSInteger month = dateCom.month;
    //日
    NSInteger day = dateCom.day;
    //时
    NSInteger hour = dateCom.hour;
    //分
    NSInteger minute = dateCom.minute;
    //秒
    NSInteger second = dateCom.second;
    
    // 比较并返回结果
    if (dateBlock) {
        dateBlock(year,month,day,hour,minute,second);
    }
    // 伪代码
    //    年差额 = dateCom.year, 月差额 = dateCom.month, 日差额 = dateCom.day, 小时差额 = dateCom.hour, 分钟差额 = dateCom.minute, 秒差额 = dateCom.second
    
    
    NSString *str;
    if (year != 0) {
        str = [NSString stringWithFormat:@"%zd年%zd月%zd天%zd小时%zd分%zd秒",year,month,day,hour,minute,second];
    }else if(year == 0 && month != 0) {
        str = [NSString stringWithFormat:@"%zd月%zd天%zd小时%zd分%zd秒",month,day,hour,minute,second];
    }else if (year == 0 && month == 0 && day != 0){
        str = [NSString stringWithFormat:@"%zd天%zd小时%zd分%zd秒",day,hour,minute,second];
    }else if (year == 0 && month == 0 && day == 0 && hour != 0){
        str = [NSString stringWithFormat:@"%zd小时%zd分%zd秒",hour,minute,second];
    }else if (year == 0 && month == 0 && day == 0 && hour != 0){
        str = [NSString stringWithFormat:@"%zd小时%zd分%zd秒",hour,minute,second];
    }else if (year == 0 && month == 0 && day == 0 && hour == 0 && minute!=0) {
        str = [NSString stringWithFormat:@"%zd分%zd秒",minute,second];
    }else{
        str = [NSString stringWithFormat:@"%zd秒",second];
    }
    return str;
}



@end
