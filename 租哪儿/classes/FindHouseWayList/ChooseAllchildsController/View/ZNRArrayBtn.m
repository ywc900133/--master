//
//  ZNRArrayBtn.m
//  租哪儿
//
//  Created by yuan on 16/4/7.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import "ZNRArrayBtn.h"

@implementation ZNRArrayBtn

- (void)layoutSubviews
{
    [super layoutSubviews];
        if (self.selected == YES) {
        [self setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        self.imageView.hidden = NO;
    }else if (self.selected == NO){
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.imageView.hidden = YES;
    }
}
/**
 *  去除高亮状态下的所有操作
 */
- (void)setHighlighted:(BOOL)highlighted { }

@end
