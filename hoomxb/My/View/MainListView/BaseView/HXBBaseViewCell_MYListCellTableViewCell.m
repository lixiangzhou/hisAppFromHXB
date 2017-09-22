//
//  HXBBaseViewCell_MYListCellTableViewCell.m
//  hoomxb
//
//  Created by HXB on 2017/8/7.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBBaseViewCell_MYListCellTableViewCell.h"
@interface HXBBaseViewCell_MYListCellTableViewCell ()
///title 有可能有图片
@property (nonatomic,strong) UIImageView *title_ImageView;
@property (nonatomic,strong) UILabel *title_LeftLabel;
@property (nonatomic,strong) UILabel *title_RightLabel;

@property (nonatomic, weak) UIView *title_RightBGView;
///中间的分割线 rgb：87，87，87，1
@property (nonatomic,strong) UIView *lineview;

/// 底部三层
@property (nonatomic,strong) HXBBaseView_MoreTopBottomView *bottomTopBottomView;

@property (nonatomic,strong) HXBBaseViewCell_MYListCellTableViewCellManager *myListCellManager;
@end
@implementation HXBBaseViewCell_MYListCellTableViewCell

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.myListCellManager = [[HXBBaseViewCell_MYListCellTableViewCellManager alloc] init];
        [self setUP];
    }
    return self;
}
#pragma mark - 值传递
- (void)setUPValueWithListCellManager:(HXBBaseViewCell_MYListCellTableViewCellManager *(^)(HXBBaseViewCell_MYListCellTableViewCellManager *))managerBlock {
    self.myListCellManager = managerBlock(self.myListCellManager);
}

- (void)setMyListCellManager:(HXBBaseViewCell_MYListCellTableViewCellManager *)myListCellManager {
    _myListCellManager = myListCellManager;
    if (myListCellManager.title_ImageName.length) {
       UIImage *image = [UIImage imageNamed:myListCellManager.title_ImageName];
        if (!image) {
            UIImageView *imageView = [[UIImageView alloc]init];
            imageView.svgImageString = myListCellManager.title_ImageName;
            image = imageView.image;
        }
        self.title_ImageView.image = image;
        self.title_ImageView.hidden = NO;
    }else {///没有imageView 那么跟新约束
        [self hxb_updateConstraints_imageView];
    }
    self.title_LeftLabel.text = myListCellManager.title_LeftLabelStr;
    self.title_RightLabel.text = myListCellManager.title_RightLabelStr;
    if (self.title_RightLabel.text.length) {
        self.title_RightBGView.hidden = NO;
    }else
    {
        self.title_RightBGView.hidden = YES;
    }
    
    
    [self.bottomTopBottomView setUPViewManagerWithBlock:^HXBBaseView_MoreTopBottomViewManager * (HXBBaseView_MoreTopBottomViewManager *viewManager) {
        myListCellManager.bottomViewManager.leftViewArray = viewManager.leftViewArray;
        myListCellManager.bottomViewManager.rightViewArray = viewManager.rightViewArray;
        return myListCellManager.bottomViewManager;
    }];
    UILabel *label = (UILabel *) self.bottomTopBottomView.rightViewArray[1];
    label.textColor = kHXBColor_Red_090303;
    if (myListCellManager.wenHaoImageName.length) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.svgImageString = myListCellManager.wenHaoImageName;
        [self.bottomTopBottomView addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.bottomTopBottomView.leftViewArray.lastObject.mas_right).offset(kScrAdaptationW(4));
            make.height.width.equalTo(@(kScrAdaptationH(14)));
            make.centerY.equalTo(self.bottomTopBottomView.leftViewArray.lastObject);
        }];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
}

#pragma mark - 赋值 后 更新约束
///title 没有ImageView 的时候更新约束
- (void)hxb_updateConstraints_imageView {
    self.title_ImageView.hidden = !self.myListCellManager.title_ImageName;
    CGFloat title_LeftLabel_LeftW = self.myListCellManager.title_ImageName.length? kScrAdaptationW(35) : kScrAdaptationW(15);
    if (!self.myListCellManager.title_ImageName) {
        [self.title_LeftLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
        }];
    }
}


#pragma mark - UI 搭建
- (void)setUP {
    [self setUPViews];
}

- (void)setUPViews {
    ///title view的搭建
    [self setUPTitleView];
    /// 底部的上下分层的View
    [self setUPBottomView];
}

