//
//  ZNRUserIcon.m
//  租哪儿
//
//  Created by 袁武昌 on 16/4/27.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import "ZNRUserIcon.h"

@implementation ZNRUserIcon

- (void)awakeFromNib
{
    // 设置边框宽度
    self.layer.borderWidth = 1.0;
    // 设置边框颜色
    self.layer.borderColor = [UIColor redColor].CGColor;
    
    // 设置圆角半径
    self.layer.cornerRadius = self.frame.size.width * 0.5;
    self.layer.masksToBounds = YES;
}


@end
