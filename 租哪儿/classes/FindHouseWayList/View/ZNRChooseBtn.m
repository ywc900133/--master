
//
//  ZNRChooseBtn.m
//  租哪儿
//
//  Created by yuan on 16/4/6.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import "ZNRChooseBtn.h"
#import "UIView+ZNRFrame.h"
@implementation ZNRChooseBtn
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    self.imageEdgeInsets = UIEdgeInsetsMake(0, self.titleLabel.width, 0, -self.titleLabel.width);
    self.titleEdgeInsets  = UIEdgeInsetsMake(0, -self.imageView.width, 0, self.imageView.width);
    
}

/**
 *  去除高亮状态下的所有操作
 */
- (void)setHighlighted:(BOOL)highlighted { }
@end
