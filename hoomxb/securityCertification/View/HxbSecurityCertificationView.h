//
//  HxbSecurityCertificationView.h
//  hoomxb
//
//  Created by HXB-C on 2017/5/3.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol securityCertificationViewDelegate <NSObject>
- (void)didClickSecurityCertificationButton;
@end

@interface HxbSecurityCertificationView : UIView
@property (nonatomic, weak, nullable) id<securityCertificationViewDelegate> delegate;
@end
