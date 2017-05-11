//
//  HXBHomePageBulletinView.m
//  HongXiaoBao
//
//  Created by 牛严 on 16/7/8.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#import "HXBHomePageBulletinView.h"
#import "HxbHomeViewController.h"

#import "BulletinsModel.h"

@interface HXBHomePageBulletinView ()

@property (nonatomic, strong) UIImageView *trumpetView;

@property (nonatomic, strong) UIScrollView *contentScrollView;

@property (nonatomic, strong) UIButton *closeButton;

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation HXBHomePageBulletinView
{
    CGFloat _scrollTop;
    CGFloat _viewHeight;
    CGFloat _contentWidth;
    NSInteger _contentIndex;
    NSInteger _pageIndex;
    
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _scrollTop = 10.0f;
        _viewHeight = self.height;
        _contentWidth = SCREEN_WIDTH - 100;
        _pageIndex = 0;
        self.backgroundColor = RGB(255, 235, 197);
        
        [self addSubview:self.trumpetView];
        [self addSubview:self.closeButton];
        [self addSubview:self.contentScrollView];
    }
    return self;
}

#pragma mark Private Methods
//点击bulletin
- (void)bulletinClick
{
    
    if (_pageIndex > _bulletinsModel.count-1 || !_bulletinsModel ) {
        return;
    }
    DLog(@"点击bulletin--%ld",(long)_pageIndex);
    NSString *urlStr = [((BulletinsModel *)_bulletinsModel[_pageIndex]) linkUrl]? :@"" ;
    if (!urlStr.length) {
        return;
    }
    NSMutableString *finalUrlStr = [[urlStr stringByAppendingFormat:@"?token=%@",[KeyChain token]] mutableCopy];
    id next = [self nextResponder];
    while (![next isKindOfClass:[HxbHomeViewController class]]) {
        next = [next nextResponder];
    }
    if ([next isKindOfClass:[HxbHomeViewController class]]) {
        HxbHomeViewController *vc = (HxbHomeViewController *)next;
//        [vc showBulletinWebViewWithURL:finalUrlStr];
    }
}

- (void)setContentLabel
{
    [self.contentScrollView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    for (NSInteger i = 0; i < self.bulletinsModel.count + 2; i ++)
    {
        UILabel *contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _viewHeight * i, _contentWidth, _viewHeight)];
        contentLabel.font = HXB_Text_Font(SIZ15);
        contentLabel.textColor = COR20;
        contentLabel.userInteractionEnabled = YES;
        [contentLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bulletinClick)]];
        
        
        if (i == 0) {
            NSInteger index = _contentIndex - 1;
            BulletinsModel *model = self.bulletinsModel[index];
            NSString *text = model.content;
            contentLabel.text = ((BulletinsModel *)self.bulletinsModel[_contentIndex - 1]).content;
        }else if (i == _contentIndex + 1){
            contentLabel.text = ((BulletinsModel *)self.bulletinsModel[0]).content;
        }else{
            contentLabel.text = ((BulletinsModel *)self.bulletinsModel[i - 1]).content;
        }
        [self.contentScrollView addSubview:contentLabel];
    }
}

- (void)beginRoll
{
    [self.timer invalidate];
    self.timer = [NSTimer timerWithTimeInterval:4 target:self selector:@selector(changeContentIndex) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)changeContentIndex
{
    [UIView animateWithDuration:0.5f animations:^{
        self.contentScrollView.contentOffset = CGPointMake(0, self.contentScrollView.contentOffset.y + _viewHeight);
    }];
    
    [self updateIndexAndPosition];
}

- (void)updateIndexAndPosition
{
    NSInteger index = (NSInteger)self.contentScrollView.contentOffset.y / _viewHeight;
    
    if (index == 0) {
        _pageIndex = _contentIndex;
    }else if (index == _contentIndex + 1){
        _pageIndex = 0;
    }else{
        _pageIndex = index - 1;
    }
    
    if (index == 0) {
        self.contentScrollView.contentOffset = CGPointMake(0, _contentIndex * _viewHeight);
    }else if (index == _contentIndex + 1){
        self.contentScrollView.contentOffset = CGPointMake(0, _viewHeight);
    }
}

#pragma mark Action Methods
- (void)closeButtonClicked
{
    if ([self.delegete respondsToSelector:@selector(closeButtonView)]) {
        [self.delegete closeButtonView];
    }
}

#pragma mark Set Methods
- (void)setBulletinsModel:(NSArray *)bulletinsModel
{
    _bulletinsModel = bulletinsModel;
    _contentIndex = _bulletinsModel.count;
    self.contentScrollView.contentSize = CGSizeMake(_contentWidth, _viewHeight * (_bulletinsModel.count + 2));
    self.contentScrollView.contentOffset = CGPointMake(0, _viewHeight);
    [self setContentLabel];
    [self beginRoll];
}

#pragma mark Get Methods
- (UIImageView *)trumpetView
{
    if (!_trumpetView) {
        _trumpetView = [[UIImageView alloc]initWithFrame:CGRectMake(14, 12, 14, 16)];
        _trumpetView.center = CGPointMake(_trumpetView.centerX, _viewHeight/2);
        _trumpetView.image = [UIImage imageNamed:@"homepage_trumpet.png"];
    }
    return _trumpetView;
}

- (UIButton *)closeButton
{
    if (!_closeButton) {
        _closeButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 44, 0, 32, HEIGHT(self))];
        [_closeButton setImage:[UIImage imageNamed:@"homepage_close.png"] forState:UIControlStateNormal];
        [_closeButton addTarget:self action:@selector(closeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        
        //        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 1)];
        //        lineView.backgroundColor = RGB(238, 238, 238);
        //        [self addSubview:lineView];
    }
    return _closeButton;
}

- (UIScrollView *)contentScrollView
{
    if (!_contentScrollView) {
        
        _contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(40, 0, _contentWidth, _viewHeight)];
        
        _contentScrollView.userInteractionEnabled = YES;
        _contentScrollView.showsVerticalScrollIndicator = NO;
    }
    return _contentScrollView;
}

@end
