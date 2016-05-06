//
//  ZNRAccout.m
//  租哪儿
//
//  Created by 袁武昌 on 16/4/27.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import "ZNRAccout.h"

@implementation ZNRAccout


+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    ZNRAccout *account = [[self alloc]init];
    [account setValuesForKeysWithDictionary:dict];
    return account;
}


//+ (instancetype)accontUserName:(NSString *)userName Pwd:(NSString *)pwd
//{
//    ZNRAccout *accout = [[self alloc] init];
//    accout.userName = userName;
//    accout.pwd = pwd;
//    return accout;
//}
@end
