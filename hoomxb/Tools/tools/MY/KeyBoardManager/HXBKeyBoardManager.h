//
//  HXBKeyBoardManager.h
//  hoomxb
//
//  Created by HXB on 2017/6/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
/*
 UIKeyboardFrameBeginUserInfoKey = NSRect: {{0, 667}, {375, 216}};
 UIKeyboardCenterEndUserInfoKey = NSPoint: {187.5, 775};
 UIKeyboardBoundsUserInfoKey = NSRect: {{0, 0}, {375, 216}};
 UIKeyboardFrameEndUserInfoKey = NSRect: {{0, 667}, {375, 216}};
 UIKeyboardAnimationDurationUserInfoKey = 0.25;
 UIKeyboardCenterBeginUserInfoKey = NSPoint: {187.5, 775};
 UIKeyboardAnimationCurveUserInfoKey = 7;
 UIKeyboardIsLocalUserInfoKey = 1;
 */
@interface HXBKeyBoardManager : NSObject


//load中调用
- (void)registerKeyboardEventWithandKeyboardWillShowBlock:(void(^)(NSInteger keyBordH, CGFloat Duration, NSDictionary * keyBordInfo))KeyboardWillShowBlock
                               andKeyboardWillHiddenBlock:(void(^)())KeyboardWillHiddenBlock;
//unload中调用
- (void)unregisterKeyboardEvent;
@end
