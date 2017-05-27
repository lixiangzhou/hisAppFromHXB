//
//  PYFullScreenGestureAnimationManager.m
//  hoomxb
//
//  Created by HXB on 2017/5/26.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "PYFullScreenGesturePOPAnimationManager.h"

@interface PYFullScreenGesturePOPAnimationManager ()
@property (nonatomic,strong) id <UIViewControllerContextTransitioning>transitionContext;

@end

@implementation PYFullScreenGesturePOPAnimationManager


- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext {
    //这个方法返回动画执行的时间 时间不能太长，会产生很多问题
    return 0.01;
}

/**
 *  transitionContext你可以看作是一个工具，用来获取一系列动画执行相关的对象，并且通知系统动画是否完成等功能。
 */
- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext {
    ///获取从哪里来
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    ///获取转场到哪里去
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIView* toView = nil;
    UIView* fromView = nil;
    
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];///获取从哪里来的View
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];///获取到哪里去的View
    } else {
        fromView = fromViewController.view;
        toView = toViewController.view;
    }
    
    //将toView加到fromView的下面，非常重要！！！
    [[transitionContext containerView] insertSubview:toView belowSubview:fromView];
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    fromView.frame = CGRectMake(0, 0, width, height);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromView.frame = CGRectMake(width, 0, width, height);
    } completion:^(BOOL finished) {
        
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
//    //----------------pop动画一-------------------------//
//    /*
//     [UIView beginAnimations:@"View Flip" context:nil];
//     [UIView setAnimationDuration:duration];
//     [UIView setAnimationDelegate:self];
//     [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:containerView cache:YES];
//     [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
//     [UIView commitAnimations];//提交UIView动画
//     [containerView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
//     */
//    //----------------pop动画二-------------------------//
//    /*
//     CATransition *tr = [CATransition animation];
//     tr.type = @"cube";
//     tr.subtype = @"fromLeft";
//     tr.duration = duration;
//     tr.removedOnCompletion = NO;
//     tr.fillMode = kCAFillModeForwards;
//     tr.delegate = self;
//     [containerView.layer addAnimation:tr forKey:nil];
//     [containerView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
//     */
}

- (void)animationDidStop:(CATransition *)anim finished:(BOOL)flag {
    [_transitionContext completeTransition:!_transitionContext.transitionWasCancelled];
}

@end
