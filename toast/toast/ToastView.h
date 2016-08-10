//
//  ToastView.h
//  toast
//
//  Created by pub on 16/8/10.
//  Copyright © 2016年 pub. All rights reserved.
//

#import <UIKit/UIKit.h>

//出现 以及消失的方式
typedef NS_ENUM(NSUInteger,ShowAndFadeType) {
    ShowAndFadeTypeTopToBottomFadeToTop,   //从顶部出现 消失又回到顶部
    ShowAndFadeTypeTopToBottomFadeToLeft,  //从顶部出现 从左边消失
    ShowAndFadeTypeTopToBottomFadeToRight, //从顶部出现 从右边消失
    ShowAndFadeTypeTopToBottomFadeToBottom, //从顶部出现 从底部消失
    ShowAndFadeTypeBottomToTopFadeToBottom, //同上
    ShowAndFadeTypeBottomToTopFadeToTop,
    ShowAndFadeTypeBottomToTopFadeToLeft,
    ShowAndFadeTypeBottomToTopFadeToRight,
};

//动画展示的方式
typedef NS_ENUM(NSUInteger, AnimationType) {
    AnimationTypeNormal,
    AnimationTypeSpring,
};

@class ToastView;

@protocol ToastViewDelegate <NSObject>

@optional

//toast 持续展示的时间
- (CGFloat)showDuration:(ToastView *)toastView;

//toast 出现时候的持续时间
- (CGFloat)animationDuration:(ToastView *)toastView;


@end

@interface ToastView : UIView

@property (nonatomic, weak) id<ToastViewDelegate> deleagte;

@property (nonatomic, assign) ShowAndFadeType fadeType;

@property (nonatomic, assign) AnimationType animaitionType;

//弹框展示的方法
- (void)show;

@end
