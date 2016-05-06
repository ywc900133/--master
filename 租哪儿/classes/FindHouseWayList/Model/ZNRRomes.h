//
//  ZNRRomes.h
//  租哪儿
//
//  Created by 袁武昌 on 16/4/17.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZNRCoverPictures.h"
@interface ZNRRomes : NSObject


/**图片名字*/
@property (nonatomic,strong)ZNRCoverPictures *cover_pictures;

/**区级名字*/
@property (nonatomic,copy)NSString *district_name;
/**地级名字*/
@property (nonatomic,copy)NSString *area_name;

/**房间名字*/
@property (nonatomic,copy)NSString *room_name;

/**小区名字*/
@property (nonatomic,copy)NSString *community;

/**小区名字*/
@property (nonatomic,assign)NSString *square;

/**租金*/
@property (nonatomic,copy)NSString *payment;
/**地铁线*/
@property (nonatomic,strong)NSArray *subway;
/**微信认证*/
@property (nonatomic,copy)NSString *wechat_bind;

/**卧室数量*/
@property (nonatomic,copy)NSNumber *bed_room;
/**厅数量*/
@property (nonatomic,copy)NSNumber *hall_room;
/**卫生间数量*/
@property (nonatomic,copy)NSNumber *bath_room;

//+ (instancetype)roomWithDict:(NSDictionary *)dict;
@end
