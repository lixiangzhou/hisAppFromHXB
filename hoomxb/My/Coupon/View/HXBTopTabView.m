//
//  HXBTopTabView.m
//  hoomxb
//
//  Created by lxz on 2017/10/31.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBTopTabView.h"

@interface HXBTopTabView()
@property (nonatomic, assign) CGFloat bottomLineHeight;
@property (nonatomic, weak) UIView *bottomLine;

@property (nonatomic, assign) CGFloat bottomLineWidthPading;
@property (nonatomic, assign) BOOL bottomLineWidthAdjustTitle;

@property (nonatomic, weak) UIButton *selectedTab;

//@property (nonatomic, strong) NSMutableArray *tabs;
@end

@implementation HXBTopTabView

- (instancetype)initWithFrame:(CGRect)frame
                      titles:(NSArray *)titles
                        font:(UIFont *)font
                 normalColor:(UIColor *)normalColor
               selectedColor:(UIColor *)selectedColor
                sepLineColor:(UIColor *)sepLineColor
                sepLineWidth:(CGFloat)sepLineWidth
               sepLineHeight:(CGFloat)sepLineHeight
             bottomLineColor:(UIColor *)bottomLineColor
            bottomLineHeight:(CGFloat)bottomLineHeight
  bottomLineWidthAdjustTitle:(BOOL)bottomLineWidthAdjustTitle
       bottomLineWidthPading:(CGFloat)bottomLineWidthPading
               selectedIndex:(NSInteger)selectedIndex;
{
    if (titles.count <= 0) {
        return nil;
    }

    self = [super initWithFrame:frame];
    self.bottomLineWidthAdjustTitle = YES;
    self.bottomLineWidthPading = 3;
    self.bottomLineWidthAdjustTitle = bottomLineWidthAdjustTitle;
    self.bottomLineWidthPading = bottomLineWidthPading;
    self.bottomLineHeight = bottomLineHeight;
    _selectedIndex = selectedIndex;
    
    self.tabs = [NSMutableArray arrayWithCapacity:titles.count];
    
    CGFloat height = self.bounds.size.height;
    CGFloat width = self.bounds.size.width;
    
    // 添加按钮
    CGFloat btnW = width / titles.count;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *tab = [self addTabWithTitle:titles[i] font:font normalColor:normalColor selectedColor:selectedColor];
        tab.tag = i;
        CGFloat btnX = i * btnW;
        tab.frame = CGRectMake(btnX, 0, btnW, height);
        if (i == selectedIndex) {
            self.selectedTab = tab;
            tab.selected = YES;
        }
    }
    // 添加分割线
    CGFloat sepY = (height - sepLineHeight) * 0.5;
    for (NSInteger i = 1; i < titles.count; i++) {
        UIView *sepLine = [UIView new];
        sepLine.backgroundColor = sepLineColor;
        
        CGFloat sepX = i * btnW;
        sepLine.frame = CGRectMake(sepX, sepY, sepLineWidth, sepLineHeight);

        [self addSubview:sepLine];
    }
    
    // 底部线
    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = bottomLineColor;
    [self addSubview:bottomLine];
    self.bottomLine = bottomLine;
    
    CGFloat bottomX = self.selectedTab.frame.origin.x;
    CGFloat bottomW = self.selectedTab.frame.size.width;
    
    if (self.bottomLineWidthAdjustTitle) {
        NSString *title = [self.selectedTab titleForState:UIControlStateNormal];
        
        bottomW = [title sizeWithAttributes:@{NSFontAttributeName: self.selectedTab.titleLabel.font}].width + self.bottomLineWidthPading * 2;
        
        bottomX = self.selectedTab.frame.origin.x + (btnW - bottomW) * 0.5;
    }
    self.bottomLine.frame = CGRectMake(bottomX, height - self.bottomLineHeight, bottomW, self.bottomLineHeight);
    
    return self;
}


/**
 添加tab
 */
- (UIButton *)addTabWithTitle:(NSString *)title
                   font:(UIFont *)font
            normalColor:(UIColor *)normalColor
          selectedColor:(UIColor *)selectedColor {
    UIButton *btn = [UIButton new];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = font;
    [btn setTitleColor:normalColor forState:UIControlStateNormal];
    [btn setTitleColor:selectedColor forState:UIControlStateSelected];
    
    [btn addTarget:self action:@selector(tabClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tabs addObject:btn];
    [self addSubview:btn];
    return btn;
}


/**
 tab 点击动画
 */
- (void)tabAnimation:(UIButton *)tab {
    
    if (tab != self.selectedTab) {
        tab.selected = YES;
        self.selectedTab.selected = NO;
        self.selectedTab = tab;
        
        CGFloat bottomX = tab.frame.origin.x;
        CGFloat bottomW = tab.frame.size.width;
        
        if (self.bottomLineWidthAdjustTitle) {
            NSString *title = [tab titleForState:UIControlStateNormal];
            
            bottomW = [title sizeWithAttributes:@{NSFontAttributeName: self.selectedTab.titleLabel.font}].width + self.bottomLineWidthPading * 2;
            
            bottomX = tab.frame.origin.x + (tab.frame.size.width - bottomW) * 0.5;
        }
        self.bottomLine.frame = CGRectMake(bottomX, tab.frame.size.height - self.bottomLineHeight, bottomW, self.bottomLineHeight);
        
        [UIView animateWithDuration:0.25 animations:^{
            self.bottomLine.frame = CGRectMake(bottomX, self.bounds.size.height - self.bottomLineHeight, bottomW, self.bottomLineHeight);
        }];
    }
}

/**
 tab 点击
 */
- (void)tabClick:(UIButton *)tab {
    [self tabAnimation:tab];
    
    if ([self.delegate respondsToSelector:@selector(topTabView:didClickIndex:)]) {
        [self.delegate topTabView:self didClickIndex:tab.tag];
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    
    UIButton *btn = self.tabs[selectedIndex];
    
    [self tabAnimation:btn];
}

@end
