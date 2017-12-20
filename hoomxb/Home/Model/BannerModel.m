//
//  BannerModel.m
//  hoomxb
//
//  Created by HXB-C on 2017/5/2.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "BannerModel.h"

@implementation BannerModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"ID" : @"id"};
}

- (void)setLinkPath:(NSString *)linkPath {
    if (self.link.length) {
        _linkPath = [self.link componentsSeparatedByString:@"?"].firstObject;
    }
}

- (void)setParameter:(NSDictionary *)parameter {
    if (self.link.length) {
        NSMutableArray *keyArray = [NSMutableArray array];
        NSMutableArray *ValueArray = [NSMutableArray array];
        NSString *linkPathLastString = [self.link componentsSeparatedByString:@"?"].lastObject;
        for (NSString *paraString in [linkPathLastString componentsSeparatedByString:@"&"]) {
            [keyArray addObject:[paraString componentsSeparatedByString:@"="].firstObject];
            [ValueArray addObject:[paraString componentsSeparatedByString:@"="].lastObject];
        }
        _parameter = [NSDictionary dictionaryWithObjects:ValueArray forKeys:keyArray];
    }
}


@end
