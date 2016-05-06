
//
//  ZNRFindVTitleButton.m
//  租哪儿
//
//  Created by yuan on 16/4/6.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import "ZNRFindVTitleButton.h"
#import "UIView+ZNRFrame.h"
@implementation ZNRFindVTitleButton

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
    
    // 调整图片
    self.imageView.x = (self.width - self.imageView.width) * 0.5;
    self.imageView.y = 15;
    
    // 调整文字
    // 计算文字尺寸,设置文字宽度
    [self.titleLabel sizeToFit];
    self.titleLabel.x =(self.width - self.titleLabel.width) * 0.5;
    self.titleLabel.y = self.height - self.titleLabel.height - 15;
    
}


/**
 *  去除高亮状态下的所有操作
 */
- (void)setHighlighted:(BOOL)highlighted { }

@end
