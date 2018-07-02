//
//  YJYTouchScroll.m
//  YJYConsultant
//
//  Created by 聂涛 on 2018/1/9.
//  Copyright © 2018年 于欢. All rights reserved.
//

#import "YJYTouchScroll.h"

@implementation YJYTouchScroll

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[self nextResponder] touchesBegan:touches withEvent:event];
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [[self nextResponder] touchesEnded:touches withEvent:event];
    [super touchesEnded:touches withEvent:event];
    
}
@end
