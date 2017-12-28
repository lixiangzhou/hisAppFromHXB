//
//  AXHNewFeatureCell.m
//  爱心汇
//
//  Created by kys-4 on 15/12/3.
//  Copyright © 2015年 kys-4. All rights reserved.
//

#import "AXHNewFeatureCell.h"



@interface AXHNewFeatureCell ()

@property (nonatomic, weak) UIImageView *imageView;

@end

@implementation AXHNewFeatureCell



- (UIImageView *)imageView
{
    if (_imageView == nil) {
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.backgroundColor = [UIColor whiteColor];
        _imageView = imageV;
        if (HXBIPhoneX) {
            imageV.contentMode = UIViewContentModeScaleAspectFit;
        }
        //注意：要加载到contentView上
        [self.contentView addSubview:imageV];
    }
    return _imageView;
}
//布局子控件的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
    
}
- (void)setImage:(UIImage *)image
{
    _image = image;
    self.imageView.image = image;
}

@end
