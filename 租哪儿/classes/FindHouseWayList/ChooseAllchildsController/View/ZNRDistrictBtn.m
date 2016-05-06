//
//  ZNRDistrictBtn.m
//  租哪儿
//
//  Created by 袁武昌 on 16/4/20.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import "ZNRDistrictBtn.h"

@implementation ZNRDistrictBtn

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [self setBackgroundImage:[UIImage imageNamed:@"bg_dropdown_leftpart"] forState:UIControlStateSelected];
    
}
/**
 *  去除高亮状态下的所有操作
 */
- (void)setHighlighted:(BOOL)highlighted { }
@end
