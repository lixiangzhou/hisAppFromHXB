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
#import "HXBRootVCManager.h"

@interface HxbAdvertiseViewController ()
@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) HXBAdvertiseViewModel *viewModel;
@property (nonatomic, strong) NSTimer *timer;
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
    
    self.topImageView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:self.topImageView];
}

- (void)getData {
    kWeakSelf
    [self.viewModel requestSplashImages:^(NSString *imageUrl) {
        [weakSelf.topImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
    }];
    
#warning to uncommon
    //    [self.viewModel getSplashImage:^(NSString *imageUrl) {
    //        if (imageUrl) {
    //            [weakSelf.topImageView sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:nil];
    //            [weakSelf addTimer];
    //        } else {
    //            weakSelf.dismissBlock();
    //        }
    //    }];

}

- (void)tapImage {
    [self invalidateTimer];
    [self.view removeFromSuperview];
    
    if ([HXBRootVCManager manager].gesturePwdVC) {
        [[HXBRootVCManager manager] showGesPwd];
        [HXBRootVCManager manager].gesturePwdVC.dismissBlock = ^{
            
        };
    } else {
        
    }
}

- (void)dealloc {
    [self invalidateTimer];
}

- (void)addTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 repeats:NO block:^(NSTimer * _Nonnull timer) {
        [self.view removeFromSuperview];
        if (self.dismissBlock) {
            self.dismissBlock();
        }
    }];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)invalidateTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}


- (UIImageView *)topImageView {
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kScreenH - kScrAdaptationH(120) - HXBBottomAdditionHeight)];
        _topImageView.userInteractionEnabled = YES;
        _topImageView.contentMode = UIViewContentModeScaleAspectFit;
        [_topImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImage)]];
    }
    return _topImageView;
}

@end
