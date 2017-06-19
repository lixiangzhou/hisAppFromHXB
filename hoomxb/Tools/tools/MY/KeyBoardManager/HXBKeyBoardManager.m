//
//  HXBKeyBoardManager.m
//  hoomxb
//
//  Created by HXB on 2017/6/15.
//  Copyright © 2017年 hoomsun-miniX. All rights reserved.
//

#import "HXBKeyBoardManager.h"
typedef void(^keyboardWillShowBlock_Type)(NSInteger keyBordH, CGFloat Duration, NSDictionary * keyBordInfo);
typedef void(^keyboardWillHiddenBlock_Type)(NSInteger keyBordH, CGFloat Duration, NSDictionary * keyBordInfo);
@interface HXBKeyBoardManager ()

@property (nonatomic,copy) void(^keyboardWillShowBlock)(NSInteger keyBordH, CGFloat Duration, NSDictionary * keyBordInfo);
@property (nonatomic,copy) void(^keyboardWillHiddenBlock)();

@property (nonatomic,strong) NSCache <NSString *, keyboardWillShowBlock_Type>*showKeyboardCache;
@property (nonatomic,strong) NSCache <NSString *, keyboardWillHiddenBlock_Type>*hiddenKeyboardCache;
@property (nonatomic,strong) NSMutableArray <NSString *>*array;
@end

static HXBKeyBoardManager *_instanceType;
@implementation HXBKeyBoardManager
+ (instancetype) shaerdKeyBoardManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instanceType = [[self alloc]init];
        [[NSNotificationCenter defaultCenter] addObserver:_instanceType selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:_instanceType selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    });
    return _instanceType;
}
#pragma mark Keyboard
-(void)keyboardWillShow:(NSNotification*)notif{

    if (self.keyboardWillShowBlock) {
        NSNumber *keyBoardBoundsNumber = notif.userInfo[UIKeyboardFrameEndUserInfoKey];
        CGRect keyBoardBounds = keyBoardBoundsNumber.CGRectValue;
        NSInteger keyBoardH = keyBoardBounds.size.height;
        
        NSNumber *keyBoardDuration = notif.userInfo[UIKeyboardAnimationDurationUserInfoKey];
        
        self.keyboardWillShowBlock(keyBoardH,keyBoardDuration.floatValue,notif.userInfo);
    }
}
-(void)keyboardWillHide:(NSNotification*)notif{
    if (self.keyboardWillHiddenBlock) {
        self.keyboardWillHiddenBlock();
    }
}
//load中调用
- (void)registerKeyboardEventWithandKeyboardWillShowBlock:(void(^)(NSInteger keyBordH, CGFloat Duration, NSDictionary * keyBordInfo))KeyboardWillShowBlock
            andKeyboardWillHiddenBlock:(void(^)())KeyboardWillHiddenBlock{
//    HXBKeyBoardManager *manager = [self shaerdKeyBoardManager];
//    NSString *classStr = NSStringFromClass([obj class]);
//    [manager.array addObject:classStr];
    
    
//    manager.showKeyboardCache setObject:KeyboardWillShowBlock forKey:<#(nonnull NSString *)#>
    self.keyboardWillHiddenBlock = KeyboardWillHiddenBlock;
    self.keyboardWillShowBlock = KeyboardWillShowBlock;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
}
//unload中调用
- (void)unregisterKeyboardEvent{
//    HXBKeyBoardManager *manager = [self shaerdKeyBoardManager];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

//- (void) dealloc {
//    if ([self isEqual: _instanceType]) {
//        [HXBKeyBoardManager unregisterKeyboardEvent];
//    }
//}
@end
