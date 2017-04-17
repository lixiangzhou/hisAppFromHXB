//
//  HxbHTTPSessionManager.m
//  hoomxb
//
//  Created by HXB-C on 2017/4/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbHTTPSessionManager.h"
#import "tokenModel.h"


@implementation HxbHTTPSessionManager


- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request
                               uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgressBlock
                             downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                            completionHandler:(nullable void (^)(NSURLResponse *response, id _Nullable responseObject,  NSError * _Nullable error))completionHandler{
    
    void (^authFailBlock)(NSURLResponse *response, id _Nullable responseObject,  NSError * _Nullable error) = ^(NSURLResponse *response, id _Nullable responseObject,  NSError * _Nullable error)
    {
        

        NSLog(@"error %@",error);
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
        if([httpResponse statusCode] == 401){
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        [self getToken];
        
    });
        }else{
            NSLog(@"no auth error");
            completionHandler(response, responseObject, error);
        }
    };
    
    NSURLSessionDataTask *stask = [super dataTaskWithRequest:request uploadProgress:uploadProgressBlock downloadProgress:downloadProgressBlock completionHandler:authFailBlock];
    
    return stask;
    
    
    
}

- (void)getToken{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        NSString *tokenURL = [NSString stringWithFormat:@"%@%@",BASEURL,TOKENURL];
        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
        [manager GET:tokenURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            NSLog(@"😝😝😝😝😝%@",responseObject);
            NSDictionary *dic = [responseObject objectForKey:@"data"];
            tokenModel *model = [tokenModel yy_modelWithJSON:dic];
            NSLog(@"😝😝😝😝😝%@",model.token);
            [KeyChain setToken:model.token];
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            NSLog(@"😱😱😱😱😱%@",error);
        }];
    });
}
@end
