//
//  HXBDataManager.m
//  hoomxb
//
//  Created by HXB on 2017/8/4.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBDataManager.h"
//理财页
static NSString *const fin_PlanListViewModelArrayPlist = @"fin_PlanListViewModelArray.plist";
static NSString *const fin_LoanListViewModelArrayPlist = @"fin_LoanListViewModelArray.plist";
static NSString *const fin_LoanTransferListViewModelArrayPlist = @"fin_LoanTransferListViewModelArray.plist";

//首页
static NSString *const homePage_PlanListViewModelArrayPlist = @"homePage_PlanListViewModelArray.plist";

@interface HXBDataManager ()
@end
@implementation HXBDataManager


#pragma mark - 理财页
+ (NSArray *) getFin_PlanListViewModelArray {
    return [self getViewModelWithTypeStr:fin_PlanListViewModelArrayPlist];
}
+ (NSArray *) getFin_LoanListViewModelArray {
    return [self getViewModelWithTypeStr:fin_LoanListViewModelArrayPlist];
}
+ (NSArray *) getFin_LoanTransferListViewModelArray {
    return [self getViewModelWithTypeStr:fin_LoanTransferListViewModelArrayPlist];
}


+ (void) setFin_PlanListViewModelArrayWithArray:(NSArray *)planArray {
    [self setViewModelWithModelArray:planArray andTypeString:fin_PlanListViewModelArrayPlist];
}
+ (void) setFin_LoanListViewModelArray:(NSArray *)loanArray {
    [self setViewModelWithModelArray:loanArray andTypeString:fin_LoanListViewModelArrayPlist];
}
+ (void) setFin_LoanTransferListViewModelArrayWithArray:(NSArray *)loanTransferArray {
    [self setViewModelWithModelArray:loanTransferArray andTypeString:fin_LoanTransferListViewModelArrayPlist];
}


#pragma mark - 首页
+ (NSArray *) getHomePage_PlanListViewModelArray {
    return [self getViewModelWithTypeStr:homePage_PlanListViewModelArrayPlist];
}
+ (void) setHomePage_PlanListViewModelArrayWithArray:(NSArray *)homePagePlanArray {
    [self setViewModelWithModelArray:homePagePlanArray andTypeString:homePage_PlanListViewModelArrayPlist];
}











+ (NSString *)getPathWithType:(NSString *)type {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [path stringByAppendingPathComponent:type];
    return filePath;
}

+ (void) setViewModelWithModelArray:(NSArray *)array andTypeString:(NSString *)typeStr{
//    NSMutableArray *arrayM = [[NSMutableArray alloc]init];
//    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        [arrayM addObject: [obj yy_modelToJSONData]];
//    }];
//    [arrayM writeToFile:[self getPathWithType:typeStr] atomically:true];
//    NSLog(@"|||||存储 数据 - 地址%@",[self getPathWithType:typeStr]);
//    NSLog(@"|||||存储 数据 - 数组%@",array);
}
+ (NSArray *) getViewModelWithTypeStr: (NSString *)typeStr {
    NSLog(@"|||||读取缓存 数据 - 地址%@",[self getPathWithType:typeStr]);
    NSLog(@"|||||读取缓存 数据 - 数组%@",[self getPathWithType:typeStr]);
    NSArray  *data = [NSArray arrayWithContentsOfFile:[self getPathWithType:typeStr]];
    NSMutableArray *arrayM = [[NSMutableArray alloc]init];
//    [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//         [arrayM addObject: [obj yy_modelToJSONObject]];
//    }];
//    
    return arrayM;
}
@end
