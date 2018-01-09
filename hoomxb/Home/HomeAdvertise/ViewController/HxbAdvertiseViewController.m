//
//  HxbAdvertiseViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/4/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbAdvertiseViewController.h"

#import <UIImageView+WebCache.h>

@interface HxbAdvertiseViewController ()
@property (nonatomic, weak) UIImageView *imgView;
@end

@implementation HxbAdvertiseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUI];
    
    [self addTimer];
    
    [self getData];
}

- (void)setUI {
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.view.frame];
    imgView.image = [UIImage getLauchImage];
    [self.view addSubview:imgView];
    self.imgView = imgView;
}

- (void)addTimer {
    // 3 秒后消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (self.dismissBlock) {
            self.dismissBlock();
        }
    });
}

- (void)getData {
    // 无论沙盒中是否存在广告图片，都需要重新调用广告接口，判断广告是否更新
    NYBaseRequest *splashTRequest = [[NYBaseRequest alloc] init];
    splashTRequest.requestUrl = kHXBSplash;
    splashTRequest.requestMethod = NYRequestMethodGet;
    
    [splashTRequest startWithSuccess:^(NYBaseRequest *request, id responseObject) {
        NSInteger status =  [responseObject[kResponseStatus] integerValue];
        if (status == 0) {
            NSString *imageURL = responseObject[kResponseData][@"url"];
            [self.imgView sd_setImageWithURL:[NSURL URLWithString:imageURL] placeholderImage:[UIImage getLauchImage]];
        }
    } failure:^(NYBaseRequest *request, NSError *error) {
        
    }];
}

@end
