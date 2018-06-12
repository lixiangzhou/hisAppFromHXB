//
//  HXBHomePopVWModel.h
//  hoomxb
//
//  Created by hxb on 2017/12/13.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HXBHomePopVWModel : NSObject

@property (nonatomic, copy) NSString *title;//弹窗名称
@property (nonatomic, copy) NSString *image;//图片链接地址
@property (nonatomic, copy) NSString *ID;//弹窗唯一标识ID
@property (nonatomic, assign) long long createTime;//弹窗创建时间
@property (nonatomic, assign) long long updateTime;//弹窗数据更新时间
@property (nonatomic, copy) NSString *type;//弹窗打开页面类型：native：app原生页面, h5：h5页面, broswer:页面在app打不开时，app用外部浏览器打开
@property (nonatomic, copy) NSString *url;//弹窗跳转链接地址，不区分类型，可以是H5页面，也可以是原生页面
@property (nonatomic, copy) NSString *frequency;//弹窗展现频率。everyday:每天仅一次 ; everytime: 有效期内每次都展示；once: 只展示一次

@end