///MARK: title view的搭建
- (void)setUPTitleView {
    [self setUPLineView];///划线
    [self setUPTitleView_imageView];//imageView
    [self setUPTitleView_LeftTitleLabel];///title 左边
    [self setUPTitleView_RightTitleLabel];///title 右边
}

/// setUP lineView
- (void)setUPLineView {
    self.lineview = [[UIView alloc]init];
    [self.contentView addSubview:self.lineview];
    [self.lineview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(0.5));
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(kScrAdaptationH(44));
    }];
    self.lineview.backgroundColor = kHXBColor_Font0_5;
}

/// setUPImageView
- (void)setUPTitleView_imageView {
        self.title_ImageView = [[UIImageView alloc]init];
        [self.contentView addSubview: self.title_ImageView];
        [self.title_ImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.with.equalTo(@(kScrAdaptationH(15)));
            make.left.equalTo(self.contentView).offset(kScrAdaptationW(15));
            make.centerY.equalTo(self.contentView.mas_top).offset(kScrAdaptationH(22));
        }];
}

/// setUP TitleLabel
- (UIView *)setUPTitleView_LeftTitleLabel{
    
    self.title_LeftLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.title_LeftLabel];
    self.title_LeftLabel.font = kHXBFont_PINGFANGSC_REGULAR(14);
    self.title_LeftLabel.textColor = kHXBColor_Grey_Font0_2;

    CGFloat leftW = kScrAdaptationW(35);
    [self.title_LeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(leftW);
        make.centerY.equalTo(self.title_ImageView);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.lineview.mas_top);
    }];
    return self.title_LeftLabel;
}

///set UP TitleLabel _ right
- (void)setUPTitleView_RightTitleLabel {
    self.title_RightLabel = [[UILabel alloc]init];
    UIView *view = [[UIView alloc]init];
    [self.contentView addSubview:view];
    [view addSubview:self.title_RightLabel];
    self.title_RightLabel.font = kHXBFont_PINGFANGSC_REGULAR(12);
    self.title_RightLabel.textColor = kHXBColor_Blue040610;
    view.layer.borderColor = kHXBColor_Blue040610.CGColor;
    view.layer.borderWidth = kScrAdaptationH(0.8f);
    view.layer.cornerRadius = kScrAdaptationH(22 / 2.0);
    view.layer.masksToBounds = true;
    self.title_RightBGView = view;
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(kScrAdaptationW(-15));
        make.height.equalTo(@(kScrAdaptationH(22)));
        make.centerY.equalTo(self.title_LeftLabel);
        make.left.equalTo(self.title_RightLabel).offset(kScrAdaptationW(-10));
    }];
    [self.title_RightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view);
        make.right.equalTo(view).offset(kScrAdaptationW(-10));
        make.top.bottom.equalTo(view);
        make.left.equalTo(view.mas_left).offset(kScrAdaptationW(10));
    }];
}

/// 底部的上下分层的View
- (void) setUPBottomView {
    UIEdgeInsets insets = UIEdgeInsetsMake(kScrAdaptationH(11), kScrAdaptationW(15), kScrAdaptationH(11), kScrAdaptationW(15));
    self.bottomTopBottomView = [[HXBBaseView_MoreTopBottomView alloc]initWithFrame:CGRectZero andTopBottomViewNumber:3 andViewClass:[UILabel class] andViewHeight:kScrAdaptationH(13) andTopBottomSpace:kScrAdaptationH(16) andLeftRightLeftProportion:0 Space:insets];
    UILabel *label = (UILabel *) self.bottomTopBottomView.rightViewArray[1];
   
    [self.contentView addSubview:self.bottomTopBottomView];
    [self.bottomTopBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.lineview.mas_bottom);
        make.bottom.equalTo(self.lineview);
    }];
     label.textColor = kHXBColor_Red_090303;
}
@end



@implementation HXBBaseViewCell_MYListCellTableViewCellManager
- (instancetype)init
{
    self = [super init];
    if (self) {//默认配置
        self.bottomViewManager = [[HXBBaseView_MoreTopBottomViewManager alloc]init];
        self.bottomViewManager.leftFont = kHXBFont_PINGFANGSC_REGULAR(12);
        self.bottomViewManager.rightFont = kHXBFont_PINGFANGSC_REGULAR(14);
        self.bottomViewManager.leftTextColor = kHXBColor_Font0_6;
        self.bottomViewManager.rightTextColor = kHXBColor_Grey_Font0_3;
        self.bottomViewManager.rightLabelAlignment = NSTextAlignmentRight;
    }
    return self;
}

@end
