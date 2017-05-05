//
//  HxbSignInView.h
//  hoomxb
//
//  Created by HXB-C on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SignViewDelegate <NSObject>
- (void)didClickSignInBtn;
- (void)didClicksignUpBtn;
@end

@interface HxbSignInView : UIView
@property (nonatomic, weak, nullable) id<SignViewDelegate> delegate;
@end
