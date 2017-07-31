//
//  HXBBaseView_Button.m
//  hoomxb
//
//  Created by HXB on 2017/7/24.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseView_Button.h"
@interface HXBBaseView_Button ()
@property (nonatomic,strong) UIImageView *hxb_imageView;
@property (nonatomic,strong) UIImageView *hxb_imageView_Selected;

@end
@implementation HXBBaseView_Button

/**
 hxb_imageView
 */
- (UIImageView *) hxb_imageView {
    if (!_hxb_imageView) {
        _hxb_imageView = [[UIImageView alloc] init];
        [self addSubview:_hxb_imageView];
    }
    return _hxb_imageView;
}
/**
 hxb_imageView_Selected
 */
- (UIImageView *) hxb_imageView_Selected {
    if (!_hxb_imageView_Selected) {
        _hxb_imageView_Selected = [[UIImageView alloc] init];
        [self addSubview:_hxb_imageView_Selected];
    }
    return _hxb_imageView_Selected;
}
- (void)setImageName:(NSString *)imageName {
    _imageName = imageName;
    self.hxb_imageView.image = [UIImage imageNamed:imageName];
}
- (void)setSelectImageName:(NSString *)selectImageName {
    _selectImageName = selectImageName;
    self.hxb_imageView_Selected.image = [UIImage imageNamed:selectImageName];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat X, W;
    CGFloat titleX,titleY,titleW,titleH,centerY;
 
    
    titleX = self.titleLabel.frame.origin.x;
    titleY = self.titleLabel.frame.origin.y;
    titleW = self.titleLabel.frame.size.width;
    titleH = self.titleLabel.frame.size.height;
    centerY = self.bounds.size.height / 2;
    
    X = self.imageRect.origin.x;
    W = self.imageRect.size.width;
    
    
    self.hxb_imageView.center = CGPointMake(_imageRect.origin.x + _imageRect.size.width/2, centerY);
    self.hxb_imageView.bounds = CGRectMake(0, 0, _imageRect.size.width, _imageRect.size.height);
    self.hxb_imageView_Selected.center = CGPointMake(_imageRect.origin.x + _imageRect.size.width/2, centerY);
    self.hxb_imageView_Selected.bounds = CGRectMake(0, 0, _imageRect.size.width, _imageRect.size.height);
    
    self.titleLabel.frame = CGRectMake(titleX + X + W, titleY, titleW, titleH);
    self.selected = false;
    self.isReduce = self.isReduce;
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = object_getClass((id)self);
        
        SEL originalSelector = @selector(setSelected:);
        SEL swizzledSelector = @selector(hxb_setSelected:);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        BOOL didAddMethod =
        class_addMethod(class,
                        originalSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod));
        
        if (didAddMethod) {
            class_replaceMethod(class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)hxb_setSelected:(BOOL)selected {
    [self hxb_setSelected:selected];
    self.hxb_imageView_Selected.hidden = self.selected;
    self.hxb_imageView.hidden = !self.selected;
}

-(void)setIsReduce:(BOOL)isReduce {
    _isReduce = isReduce;
    if (isReduce) {
        self.hxb_imageView.layer.cornerRadius = self.hxb_imageView.frame.size.height/2.0;
        self.hxb_imageView.layer.masksToBounds = true;
        self.hxb_imageView_Selected.layer.cornerRadius = self.hxb_imageView.frame.size.height/2.0;
        self.hxb_imageView_Selected.layer.masksToBounds = true;
    }
}

@end
