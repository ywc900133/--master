//
//  ZNRSiftViewController.h
//  租哪儿
//
//  Created by yuan on 16/4/7.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZNRRentBtn.h"
#import "ZNRSelectLogBtn.h"
#import "ZNRArrayBtn.h"
@interface ZNRSiftViewController : UIViewController

/** 整租按钮*/
@property (weak, nonatomic) IBOutlet ZNRRentBtn *allRentBtn;
/** 合租按钮*/
@property (weak, nonatomic) IBOutlet ZNRRentBtn *togetherRentBtn;
/** 微信绑定按钮*/
@property (weak, nonatomic) IBOutlet ZNRSelectLogBtn *weChatBtn;
/** 实名认证按钮*/
@property (weak, nonatomic) IBOutlet ZNRSelectLogBtn *realyNameBtn;

/** 默认排序按钮*/
@property (weak, nonatomic) IBOutlet ZNRArrayBtn *defaultBtn;
/** 价格由低到高排序按钮*/
@property (weak, nonatomic) IBOutlet ZNRArrayBtn *lowBtn;
/** 价格由高到低排序按钮*/
@property (weak, nonatomic) IBOutlet ZNRArrayBtn *hightBtn;



@end
