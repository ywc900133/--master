//
//  ZNRAccout.h
//  租哪儿
//
//  Created by 袁武昌 on 16/4/27.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZNRAccout : NSObject

@property(nonatomic,copy)NSString *avatar;
@property(nonatomic,copy)NSString *nickname;
@property(nonatomic,copy)NSString *token;
@property(nonatomic,copy)NSString *uid;
@property(nonatomic,copy)NSString *user_type;
@property(nonatomic,copy)NSString *verify;

+ (instancetype)accountWithDict:(NSDictionary *)dict;

@end
