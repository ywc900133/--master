//
//  UIBarButtonItem+ZNRItem.h
//  租哪儿
//
//  Created by yuan on 16/4/6.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ZNRItem)

+ (UIBarButtonItem *)backItemWithImage:(UIImage *)image highImage:(UIImage *)selImage target:(id)target action:(SEL)action title:(NSString *)title;

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action;
@end
