//
//  HXBBaseCollectionView.m
//  hoomxb
//
//  Created by HXB on 2017/4/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseCollectionView.h"

@implementation HXBBaseCollectionView

- (instancetype)initWithFrame:(CGRect)frame andFlouLayoutBLock: (void(^)(UICollectionViewFlowLayout* flowLayout))flowLayout {
    
    UICollectionViewFlowLayout *_flowLayout = [[UICollectionViewFlowLayout alloc]init];
    
    if (flowLayout) {
        flowLayout(_flowLayout);
    }
    if (self = [super initWithFrame:frame collectionViewLayout:_flowLayout]) {
    
    }
    
    return self;
}
@end
