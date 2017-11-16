//
//  HXBUMShareViewModel.h
//  hoomxb
//
//  Created by HXB-C on 2017/11/15.
//Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMSocialCore/UMSocialCore.h>
@class HXBUMShareModel;
@interface HXBUMShareViewModel : NSObject

@property (nonatomic, strong) HXBUMShareModel *shareModel;


/**
 获取分享数据

 @param successDateBlock 成功回调
 @param failureBlock 失败回调
 */
- (void)UMShareRequestSuccessBlock: (void(^)(HXBUMShareViewModel * shareViewModel))successDateBlock andFailureBlock: (void(^)(NSError *error))failureBlock;


/**
 根据不同分享获取不同渠道连接

 @param type 分享类型
 @return 渠道连接
 */
- (NSString *)getShareLink:(UMSocialPlatformType)type;
@end
