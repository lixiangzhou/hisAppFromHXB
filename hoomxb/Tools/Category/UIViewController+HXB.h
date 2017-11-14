//
//  UIViewController+HXB.h
//  hoomxb
//
//  Created by lxz on 2017/11/14.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HXB)

- (void)showNoDataViewWithImgName:(NSString *)imgName
                    noDataMassage:(NSString *)noDataMassage
                  downPullMassage:(NSString *)downPullMassage
                           inView:(UIView *)view
                remakeConstraints:(void(^)(MASConstraintMaker *))remakeConstraints
@end
