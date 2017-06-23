//
//  HXBBaseView_HaveLable_LeftRight_View.h
//  hoomxb
//
//  Created by HXB on 2017/6/22.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HXBBaseView_TwoLable_View_ViewModel;
@interface HXBBaseView_TwoLable_View : UIView
///赋值的viewModel

- (void) setUP_TwoViewVMFunc: (HXBBaseView_TwoLable_View_ViewModel *(^)(HXBBaseView_TwoLable_View_ViewModel *viewModelVM))setUP_ToViewViewVMBlock;
@end
@interface HXBBaseView_TwoLable_View_ViewModel : NSObject
@property (nonatomic,assign) BOOL               isLeftRight;
@property (nonatomic,copy) NSString *           leftLabelStr;
@property (nonatomic,copy) NSString *           rightLabelStr;
@property (nonatomic,assign) NSTextAlignment    leftLabelAlignment;
@property (nonatomic,assign) NSTextAlignment    rightLabelAlignment;
@end
