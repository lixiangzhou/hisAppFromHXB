//
//  HXBScreenAdaptation.h
//  hoomxb
//
//  Created by HXB on 2017/5/5.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#ifndef HXBScreenAdaptation_h
#define HXBScreenAdaptation_h


//关于__weak 修饰的self, 用于block内部
#define kWeakSelf __weak typeof(self) weakSelf = self;
//MAKR: - 屏幕适配
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)

#define kScreenAdaptation_Height_7 [HXBThemAdapterManager getAdaterScreenHeightScale]
#define kScreenAdaptation_Width_7 (kScreenWidth/375.0)

//#define kScreenAdaptation_Width_7P (kScreenHeight/736.0)
//#define kScreenAdaptation_Height_7P (kScreenWidth/414.0)


//所有的都用这个，如果改就直接改成7p或者添加别的
#define kScreenAdaptation_Height kScreenAdaptation_Height_7
#define kScreenAdaptation_Width kScreenAdaptation_Width_7

//MARK: 计算好的尺寸比例
///计算比例后的高度
#define kScrAdaptationH(H) ((H) * kScreenAdaptation_Height)
///计算比例后的宽度
#define kScrAdaptationW(W) ((W) * kScreenAdaptation_Width)


//MARK: 计算好的尺寸比例
///计算比例后的高度
#define kScrAdaptationH750(H) ((H) * kScreenAdaptation_Height * 0.5)
///计算比例后的宽度
#define kScrAdaptationW750(W) ((W) * kScreenAdaptation_Width * 0.5)

#define kVCViewFrame_64 CGRectMake(0, 64, kScreenWidth, kScreenHeight-64)
#endif /* HXBScreenAdaptation_h */
