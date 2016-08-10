//
//  ToastView.m
//  toast
//
//  Created by pub on 16/8/10.
//  Copyright © 2016年 pub. All rights reserved.
//

#import "ToastView.h"
#import "UIView+Sizes.h"

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define iconWidth 20
#define topMargin 25
#define leftMargin 10

static const CGFloat defaultAnimationDuration = 2.0f;

static const CGFloat defaultShowDuration = 2.0f;

static const NSUInteger defaultShowAndFadeType = 0;

static const NSUInteger defaultAnimationType = 1;

@interface ToastView()

@property (nonatomic, assign) CGFloat animationDuration;

@property (nonatomic, assign) CGFloat showDuration;

@property (nonatomic, assign) CGFloat finalLeft;

@property (nonatomic, assign) CGFloat finalTop;

@property (nonatomic, assign) CGFloat finalHeight;

@end

@implementation ToastView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpUI];
    }
    return self;
}

-(instancetype)init{
    self = [super init];
    if (self) {
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI{
    
    self.frame = CGRectMake(0, -64, ScreenWidth, 64);
    self.backgroundColor = [UIColor blueColor];
    
    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"alert_icon"]];
    
    imageView.width = iconWidth;
    imageView.height = iconWidth;
    imageView.top = topMargin;
    imageView.left = self.left + leftMargin;
    
    [self addSubview:imageView];

};

-(void)setFadeType:(ShowAndFadeType)fadeType{
    switch (fadeType) {
        case ShowAndFadeTypeTopToBottomFadeToLeft:
        {
            self.left = 0;
            self.top = -64;
            self.finalTop = 0;
            self.finalLeft = -ScreenWidth;
            self.finalHeight = 64;
        }
            break;
        case ShowAndFadeTypeTopToBottomFadeToRight:
        {
            self.left = 0;
            self.top = -64;
            self.finalTop = 0;
            self.finalLeft = ScreenWidth;
            self.finalHeight = 64;
        }
            break;
        case ShowAndFadeTypeTopToBottomFadeToTop:
        {
            self.left = 0;
            self.top = -64;
            self.finalLeft = 0;
            self.finalTop = -64;
            self.finalHeight = 64;
        }
            break;
        case ShowAndFadeTypeBottomToTopFadeToTop:{
            self.left = 0;
            self.height = 0;
            self.top = 64;
            self.finalTop = -64;
            self.finalLeft = 0;
            self.finalHeight = 64;
        }
            break;
        case ShowAndFadeTypeBottomToTopFadeToLeft:{
            self.left = 0;
            self.height = 0;
            self.top = 64;
            self.finalTop = 0;
            self.finalHeight = 64;
            self.finalLeft = -ScreenWidth;
        }
            break;
        case ShowAndFadeTypeBottomToTopFadeToRight:{
            self.left = 0;
            self.height = 0;
            self.top = 64;
            self.finalTop = 0;
            self.finalHeight = 64;
            self.finalLeft = ScreenWidth;
        }
            break;
        case ShowAndFadeTypeBottomToTopFadeToBottom:
        {
            self.left = 0;
            self.height = 0;
            self.top = 64;
            self.finalTop = 64;
            self.finalHeight = 0;
            self.finalLeft = 0;
        }
            break;
        case ShowAndFadeTypeTopToBottomFadeToBottom:
        {
            self.left = 0;
            self.height = 64;
            self.top = -64;
            self.finalTop = 64;
            self.finalHeight = 0;
            self.finalLeft = 0;
        }
            break;
        default:
        {
            self.left = 0;
            self.top = -64;
            self.finalTop = 0;
            self.finalLeft = -ScreenWidth;
        }
            break;
    }
}

-(void)show{
    
    switch (self.animaitionType) {
        case AnimationTypeNormal:
        {
            [UIView animateWithDuration:self.animationDuration animations:^{
                self.top = 0;
                self.left = 0;
                self.height = 64;
            } completion:^(BOOL finished) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, self.showDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [UIView animateWithDuration:1.0f animations:^{
                        self.top = self.finalTop;
                        self.left = self.finalLeft;
                        self.height = self.finalHeight;
                    }];
                });
            }];

        }
            break;
            
        case AnimationTypeSpring:
        {
            
            [UIView animateWithDuration:self.animationDuration delay:0.f usingSpringWithDamping:0.3f initialSpringVelocity:0.5f options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.top = 0;
                self.left = 0;
                self.height = 64;
            } completion:^(BOOL finished) {
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, self.showDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [UIView animateWithDuration:1.0f animations:^{
                        self.top = self.finalTop;
                        self.left = self.finalLeft;
                        self.height = self.finalHeight;
                    }];
                });
            }];
        
        }
            break;
        default:
            break;
    }
    
    }

-(CGFloat)animationDuration{
    if ([self.deleagte respondsToSelector:@selector(animationDuration:)]) {
        return [self.deleagte animationDuration:self];
    }
    return defaultAnimationDuration;
}

-(CGFloat)showDuration{
    if ([self.deleagte respondsToSelector:@selector(showDuration:)]) {
        return [self.deleagte showDuration:self];
    }
    return defaultShowDuration;
}


@end
