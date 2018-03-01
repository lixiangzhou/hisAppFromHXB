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

/**
 点击banner的回调
 */
@property (nonatomic, copy) void (^clickBannerImageBlock)(BannerModel *model);


@end
