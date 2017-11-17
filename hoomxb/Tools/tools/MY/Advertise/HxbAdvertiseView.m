//
//  HxbAdvertiseView.m
//  hoomxb
//
//  Created by HXB-C on 2017/4/18.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HxbAdvertiseView.h"
@interface HxbAdvertiseView()

@property (nonatomic, strong) UIImageView *adView;

@property (nonatomic, strong) UIButton *countBtn;

@property (nonatomic, strong) NSTimer *countTimer;

@property (nonatomic,copy) void(^clickAdvertiseViewBlock )();
@property (nonatomic, assign) int count;

@property (nonatomic,copy) void(^clickSkipButtonBlock)();
@end
@implementation HxbAdvertiseView

// 广告显示的时间
static int const showtime = 3;

- (NSTimer *)countTimer
{
    if (!_countTimer) {
        _countTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(countDown) userInfo:nil repeats:YES];
    }
    return _countTimer;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        // 1.广告图片
        _adView = [[UIImageView alloc] initWithFrame:frame];
        _adView.userInteractionEnabled = YES;
        _adView.contentMode = UIViewContentModeScaleAspectFill;
        _adView.clipsToBounds = YES;
        [self addSubview:_adView];
        //打开闪屏页面点击方法
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(pushToAd)];
//        [_adView addGestureRecognizer:tap];
        
        // 2.跳过按钮（打开下面注释就能展示跳过按钮）
//        CGFloat btnW = 60;
//        CGFloat btnH = 30;
//        _countBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - btnW - 24, btnH, btnW, btnH)];
//        [_countBtn addTarget:self action:@selector(clickSkipButton) forControlEvents:UIControlEventTouchUpInside];
//        [_countBtn setTitle:[NSString stringWithFormat:@"跳过%d", showtime] forState:UIControlStateNormal];
//        _countBtn.titleLabel.font = [UIFont systemFontOfSize:15];
//        [_countBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        _countBtn.backgroundColor = [UIColor colorWithRed:38 /255.0 green:38 /255.0 blue:38 /255.0 alpha:0.6];
//        _countBtn.layer.cornerRadius = 4;
//        [self addSubview:_countBtn];
        
    }
    return self;
}

// 移除广告页面
- (void)dismiss
{
    [self.countTimer invalidate];
    self.countTimer = nil;
    
    [UIView animateWithDuration:0.3f animations:^{
        
        self.alpha = 0.f;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
    }];
    
}


// 点击了跳过按钮
- (void)clickSkipButton {
    if (self.clickSkipButtonBlock) {
        self.clickSkipButtonBlock();
    }
    [self dismiss];
}

/** 点击了广告页面 显示广告*/
- (void)showAdvertiseWebViewWithBlock: (void(^)())clickAdvertiseViewBlock {
    self.clickAdvertiseViewBlock = clickAdvertiseViewBlock;
}


- (void)clickSkipButtonFuncWithBlock: (void(^)())clickSkipButtonBlock {
    self.clickSkipButtonBlock = clickSkipButtonBlock;
}


- (void)pushToAd{
    
    [self dismiss];
    
    if (self.clickAdvertiseViewBlock) {
        self.clickAdvertiseViewBlock();
    }
}


- (void)setFilePath:(NSString *)filePath
{
    _filePath = filePath;
    _adView.image = [UIImage imageWithContentsOfFile:filePath];
}
- (void)setAdvertiseImage:(UIImage *)advertiseImage {
    _advertiseImage = advertiseImage;
    _adView.image = _advertiseImage;
}



- (void)countDown
{
    _count --;
    [_countBtn setTitle:[NSString stringWithFormat:@"跳过%d",_count] forState:UIControlStateNormal];
    if (_count <= 0) {
        if (self.clickSkipButtonBlock) {
            self.clickSkipButtonBlock();
        }
        [self dismiss];
    }
}

- (void)show
{
    // 倒计时方法1：GCD
    //    [self startCoundown];
    
    // 倒计时方法2：定时器
    [self startTimer];
}

// 定时器倒计时
- (void)startTimer
{
    _count = showtime;
    [[NSRunLoop mainRunLoop] addTimer:self.countTimer forMode:NSRunLoopCommonModes];
}



// GCD倒计时
- (void)startCoundown
{
    __block int timeout = showtime + 1; //倒计时时间 + 1
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0 * NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout <= 0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self dismiss];
                
            });
        }else{
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [_countBtn setTitle:[NSString stringWithFormat:@"跳过%d",timeout] forState:UIControlStateNormal];
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}



@end
