//
//  HXBBaseView_Button.m
//  hoomxb
//
//  Created by HXB on 2017/7/24.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseView_Button.h"
@interface HXBBaseView_Button ()


@end
@implementation HXBBaseView_Button
- (void)setImageName:(NSString *)imageName {
    UIImage *image = [UIImage imageNamed:imageName];
    if (image) {
        [self setImage:image forState:UIControlStateNormal];
        return;
    }
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.svgImageString = imageName;
    [self setImage:imageView.image forState:UIControlStateNormal];
}
- (void)setSelectImageName:(NSString *)selectImageName {
    UIImage *image = [UIImage imageNamed:selectImageName];
    if (image) {
        [self setImage:image forState:UIControlStateSelected];
        return;
    }
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.svgImageString = selectImageName;
    [self setImage:imageView.image forState:UIControlStateSelected];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.center = CGPointMake(kScrAdaptationH(5), self.titleLabel.center.y);
    self.imageView.bounds = CGRectMake(0, 0, kScrAdaptationH(10), kScrAdaptationH(10));
    self.titleLabel.frame = CGRectMake(kScrAdaptationH(10) * 2, 0, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
    self.imageView.layer.borderColor = kHXBColor_Blue040610.CGColor;
    self.imageView.layer.borderWidth = 0.5;
    self.imageView.layer.masksToBounds = true;
    self.imageView.layer.cornerRadius = kScrAdaptationH(10)/2.0;

//    CGFloat X, W;
//    CGFloat titleX,titleY,titleW,titleH,centerY;
// 
//    
//    titleX = self.titleLabel.frame.origin.x;
//    titleY = self.titleLabel.frame.origin.y;
//    titleW = self.titleLabel.frame.size.width;
//    titleH = self.titleLabel.frame.size.height;
//    centerY = self.bounds.size.height / 2;
//    
//    X = self.imageRect.origin.x;
//    W = self.imageRect.size.width;
//    
//    
//    self.hxb_imageView.center = CGPointMake(_imageRect.origin.x + _imageRect.size.width/2, centerY);
//    self.hxb_imageView.bounds = CGRectMake(0, 0, _imageRect.size.width, _imageRect.size.height);
//    self.hxb_imageView_Selected.center = CGPointMake(_imageRect.origin.x + _imageRect.size.width/2, centerY);
//    self.hxb_imageView_Selected.bounds = CGRectMake(0, 0, _imageRect.size.width, _imageRect.size.height);
//    
//    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
//    self.selected = false;
//    self.isReduce = self.isReduce;
}

//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        Class class = object_getClass((id)self);
//        
//        SEL originalSelector = @selector(setSelected:);
//        SEL swizzledSelector = @selector(hxb_setSelected:);
//        
//        Method originalMethod = class_getInstanceMethod(class, originalSelector);
//        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
//        
//        BOOL didAddMethod =
//        class_addMethod(class,
//                        originalSelector,
//                        method_getImplementation(swizzledMethod),
//                        method_getTypeEncoding(swizzledMethod));
//        
//        if (didAddMethod) {
//            class_replaceMethod(class,
//                                swizzledSelector,
//                                method_getImplementation(originalMethod),
//                                method_getTypeEncoding(originalMethod));
//        } else {
//            method_exchangeImplementations(originalMethod, swizzledMethod);
//        }
//    });
//}
//
//- (void)hxb_setSelected:(BOOL)selected {
//    [self hxb_setSelected:selected];
//    self.hxb_imageView_Selected.hidden = self.selected;
//    self.hxb_imageView.hidden = !self.selected;
//}
//
//-(void)setIsReduce:(BOOL)isReduce {
//    _isReduce = isReduce;
//    if (isReduce) {
//        self.hxb_imageView.layer.cornerRadius = self.hxb_imageView.frame.size.height/2.0;
//        self.hxb_imageView.layer.masksToBounds = true;
//        self.hxb_imageView_Selected.layer.cornerRadius = self.hxb_imageView.frame.size.height/2.0;
//        self.hxb_imageView_Selected.layer.masksToBounds = true;
//    }
//}
@end
