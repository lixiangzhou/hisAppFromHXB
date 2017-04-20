//
//  BaseModel.h
//  NetWorkingTest
//
//  Created by HXB-C on 2017/3/27.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject
@property (nonatomic, assign) NSInteger code;

@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSDictionary *data;
@end
