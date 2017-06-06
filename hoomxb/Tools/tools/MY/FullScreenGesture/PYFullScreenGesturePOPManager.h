//
//  PYFullScreenGestureManager_Runtime.h
//  hoomxb
//
//  Created by HXB on 2017/5/26.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    PYFullScreenGestureManager_TransitionanimationType_Runtime,
    PYFullScreenGestureManager_TransitionanimationType_Custom
} PYFullScreenGestureManager_TransitionanimationType;


/**全屏 pop 的工具类*/
@interface PYFullScreenGesturePOPManager : NSObject
/// 自定转场动画 实现的全屏手势
- (instancetype)initWithViewController:(UINavigationController <UIGestureRecognizerDelegate> *)navigationController andTransitionanimationType: (PYFullScreenGestureManager_TransitionanimationType) type;
@end
