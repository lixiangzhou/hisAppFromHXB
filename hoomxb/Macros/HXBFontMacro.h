//
//  HSGlobal.h
//  TR7TreesV3
//
//  Created by hoomsun on 16/6/14.
//  Copyright © 2016年 hoomsun. All rights reserved.
//



#ifndef Archive_CESGlobal_h
#define Archive_CESGlobal_h

#pragma mark - Font Value

//当前使用的字体自适应
#define kHXBFont_PINGFANGSC_REGULAR(s)            ([UIFont fontWithName:@"HelveticaNeue" size:kScrAdaptationW(s)])
#define kHXBFont_PINGFANGSC_REGULAR_750(s)        ([UIFont fontWithName:@"HelveticaNeue" size:kScrAdaptationW750(s)])

//UI规范中的字体
#define kHXBFont_20         kHXBFont_PINGFANGSC_REGULAR_750(20)
#define kHXBFont_24         kHXBFont_PINGFANGSC_REGULAR_750(24)
#define kHXBFont_26         kHXBFont_PINGFANGSC_REGULAR_750(26)
#define kHXBFont_28         kHXBFont_PINGFANGSC_REGULAR_750(28)
#define kHXBFont_30         kHXBFont_PINGFANGSC_REGULAR_750(30)
#define kHXBFont_32         kHXBFont_PINGFANGSC_REGULAR_750(32)
#define kHXBFont_34         kHXBFont_PINGFANGSC_REGULAR_750(34)
#define kHXBFont_36         kHXBFont_PINGFANGSC_REGULAR_750(36)
#define kHXBFont_38         kHXBFont_PINGFANGSC_REGULAR_750(38)
#define kHXBFont_48         kHXBFont_PINGFANGSC_REGULAR_750(48)
#define kHXBFont_80         kHXBFont_PINGFANGSC_REGULAR_750(80)












/*************************一下为不再使用字体，但旧代码中存在********************************/
// hxb 专用字体
#define HXB_Text_Font(s)                    [UIFont fontWithName:@"DINMittelschrift LT Alternate" size:(s)]
#define HXB_DetailText_Font(s)              [UIFont systemFontOfSize:(s)]
#define HXB_New_BoldFont(s)                 [UIFont fontWithName:@"DINMittelschrift LT Alternate" size:(s)]

//纯黑字体
#define BIG_TEXT_FONT(s)                       ([UIFont fontWithName:@"Helvetica" size:s])  //大

//pingfang light
#define PINGFANG_LIGHT(s)           ([UIFont fontWithName:@"PingFangSC-Light" size:s])

#define PINGFANG_Thin(s)            ([UIFont fontWithName:@"PingFangSC-Thin" size:s])

#define PINGFANG_Medium(s)          ([UIFont fontWithName:@"PingFangSC-Medium" size:s])

#define PINGFANG_Semibold(s)        ([UIFont fontWithName:@"PingFangSC-Semibold" size:s])

#define PINGFANG_SC_LIGHT(s)        ([UIFont fontWithName:@".PingFang-SC-Light" size:s])


#endif

