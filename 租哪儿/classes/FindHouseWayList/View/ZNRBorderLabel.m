//
//  ZNRBorderLabel.m
//  租哪儿
//
//  Created by 袁武昌 on 16/4/18.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import "ZNRBorderLabel.h"

@implementation ZNRBorderLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
       
        
        self.text = @"11111111";
       
        
       self.backgroundColor = [UIColor redColor];
        
        self.layer.borderColor = [[UIColor grayColor]CGColor];
        
        self.layer.borderWidth = 5;
        
        self.layer.masksToBounds = YES;
        
//        self.backgroundColor = [UIColor redColor];
//        self.layer.borderColor = [UIColor greenColor].CGColor;
//        self.layer.borderWidth = 3;
//        
//        
//        
//        self.layer.masksToBounds = YES;
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    

    
    self.layer.borderColor = self.textColor.CGColor;
    
    self.layer.borderWidth = 1;
    
    self.layer.masksToBounds = YES;
}

@end
