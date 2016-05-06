//
//  ZNRNavigationController.m
//  租哪儿
//
//  Created by yuan on 16/4/7.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import "ZNRNavigationController.h"
#import "UIBarButtonItem+ZNRItem.h"
@interface ZNRNavigationController()<UIGestureRecognizerDelegate>


@end
@implementation ZNRNavigationController
+ (void)load
{
    // 获取当前导航控制器下的导航条
    UINavigationBar *navBar = [UINavigationBar appearanceWhenContainedIn:self, nil];
    
    // 设置导航条标题 -> 由导航条决定
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20];
    
    // 统一设置导航条背景图片
    [navBar setBackgroundImage:[UIImage imageNamed:@"CPArenaSegmentSelectedBG"] forBarMetrics:UIBarMetricsDefault];
    
    
}

#pragma mark - 状态栏控制
//控制显示还是隐藏
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
//状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 全屏滑动:添加一个pan手势,全屏滑动返回
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self.interactivePopGestureRecognizer.delegate action:@selector(handleNavigationTransition:)];
    
    [self.view addGestureRecognizer:pan];
    
    // 禁止边缘滑动手势
    self.interactivePopGestureRecognizer.enabled = NO;
}

// 重写系统方法:
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 非根控制器才需要设置
    if (self.childViewControllers.count) {
        
        // 设置返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithImage:[UIImage imageNamed:@"NavBack"] highImage:nil target:self action:@selector(back) title:@"返回"];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    // 这里才是真正跳转
    [super pushViewController:viewController animated:animated];
}
//监听点击
- (void)back
{
    [self popViewControllerAnimated:YES];
}
@end
