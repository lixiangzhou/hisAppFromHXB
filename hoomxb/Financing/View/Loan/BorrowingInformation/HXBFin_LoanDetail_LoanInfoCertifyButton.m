//
//  HXBFin_LoanDetail_LoanInfoCertifyButton.m
//  hoomxb
//
//  Created by HXB on 2017/7/19.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBFin_LoanDetail_LoanInfoCertifyButton.h"
#import <objc/runtime.h>
@interface HXBFin_LoanDetail_LoanInfoCertifyButton ()
@property (nonatomic,strong) UIImageView *imageViewCustem;
@property (nonatomic,strong) UIImage *image;
@property (nonatomic,strong) UIImage *selectedImage;
@end
@implementation HXBFin_LoanDetail_LoanInfoCertifyButton



- (UIImageView *)imageViewCustem {
    if (!_imageViewCustem) {
        _imageViewCustem = [[UIImageView alloc]init];
    }
    return _imageViewCustem;
}
- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    self.image = [UIImage imageNamed:imageName];
    self.imageViewCustem.image = self.image;
}
- (void)setSelectedImageName:(NSString *)selectedImageName {
    _selectedImageName = selectedImageName;
    self.selectedImage = [UIImage imageNamed:selectedImageName];
}



+ (void)load {
    [super load];
    
}

@end
