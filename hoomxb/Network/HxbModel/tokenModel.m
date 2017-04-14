//
//  tokenModel.m
//  NetWorkingTest
//
//  Created by HXB-C on 2017/3/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "tokenModel.h"

@implementation tokenModel
//- (NSString *)dataModel
//{
//    NSDictionary * dic = [self dictionaryWithJsonString:_data];
//    tokenModel *model = [tokenModel yy_modelWithJSON:dic];
//    return model;
//}

//-(void)setRawModel:(FYResultRawModel *)rawModel{
//    NSDictionary * dic = [self dictionaryWithJsonString:_raw];
//    _rawModel = [FYResultRawModel yy_modelWithJSON:dic];
//}

- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
@end
