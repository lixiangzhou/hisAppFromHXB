//
//  HXBHomePopView.m
//  hoomxb
//
//  Created by hxb on 2017/12/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBHomePopView.h"

// 角度转弧度
#define DEGREES_TO_RADIANS(angle) ((angle) / 180.0 * M_PI)

@interface HXBHomePopView ()<UIGestureRecognizerDelegate>
/** 内容视图 */
@property (nonatomic, strong) UIView *contentView;
/** 背景层 */
@property (nonatomic, strong) UIView *backgroundView;
/** 自定义视图 */
@property (nonatomic, strong) UIView *customView;
/** 关闭按钮 */
@property (nonatomic, strong) UIButton *closeBtn;
/** 显示时背景是否透明，透明度是否为<= 0，默认为NO */
@property (nonatomic) BOOL isTransparent;

@end

@implementation HXBHomePopView

+ (instancetype)sharedManager {
    
    static HXBHomePopView *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    
    return _sharedManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        
        _isClickBGDismiss = NO;
        _popBGAlpha = 0.5f;
        _isTransparent = NO;
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        [self addSubview:self.backgroundView];
        [self addSubview:self.contentView];
    }
    return self;
}

- (void)clickCloseBtn:(UIButton *)sender{
    if (self.closeActionBlock) {
        self.closeActionBlock();
    }
}

- (void)clickImage:(UITapGestureRecognizer *)tap{
    __weak typeof(self) ws = self;
    if (ws.clickImageBlock) {
        ws.clickImageBlock();
    }
}

- (void)setPopBGAlpha:(CGFloat)popBGAlpha
{
    _popBGAlpha = (popBGAlpha <= 0.0f) ? 0.0f : ((popBGAlpha > 1.0) ? 1.0 : popBGAlpha);
    _isTransparent = (_popBGAlpha == 0.0f);
}

#pragma mark 点击背景(Click background)
- (void)tapBGLayer:(UITapGestureRecognizer *)tap
{
    if (_isClickBGDismiss) {
        if (self.clickBgmDismissCompleteBlock) {
            self.clickBgmDismissCompleteBlock();
        }
    }
}

#pragma mark UIGestureRecognizer Delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    CGPoint location = [touch locationInView:_contentView];
    location = [_customView.layer convertPoint:location fromLayer:_contentView.layer];
    return ![_customView.layer containsPoint:location];
}

- (void)pop
{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
    __weak typeof(self) ws = self;
    NSTimeInterval duration = 0.2;
    self.alpha = 0.0;
    if (self.isTransparent) {
        self.backgroundView.backgroundColor = [UIColor clearColor];
    } else {
        self.backgroundView.alpha = 0.0;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (ws.popCompleteBlock) {
            
            ws.alpha = 1.0;
            if (!ws.isTransparent) {
                ws.backgroundView.alpha = ws.popBGAlpha;
            }
            
            ws.popCompleteBlock();
        }
    });
}

- (void)dismiss
{
    __weak typeof(self) ws = self;
    NSTimeInterval duration = 0.2;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (ws.dismissCompleteBlock) {
            ws.alpha = 0.0;
            ws.backgroundView.alpha = 0.0;
            
            ws.dismissCompleteBlock();
        }
        [ws removeFromSuperview];
    });
}

- (UIView *)backgroundView{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = 0.0f;
    }
    return _backgroundView;
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:self.bounds];
        _contentView.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBGLayer:)];
        tap.delegate = self;
        [_contentView addGestureRecognizer:tap];
        [_contentView addSubview:self.customView];
        [_contentView addSubview:self.closeBtn];
    }
    return _contentView;
}

- (UIView *)customView{
    if (!_customView) {
        _customView = [[UIView alloc]initWithFrame:CGRectMake(kScrAdaptationW(55), kScrAdaptationH(156), kScrAdaptationW(266), kScrAdaptationH(356))];//417
        [_customView addSubview:self.imgView];
//        [_customView addSubview:self.closeBtn];
    }
    return _customView;
}

-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScrAdaptationW(0), kScrAdaptationH(0), kScrAdaptationW(266), kScrAdaptationH(356))];
        _imgView.userInteractionEnabled = YES;
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        _imgView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _imgView.layer.cornerRadius = 4;
        _imgView.layer.masksToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage:)];
        [_imgView addGestureRecognizer:tap];
    }
    return _imgView;
}

- (UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeBtn.frame = CGRectMake(kScrAdaptationW(173), kScrAdaptationH(542), kScrAdaptationW(30), kScrAdaptationH(31));
        [_closeBtn setBackgroundImage:[UIImage imageNamed:@"homePopViewClose"] forState:UIControlStateNormal];
        [_closeBtn addTarget: self action:@selector(clickCloseBtn:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

@end
