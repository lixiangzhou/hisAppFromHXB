//
//  HxbCategory.h
//  hoomxb
//
//  Created by HXB on 2017/4/13.
//  Copyright © 2017年 李鹏跃. All rights reserved.



// ------------------ readMe --------------------
/*
 * 各种分类
 */


#pragma mark -  ------------UI相关-----------------------
#import "UIViewController+HxbViewController.h"//快速添加到父控件
#import "UIView+HxbView.h"//frame获取及写入，屏幕截图
#import "UITableView+HxbTableView.h"//tableView
#import "UILabel+HxbLabel.h"//label 的快速创建
#import "UIButton+HxbButton.h"//button的快速创建
#import "UIImageView+HxbSDWebImage.h"//对SDWebImage的封装
#import "UIColor+HxbColor.h"// 随机色，rgb，16进制颜色
#import "UIScreen+Hxb.h"//快速获取屏幕的宽，高，分辨率
#import "UIScrollView+HXBScrollView.h"//关于上拉刷新与下拉加载
#import "UITextField+HxbTextField.h" //TextField的自定义
#import "UIView+HXBFrame.h"//关于frame



#pragma mark - -------------NSObjct相关----------------------
#import "NSArray+HxbLog.h"//log 打印中文
#import "NSObject+HxbRunTime.h"//获取对象的属性列表




#pragma mark - -------------NSString 相关-------------------------
#import "NSAttributedString+HxbAttributedString.h"//使用图像和文本生成上下排列的属性文本
/*
 1.计算HMAC MD5散列结果
 2.计算HMAC SHA1散列结果
 3.计算HMAC SHA256散列结果
 4.计算HMAC SHA512散列结果
 5.等。。。。
 */
#import "NSString+HxbHash.h"
#import "NSString+CopiesTransfer.h"//字符串的截取
#import "NSString+HxbPerMilMoney.h"//
#import "NSString+HxbSortDicMD5.h"//MD5
#import "NSString+HxbMask.h"
#import "NSString+HxbGeneral.h"//里面有正则判断手机号
#import "NSString+HXBPhonNumber.h"///隐藏了phonNumber中的中间的字符









