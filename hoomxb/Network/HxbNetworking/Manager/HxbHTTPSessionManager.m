        //
//  HxbHTTPSessionManager.m
//  hoomxb
//
//  Created by HXB-C on 2017/4/17.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbHTTPSessionManager.h"
#import "HXBTokenModel.h"
#import "HxbHUDProgress.h"
#import <AdSupport/AdSupport.h>
#import "NYNetworkConfig.h"
@implementation HxbHTTPSessionManager


- (NSURLSessionDataTask *)dataTaskWithRequest:(NSURLRequest *)request
                               uploadProgress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgressBlock
                             downloadProgress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgressBlock
                            completionHandler:(nullable void (^)(NSURLResponse *response, id _Nullable responseObject,  NSError * _Nullable error))completionHandler{
   
    void (^authFailBlock)(NSURLResponse *response, id _Nullable responseObject,  NSError * _Nullable error) = ^(NSURLResponse *response, id _Nullable responseObject,  NSError * _Nullable error)
    {
        NSLog(@"error %@",error);
        
        NSHTTPURLResponse* httpResponse = (NSHTTPURLResponse*)response;
        ///获取code码，如果是401 那么表示token失效
        if([httpResponse statusCode] == kHXBCode_Enum_TokenNotJurisdiction){
            //删除token 让客户登录
            [[KeyChainManage sharedInstance] removeToken];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            
                //调用refreshAccesstoken方法，刷新access token。
                [self refreshAccessToken:^(NSData *data) {
                    if (!data) {
                        return ;
                    }
                    NSDictionary *dic = [[NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil] objectForKey:@"data"];
                    HXBTokenModel *model = [HXBTokenModel yy_modelWithJSON:dic];
                    NSLog(@"😝😝😝😝😝%@",model.token);
                    kNetWorkError(@"token失效");
                   
                    [KeyChain setToken:model.token];
                    
                    NSURLRequest *newRequest = request;
                    NSMutableURLRequest *mutableRequest = [request mutableCopy];    //拷贝request
                    [mutableRequest setValue:[KeyChain token] forHTTPHeaderField:@"X-Hxb-Auth-Token"];
                    newRequest = [mutableRequest copy];
                    NSLog(@"request >>>>>>>>    %@",newRequest.allHTTPHeaderFields);
                    
                    NSURLSessionDataTask *originalTask = [super dataTaskWithRequest:newRequest uploadProgress:uploadProgressBlock downloadProgress:downloadProgressBlock completionHandler:completionHandler];
                    [originalTask resume];
                }];
            });
        }else{
            NSLog(@"no auth error");
            completionHandler(response, responseObject, error);
        }
    };
    
    NSURLSessionDataTask *stask = [super dataTaskWithRequest:request
                                              uploadProgress:uploadProgressBlock
                                            downloadProgress:downloadProgressBlock
                                           completionHandler:authFailBlock];
    return stask;
}

//- (void)getToken{
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
//        NSString *tokenURL = [NSString stringWithFormat:@"%@%@",BASEURL,TOKENURL];
//        AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//        [manager GET:tokenURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
//            
//        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            NSLog(@"😝😝😝😝😝%@",responseObject);
//            NSDictionary *dic = [responseObject objectForKey:@"data"];
//            tokenModel *model = [tokenModel yy_modelWithJSON:dic];
//            NSLog(@"😝😝😝😝😝%@",model.token);
//            [KeyChain setToken:model.token];
//        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            NSLog(@"😱😱😱😱😱%@",error);
//        }];
//    });
//}

-(void)refreshAccessToken:(void(^)(NSData *data))refresh{
    NSString *tokenURLString = [NSString stringWithFormat:@"%@%@",BASEURL,TOKENURL];
    NSURL *tokenURL =[NSURL URLWithString:tokenURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL:tokenURL];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:
                                  ^(NSData *data, NSURLResponse *response, NSError *error) {
                                      if (!data) {
                                          return ;
                                      }
                                      NSLog(@"data:%@",response);
                                       NSLog(@"%@", [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil]);
                                      refresh(data);
                                  }];
    
    [task resume];
}

@end
