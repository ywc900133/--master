//
//  ZNRDistrict.h
//  租哪儿
//
//  Created by 袁武昌 on 16/4/20.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZNRDistrict : NSObject
@property(nonatomic ,copy) NSString *name;
/** 子数据*/
@property(nonatomic ,strong) NSArray *subregions;
@end
