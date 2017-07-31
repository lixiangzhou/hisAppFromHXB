//
//  HXBBaseView_Button.h
//  hoomxb
//
//  Created by HXB on 2017/7/24.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HXBBaseView_Button : UIButton

///是否裁剪
@property (nonatomic,assign) BOOL isReduce;
@property (nonatomic,copy) NSString *imageName;
@property (nonatomic,copy) NSString *selectImageName;
///对image的大小的调整
@property (nonatomic,assign) CGRect imageRect;
//@property (nonatomic,strong) UIImageView *imageView;
//@property (nonatomic,strong) UIImageView *selectImageView;
@end
