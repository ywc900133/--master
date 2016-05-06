

//
//  ZNRRootTool.m
//  租哪儿
//
//  Created by yuan on 16/4/7.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import "ZNRRootTool.h"
#import "ZNRTabBarController.h"
#import "ZNRNewFCollectionViewController.h"
#import "ZNRSaveTool.h"

#define ZNRVersionKey @"versionKey"
@implementation ZNRRootTool

/**
 *  专门用来选择根控制器
 *  选择好的根控制器.
 */
+ (UIViewController *)choosRootViewController{
    
    //获取当前程序的版本号
    NSString *curVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    
        NSString *preVersion = [ZNRSaveTool objectForKey:ZNRVersionKey];
//    1.比对上次一次版本号.
        if ([curVersion isEqualToString:preVersion]) {
//    如果发现与上一次的版本号相同.tabBarVC(程序的主框架)
            ZNRTabBarController *tabBarVC = [[ZNRTabBarController alloc] init];
            return tabBarVC;
        }else{
//    如果发现与上一次的版本不同.跳转到新特性界面.
    ZNRNewFCollectionViewController *newFeature = [[ZNRNewFCollectionViewController alloc] init];
    
    [ZNRSaveTool setObject:curVersion forKey:ZNRVersionKey];
    return newFeature;
        }
}

@end
