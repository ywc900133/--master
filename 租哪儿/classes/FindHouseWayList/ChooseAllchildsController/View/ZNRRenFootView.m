//
//  ZNRRenFootView.m
//  租哪儿
//
//  Created by yuan on 16/4/7.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import "ZNRRenFootView.h"
@interface ZNRRenFootView ()


@end
@implementation ZNRRenFootView
//确定按钮点击
- (IBAction)certainBtn:(UIButton *)sender {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"renFootViewCertainBtnClickNotification" object:self];
    
}

//加载xib
+ (instancetype)rentFootView
{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    
}

@end
