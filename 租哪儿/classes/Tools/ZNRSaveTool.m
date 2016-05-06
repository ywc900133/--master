
//
//  ZNRSaveTool.m
//  租哪儿
//
//  Created by yuan on 16/4/7.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import "ZNRSaveTool.h"

@implementation ZNRSaveTool
+ (id)objectForKey:(NSString *)defaultName{
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:defaultName];
}
+ (BOOL)boolForKey:(NSString *)defaultName
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:defaultName];
}


+ (void)setObject:(id)value forKey:(NSString *)defaultName{
    
    //保存当前的版本号.
    NSUserDefaults  *defaults = [NSUserDefaults standardUserDefaults];
    //并不是立马保存,它是在某一时刻系统统一进行保存.
    [defaults setObject:value forKey:defaultName];
    //立马进行保存.
    [defaults synchronize];
    
}
 + (void)setBool:(BOOL)value forKey:(NSString *)defaultName
{
    //保存当前的版本号.
    NSUserDefaults  *defaults = [NSUserDefaults standardUserDefaults];
    //并不是立马保存,它是在某一时刻系统统一进行保存.
    [defaults setBool:value forKey:defaultName];
    //立马进行保存.
    [defaults synchronize];
}
+ (void)removeObjectForKey:(NSString *)defaultName
{
     NSUserDefaults  *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:defaultName];
    [defaults synchronize];
}
@end
