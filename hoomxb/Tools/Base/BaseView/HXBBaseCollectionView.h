//
//  HXBBaseCollectionView.h
//  hoomxb
//
//  Created by HXB on 2017/4/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBBaseCollectionView : UICollectionView
- (instancetype)initWithFrame:(CGRect)frame andFlouLayoutBLock: (void(^)(UICollectionViewFlowLayout* flowLayout))flowLayout;
@end
