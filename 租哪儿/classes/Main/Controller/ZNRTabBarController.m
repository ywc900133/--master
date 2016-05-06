

//
//  ZNRTabBarController.m
//  租哪儿
//
//  Created by yuan on 16/4/7.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import "ZNRTabBarController.h"
#import "ZNRHomeController.h"
#import "ZNRAppointmentController.h"
#import "ZNRMessageCotroller.h"
#import "ZNRMeController.h"
#import "ZNRLoginViewController.h"

#import "ZNRNavigationController.h"
#define ZNRTabBarButtonTitleFont [UIFont systemFontOfSize:15]
@implementation ZNRTabBarController
+ (void)load
{
    // 获取当前类中的所有tabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    // 1.设置默认状态下的标题字体
    // 1.1描述字符串的属性
    NSMutableDictionary *attrNor = [NSMutableDictionary dictionary];
    // 1.2设置标题字体大小
    attrNor[NSFontAttributeName] = ZNRTabBarButtonTitleFont;
    [item setTitleTextAttributes:attrNor forState:UIControlStateNormal];
    
    // 2.设置tabBarButton按钮选中标题颜色
    // 2.1 描述字符串的属性
    NSMutableDictionary *attrSel = [NSMutableDictionary dictionary];
    // 2.2 设置字体颜色
    attrSel[NSForegroundColorAttributeName] = [UIColor orangeColor];
    // 设置选中状态下的标题颜色
    [item setTitleTextAttributes:attrSel forState:UIControlStateSelected];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加所有的子控制器
    [self setUpAllChildViewController];
    
}
//添加所有的子控制器
- (void)setUpAllChildViewController{
    
    //首页
    ZNRHomeController *home = [[ZNRHomeController alloc] init];
    [self setUpOneChildViewController:home image:[UIImage imageNamed:@"tabbar_home"] selectImage:[UIImage imageNamed:@"tabbar_home_highlighted"] title:@"首页"];
//    home.view.backgroundColor = [UIColor redColor];
        //预约申请
    ZNRAppointmentController *appointment = [[ZNRAppointmentController alloc] init];
    [self setUpOneChildViewController:appointment image:[UIImage imageNamed:@"tabbar_me"] selectImage:[UIImage imageNamed:@"tabbar_me_highlighted"] title:@"预约申请"];
    appointment.view.backgroundColor = [UIColor grayColor];
    //消息
    ZNRMessageCotroller *message = [[ZNRMessageCotroller alloc] init];
    [self setUpOneChildViewController:message image:[UIImage imageNamed:@"tabbar_me"] selectImage:[UIImage imageNamed:@"tabbar_me_highlighted"] title:@"消息"];
    message.navigationItem.title = @"消息中心";
    message.view.backgroundColor = [UIColor grayColor];

        //个人中心
        ZNRMeController *me = [[ZNRMeController alloc] init];
        [self setUpOneChildViewController:me image:[UIImage imageNamed:@"tabbar_me"] selectImage:[UIImage imageNamed:@"tabbar_me_highlighted"] title:@"个人中心"];
 }

/** 添加一个子控制器方法*/
- (void)setUpOneChildViewController:(UIViewController *)vc image:(UIImage *)norImage selectImage:(UIImage *)selectImage title:(NSString *)title{
    
    vc.title = title;
    vc.tabBarItem.image = norImage;
    vc.tabBarItem.selectedImage = selectImage;
    
    ZNRNavigationController  *nav = [[ZNRNavigationController alloc]initWithRootViewController:vc];
    
    [nav.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    [self addChildViewController:nav];
    
}


@end
