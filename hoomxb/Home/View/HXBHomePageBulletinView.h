//
//  HXBHomePageBulletinView.h
//  HongXiaoBao
//
//  Created by 牛严 on 16/7/8.
//  Copyright © 2016年 hongxb. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HXBHomePageBulletinViewDelegate <NSObject>

@optional

- (void)closeButtonView;

@end

@interface HXBHomePageBulletinView : UIView

@property (nonatomic, strong) NSArray *bulletinsModel;

@property (nonatomic, weak) id <HXBHomePageBulletinViewDelegate> delegete;

@end
