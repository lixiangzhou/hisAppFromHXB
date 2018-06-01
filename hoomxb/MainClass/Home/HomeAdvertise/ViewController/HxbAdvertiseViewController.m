//
//  HxbAdvertiseViewController.m
//  hoomxb
//
//  Created by HXB-C on 2017/4/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbAdvertiseViewController.h"
#import "HXBAdvertiseViewModel.h"
#import <UIImageView+WebCache.h>

@interface HxbAdvertiseViewController ()
@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, weak) UIImageView *imgView;
@property (nonatomic, strong) HXBAdvertiseViewModel *viewModel;
@end

@implementation HxbAdvertiseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    kWeakSelf
    self.viewModel = [[HXBAdvertiseViewModel alloc] initWithBlock:^UIView *{
        return weakSelf.view;
    }];
    
    [self setUI];
    
    [self addTimer];
    
    [self getData];
}

- (void)setUI {
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.view.frame];
    imgView.image = [UIImage getLauchImage];
    [self.view addSubview:imgView];
    self.imgView = imgView;
    
    [self.view addSubview:self.topImageView];
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
    kWeakSelf
    [self.viewModel requestSplashImages:^(NSString *imageUrl) {
        [weakSelf.topImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
    }];
}

- (UIImageView *)topImageView {
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - kScrAdaptationH(120) - HXBBottomAdditionHeight)];
        _topImageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _topImageView;
}

@end
