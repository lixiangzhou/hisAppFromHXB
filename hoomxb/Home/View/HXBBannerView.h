//
//  NYBannerView.h
//  NYBannerView
//
//  Created by 牛严 on 16/7/4.
//
//

#import <UIKit/UIKit.h>
@class BannerModel;

@interface HXBBannerView : UIView
///关于bannersModel array
@property (nonatomic, strong) NSArray<BannerModel *> *bannersModel;

/// 点击banner的回调
- (void)clickBannerImageWithBlock: (void(^)(BannerModel *model))clickBannerImageBlock;

///对于imageView里面的Label frame的设置,(默认位置在左边的底部)
- (void)setUPImageViewTitleWithBlock: (void(^)(UILabel *label))setUPImageViewTitle;
@end
