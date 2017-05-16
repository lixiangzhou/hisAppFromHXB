//
//  HXBFinModel_AddRecortdModel_Plan.h
//  hoomxb
//
//  Created by HXB on 2017/5/12.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HXBFinModel_AddRecortdModel_Plan_dataList;
///理财模块的加入记录接口
@interface HXBFinModel_AddRecortdModel_Plan : NSObject
@property (nonatomic,copy) NSArray <HXBFinModel_AddRecortdModel_Plan_dataList*> *dataList;//": [
@property (nonatomic,copy) NSString *rsvRecordsCount;//": 0,
@property (nonatomic,copy) NSString *joinRecordsCount;//": 6,
@property (nonatomic,copy) NSString *myJoinCount;//": 3
@end


///理财模块的加入记录接口的dataList
@interface HXBFinModel_AddRecortdModel_Plan_dataList : NSObject
@property (nonatomic,copy) NSString *amount_YUAN;//拼接了 “元”汉字
@property (nonatomic,copy) NSString *amount;//": 1000,
@property (nonatomic,copy) NSString *index;//": 6,
@property (nonatomic,copy) NSString *joinTime;//": 1492264587000,
@property (nonatomic,copy) NSString *nickName;//": "null",
@property (nonatomic,copy) NSString *type;//": "ME"
@end

/**

{
    "data": {
        "dataList": [
                     {
                         "amount": 1000,
                         "index": 6,
                         "joinTime": 1492264587000,
                         "nickName": "null",
                         "type": "ME"
                     },
                     {
                         "amount": 100000,
                         "index": 5,
                         "joinTime": 1492264587000,
                         "nickName": "null",
                         "type": "ME"
                     },
                     {
                         "amount": 2000,
                         "index": 4,
                         "joinTime": 1492264587000,
                         "nickName": "null",
                         "type": "ME"
                     }
                     ],
        "rsvRecordsCount": 0,
        "joinRecordsCount": 6,
        "myJoinCount": 3
    },
    "message": "success",
    "status": 0
}


 
 */
