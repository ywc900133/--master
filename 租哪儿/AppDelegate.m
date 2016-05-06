//
//  AppDelegate.m
//  租哪儿
//
//  Created by yuan on 16/4/6.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import "AppDelegate.h"
//#import "ZNRNewFCollectionViewController.h"
#import "ZNRTabBarController.h"
#import "ZNRRootTool.h"




@interface AppDelegate ()

@end

@implementation AppDelegate
//程序启动完成

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    //1.创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //2.设置窗口的根控制器.
    //    self.window.rootViewController = [ZNRRootTool choosRootViewController];
    self.window.rootViewController = [[ZNRTabBarController alloc] init];
    
    //    self.window.rootViewController.view.backgroundColor = [UIColor redColor];
    
    //3.让窗口显示
    [self.window makeKeyAndVisible];
    

    
    
    
    
   
    
    
    return YES;
}

@end
