//
//  HXBNoDataView.h
//  hoomxb
//
//  Created by HXB on 2017/7/14.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickBtn)(void);
@interface HXBNoDataView : UIView
@property (nonatomic,copy) NSString *imageName;
@property (nonatomic,copy) NSString *noDataMassage;
@property (nonatomic,copy) NSString *downPULLMassage;
@property (nonatomic, copy) clickBtn clickBlock;

@end
