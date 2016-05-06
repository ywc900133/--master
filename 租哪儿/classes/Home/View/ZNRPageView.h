//
//  ZNRPageView.h
//  租哪儿
//
//  Created by yuan on 16/4/7.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZNRPageView : UIView
+ (instancetype)pageView;
@property (nonatomic, assign)NSInteger index;
/**
 *  定时器
 */
@property (nonatomic,weak) NSTimer *timer;

@end
