//
//  ViewController.m
//  toast
//
//  Created by pub on 16/8/10.
//  Copyright © 2016年 pub. All rights reserved.
//

#import "ViewController.h"
#import "ToastView.h"

@interface ViewController ()<ToastViewDelegate>

@property (nonatomic, strong) ToastView * toastView;

@end

@implementation ViewController


//life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试弹框";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.toastView = [[ToastView alloc]init];
    self.toastView.deleagte = self;
    self.toastView.fadeType = ShowAndFadeTypeTopToBottomFadeToTop;
    self.toastView.animaitionType = AnimationTypeNormal;
    [[self topView].view addSubview:self.toastView];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.toastView show];
    });
    
}



//拿顶层的viewcontroller
- (UIViewController *)topView{
    UIWindow * keyWindow = [UIApplication sharedApplication].keyWindow;
    UIViewController * controller = keyWindow.rootViewController;
    while (controller.presentedViewController) {
        controller = controller.presentedViewController;
    }
    return controller;
}


#pragma --mark ToastView Delegate

-(CGFloat)showDuration:(ToastView *)toastView{
    return 1.f;
}

-(CGFloat)animationDuration:(ToastView *)toastView{
    return 1.f;
}

@end
