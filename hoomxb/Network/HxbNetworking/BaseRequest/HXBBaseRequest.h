//
//  HXBBaseRequest.h
//  hoomxb
//
//  Created by HXB on 2017/6/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "NYBaseRequest.h"
/// 对上啦刷新与下拉加载做了处理
@interface HXBBaseRequest : NYBaseRequest



@property (nonatomic, strong) NSMutableDictionary *infoDic;
///是否是上啦刷新
@property (nonatomic, assign) BOOL isUPReloadData;
///当前页数
@property (nonatomic,assign) NSInteger dataPage;
///处理数据 后的 的Block
@property (nonatomic,copy) void (^successBlock)(NSArray *dataArray);
///viewmodel的类型
@property (nonatomic,assign) Class viewModelClass;
@property (nonatomic,assign) Class modelClass;

//================================== function ==================================
#pragma mark - 数据未做处理
- (void)start;

- (void)startWithSuccess:(void(^)(HXBBaseRequest *request, id responseObject))success
              failure:(void(^)(HXBBaseRequest *request, NSError *error))failure;

- (void)startWithHUDStr:(NSString *)string Success:(void(^)(HXBBaseRequest *request, id responseObject))success
             failure:(void(^)(HXBBaseRequest *request, NSError *error))failure;

- (void)startAnimationWithSuccess:(void(^)(HXBBaseRequest *request, id responseObject))success
                       failure:(void(^)(HXBBaseRequest *request, NSError *error))failure;

#pragma mark - 数据做了初步的处理
//- (void)hxbRequestWithViewModelClass: (Class)viewModelClass
//                       andModelClass: (Class)modelClass
//                          andSuccess: (void (^)(NSArray *dataArray))successBlock
//                          andFailure: (void (^)(HXBBaseRequest *request, NSError *error))failureBlock;
@end
