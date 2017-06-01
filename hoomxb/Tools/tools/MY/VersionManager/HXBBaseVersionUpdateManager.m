//
//  HXBBaseVersionUpdateManager.m
//  hoomxb
//
//  Created by HXB on 2017/5/26.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseVersionUpdateManager.h"

static NSString *const kHXBIsFirstStartUPAPP = @"isFirstStartUPAPP";
static NSString *const kHXBCFBundleShortVersionString = @"CFBundleShortVersionString";

@implementation HXBBaseVersionUpdateManager : NSObject

+ (BOOL) isFirstStartUPAPP {
    id isFirstStartUPAPP = [[NSUserDefaults standardUserDefaults] valueForKey:kHXBIsFirstStartUPAPP];
    if (!isFirstStartUPAPP) {
        [[NSUserDefaults standardUserDefaults] setObject:@"false" forKey:kHXBIsFirstStartUPAPP];
        return true;
    }
    return false;
}

+ (BOOL) isUPDataAPPWithAPPID: (CGFloat)APPID {
    NSString *appleID = @(APPID).description;
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://itunes.apple.com/lookup?id=%@",appleID]]];
    [request setHTTPMethod:@"GET"];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSMutableDictionary *jsondata = [NSJSONSerialization JSONObjectWithData:returnData options:NSJSONReadingMutableLeaves error:nil];
    
    NSLog(@"jsondata===%@",jsondata);
    NSMutableArray *resultsArr = [jsondata objectForKey:@"results"];
    NSMutableDictionary *infodic = [resultsArr objectAtIndex:0];
    NSString *latestVersion = [infodic objectForKey:@"version"];
    NSString *trackViewUrl = [infodic objectForKey:@"trackViewUrl"];
    NSLog(@"%@",trackViewUrl);
    NSLog(@"latestVersion=%@",latestVersion);
    
    [[NSUserDefaults standardUserDefaults]setObject:trackViewUrl forKey:@"trackViewUrl"];
    NSLog(@"uurrll=%@",trackViewUrl);
    NSDictionary *infoDict = [[NSBundle mainBundle] infoDictionary];
    NSString *currentVersion = [infoDict objectForKey:kHXBCFBundleShortVersionString];
    
    NSLog(@"当前版本号是%@",currentVersion);
    NSLog(@"doublecurrent=%@",currentVersion);
    
    if ([currentVersion isEqualToString:latestVersion]) {
        NSLog(@"版本相同 不用更新");
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"updateVersion"];
        [[NSUserDefaults standardUserDefaults] setObject:@"no" forKey:@"updateVersion"];
        
    }else
    {   NSArray * newVerAry = [latestVersion componentsSeparatedByString:@"."];
        NSArray * curVerAry = [currentVersion componentsSeparatedByString:@"."];
        for (int i = 0; i < [newVerAry count] || i < [curVerAry count]; i++)
        {
            int newSubVer, curSubVer;
            // 如果子版本号数不足，作为0处理
            if (i >= [newVerAry count])
            {
                newSubVer = 0;
            }
            else
            {
                newSubVer = [[newVerAry objectAtIndex:i] intValue];
            }
            
            if( i >= [curVerAry count])
            {
                curSubVer = 0;
            }
            else
            {
                curSubVer = [[curVerAry objectAtIndex:i] intValue];
            }
            
            if( newSubVer > curSubVer)
            {
                NSLog(@"当前版本低 ，需要更新");
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"updateVersion"];
                [[NSUserDefaults standardUserDefaults] setObject:@"yes" forKey:@"updateVersion"];
                NSLog(@"version == yes");
                
            }
            else if( newSubVer < curSubVer)
            {
                NSLog(@"当前版本高 不需要更新");
                [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"updateVersion"];
                [[NSUserDefaults standardUserDefaults] setObject:@"no" forKey:@"updateVersion"];
            }
        }
    }
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"updateVersion"];
}


//输出YES（服务器大与本地） 输出NO（服务器小于本地）
- (BOOL)compareEditionNumber:(NSString *)serverNumberStr localNumber:(NSString*)localNumberStr {
    // 获取app版本
//    NSString *app_Version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    
    //剔除版本号字符串中的点
    serverNumberStr = [serverNumberStr stringByReplacingOccurrencesOfString:@"." withString:@""];
    localNumberStr = [localNumberStr stringByReplacingOccurrencesOfString:@"." withString:@""];
    //计算版本号位数差
    int placeMistake = (int)(serverNumberStr.length-localNumberStr.length);
    //根据placeMistake的绝对值判断两个版本号是否位数相等
    if (abs(placeMistake) == 0) {
        //位数相等
        return [serverNumberStr integerValue] > [localNumberStr integerValue];
    }else {
        //位数不等
        //multipleMistake差的倍数
        NSInteger multipleMistake = pow(10, abs(placeMistake));
        NSInteger server = [serverNumberStr integerValue];
        NSInteger local = [localNumberStr integerValue];
        if (server > local) {
            return server > local * multipleMistake;
        }else {
            return server * multipleMistake > local;
        }
    }
}
@end
