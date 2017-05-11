//
//  HxbPickerArea.h
//  hoomxb
//
//  Created by HXB-C on 2017/5/10.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "HxbPickerCofig.h"
NS_ASSUME_NONNULL_BEGIN
@class HxbPickerArea;
@protocol  HxbPickerAreaDelegate<NSObject>

- (void)pickerArea:(HxbPickerArea *)pickerArea province:(NSString *)province city:(NSString *)city area:(NSString *)area;

@end
@interface HxbPickerArea : UIButton

@property(nonatomic, weak)id <HxbPickerAreaDelegate>delegate ;

- (instancetype)initWithDelegate:(nullable id)delegate;

- (void)show;
@end
NS_ASSUME_NONNULL_END
