
//
//  UIBarButtonItem+ZNRItem.m
//  租哪儿
//
//  Created by yuan on 16/4/6.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import "UIBarButtonItem+ZNRItem.h"
#import "ZNRBarBtn.h"
@implementation UIBarButtonItem (ZNRItem)
+ (UIBarButtonItem *)backItemWithImage:(UIImage *)image highImage:(UIImage *)highImage target:(id)target action:(SEL)action title:(NSString *)title
{
    // 设置返回按钮
    ZNRBarBtn *backButton = [[ZNRBarBtn alloc] init];
    [backButton setTitle:title forState:UIControlStateNormal];
    //    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton setImage:highImage forState:UIControlStateHighlighted];
    
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [backButton sizeToFit];
    // 设置内容内边距
    backButton.contentEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 0);
    
    UIView *contentView = [[UIView alloc] initWithFrame:backButton.bounds];
    [contentView addSubview:backButton];
    return  [[UIBarButtonItem alloc] initWithCustomView:contentView];
    
}

+ (UIBarButtonItem *)itemWithImage:(UIImage *)image selImage:(UIImage *)selImage target:(id)target action:(SEL)action
{
    // 创建按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image  forState:UIControlStateNormal];
    [button setImage:selImage forState:UIControlStateSelected];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    
    // 把按钮包装成view,处理点击区域太大
    UIView *barButtonView = [[UIView alloc] initWithFrame:button.bounds];
    [barButtonView addSubview:button];
    
    // 把按钮包装成UIBarButtonItem就会由问题
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:barButtonView];
    
    return item;
}
@end
