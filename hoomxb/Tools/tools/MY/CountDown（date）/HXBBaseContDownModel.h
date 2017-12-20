//
//  HXBBaseContDownModel.h
//  hoomxb
//
//  Created by caihongji on 2017/12/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBBaseContDownModel : NSObject<NSCopying>
//倒计时的String
@property (nonatomic,copy) NSString *countDownLastStr;
//储存倒计时时间的string
@property (nonatomic,copy) NSString *countDownString;
@end
