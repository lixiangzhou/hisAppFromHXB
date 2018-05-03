//
//  HXBCommonResultController.h
//  hoomxb
//
//  Created by lxz on 2018/4/26.
//  Copyright © 2018年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewController.h"

@class HXBCommonResultController;

@interface HXBCommonResultContentModel : NSObject
/// 图片名
@property (nonatomic, copy) NSString *imageName;
/// 大号标题
@property (nonatomic, copy) NSString *titleString;

/// 小字号描述
@property (nonatomic, copy) NSString *descString;
/// 小字号描述的位置，居中或考左边，默认居中
@property (nonatomic, assign) NSTextAlignment descAlignment;
/// 小字号描述 是否有左边的 ！图标，默认没有
@property (nonatomic, assign) BOOL descHasMark;

/// 第一个按钮的Title
@property (nonatomic, copy) NSString *firstBtnTitle;
/// 第一个按钮的回调
@property (nonatomic, copy) void (^firstBtnBlock)(HXBCommonResultController *resultController);

/// note: 第二个按钮若设置了Title就显示，否则不显示

/// 第二个按钮的Title
@property (nonatomic, copy) NSString *secondBtnTitle;
/// 第二个按钮的回调
@property (nonatomic, copy) void (^secondBtnBlock)(HXBCommonResultController *resultController);

/// 导航栏返回的回调，按照需要提供，提供就执行
@property (nonatomic, copy) void (^navBackBlock)(HXBCommonResultController *resultController);

/// 最常用的初始化方法
- (instancetype)initWithImageName:(NSString *)imageName
                      titleString:(NSString *)titleString
                       descString:(NSString *)descString
                    firstBtnTitle:(NSString *)firstBtnTitle;


@end

@interface HXBCommonResultController : HXBBaseViewController
/// 内容模型，必须传
@property (nonatomic, strong) HXBCommonResultContentModel *contentModel;
@end
