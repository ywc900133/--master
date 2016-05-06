//
//  ZNRSaveTool.h
//  租哪儿
//
//  Created by yuan on 16/4/7.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZNRSaveTool : NSObject
+ (id)objectForKey:(NSString *)defaultName;
+ (BOOL)boolForKey:(NSString *)defaultName;
+ (void)setObject:(id)value forKey:(NSString *)defaultName;
+ (void)setBool:(BOOL)value forKey:(NSString *)defaultName;
+ (void)removeObjectForKey:(NSString *)defaultName;


@end
