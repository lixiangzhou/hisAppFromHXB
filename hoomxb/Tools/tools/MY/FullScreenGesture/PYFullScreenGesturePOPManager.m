//
//  PYFullScreenGestureManager_Runtime.m
//  hoomxb
//
//  Created by HXB on 2017/5/26.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "PYFullScreenGesturePOPManager.h"
#import "PYFullScreenGesturePOPAnimationManager.h"

@interface PYFullScreenGesturePOPManager ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>
@property (nonatomic,strong) UINavigationController *navigationContrller;

@property (nonatomic,strong) UIPercentDrivenInteractiveTransition *interactivePopTransition;
@property (nonatomic,strong) UIGestureRecognizer *gesture;
@property (nonatomic,strong) UIPanGestureRecognizer *popRecognizer;
@end


@implementation PYFullScreenGesturePOPManager

- (instancetype)initWithViewController:(UINavigationController <UIGestureRecognizerDelegate> *)navigationController andTransitionanimationType: (PYFullScreenGestureManager_TransitionanimationType) type
{
    self = [super init];
    if (self) {
        self.navigationContrller = navigationController;
        self.navigationContrller.delegate = self;
        
        UIGestureRecognizer *gesture = navigationController.interactivePopGestureRecognizer;
        gesture.enabled = NO;
        UIView *gestureView = gesture.view;
        
        UIPanGestureRecognizer *popRecognizer = [[UIPanGestureRecognizer alloc] init];
        popRecognizer.delegate = navigationController;
        
        popRecognizer.maximumNumberOfTouches = 1;
        [gestureView addGestureRecognizer:popRecognizer];
        
        self.gesture = gesture;
        self.popRecognizer = popRecognizer;
        
        switch (type) {
            case PYFullScreenGestureManager_TransitionanimationType_Custom:
                [self fullScreenGestureWithFullScreenGesture_Transitionanimation_custom];
                break;
            case PYFullScreenGestureManager_TransitionanimationType_Runtime:
                [self fullScreenGestureWithFullScreenGesture_Transitionanimation_Runtime];
                break;
        }
    }
    return self;
}

#pragma mark - runtime全屏手势
- (void) fullScreenGestureWithFullScreenGesture_Transitionanimation_Runtime {
    ///获取系统手势的target数组
    NSMutableArray *_targets = [self.gesture valueForKey:@"_targets"];
    
    ////获取它的唯一对象，我们知道它是一个叫UIGestureRecognizerTarget的私有类，它有一个属性叫_target
    id gestureRecognizerTarget = [_targets firstObject];
    
    ///获取_target:_UINavigationInteractiveTransition，它有一个方法叫handleNavigationTransition:
    id navigationInteractiveTransition = [gestureRecognizerTarget valueForKey:@"_target"];
    
    ///通过前面的打印，我们从控制台获取出来它的方法签名。
    SEL handleTransition = NSSelectorFromString(@"handleNavigationTransition:");
    
    ///创建一个与系统一模一样的手势，我们只把它的类改为UIPanGestureRecognizer
    [self.popRecognizer addTarget:navigationInteractiveTransition action:handleTransition];
}


#pragma mark - 自定义专场动画
- (void) fullScreenGestureWithFullScreenGesture_Transitionanimation_custom {
    [self.popRecognizer addTarget:self action:@selector(handleControllerPop:)];
}

/**
 *  我们把用户的每次Pan手势操作作为一次pop动画的执行
 */
- (void)handleControllerPop:(UIPanGestureRecognizer *)recognizer {
    //
    CGFloat contentOffsetX = [recognizer translationInView:recognizer.view].x;
    /**
     *  interactivePopTransition就是我们说的方法2返回的对象，我们需要更新它的进度来控制Pop动画的流程，我们用手指在视图中的位置与视图宽度比例作为它的进度。
     */
    CGFloat progress = contentOffsetX / recognizer.view.bounds.size.width;
    /**
     *  稳定进度区间，让它在0.0（未完成）～1.0（已完成）之间
     */
    progress = MIN(1.0, MAX(0.0, progress));
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        /**
         *  手势开始，新建一个监控对象
         */
        self.interactivePopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        /**
         *  告诉控制器开始执行pop的动画
         */
         [self.navigationContrller popViewControllerAnimated:YES];
    }
    else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        /**
         *  更新手势的完成进度
         */
        [self.interactivePopTransition updateInteractiveTransition:progress];
    }
    else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
       
        /**
         *  手势结束时如果进度大于一半，那么就完成pop操作，否则重新来过。
         */
        if (progress > 0.5) {
            [self.interactivePopTransition finishInteractiveTransition];
        }
        else {
            [self.interactivePopTransition cancelInteractiveTransition];
        }
        
        self.interactivePopTransition = nil;
    }
    
}

- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                  animationControllerForOperation:(UINavigationControllerOperation)operation
                                               fromViewController:(UIViewController *)fromVC
                                                 toViewController:(UIViewController *)toVC {
    /**
     *  方法1中判断如果当前执行的是Pop操作，就返回我们自定义的Pop动画对象。
     */
    if (operation == UINavigationControllerOperationPop)
        return [[PYFullScreenGesturePOPAnimationManager alloc] init];
    
    return nil;
}

- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                         interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    
    /**
     *  方法2会传给你当前的动画对象animationController，判断如果是我们自定义的Pop动画对象，那么就返回interactivePopTransition来监控动画完成度。
     */
    if ([animationController isKindOfClass:[PYFullScreenGesturePOPAnimationManager class]])
        return self.interactivePopTransition;
    
    return nil;
}
@end
