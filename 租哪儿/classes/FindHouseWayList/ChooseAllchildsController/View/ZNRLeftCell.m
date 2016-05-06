//
//  ZNRLeftCell.m
//  租哪儿
//
//  Created by 袁武昌 on 16/4/20.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import "ZNRLeftCell.h"

@implementation ZNRLeftCell


+ (instancetype)leftCellWithTableView:(UITableView *)tableView
{
    static NSString *leftCell = @"leftCell";
    ZNRLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:leftCell];
    if (!cell) {
        cell = [[ZNRLeftCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:leftCell];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dropdown_leftpart"]];
        self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dropdown_left_selected"]];
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (self.selected == YES) {
        self.textLabel.textColor = [UIColor redColor];
    }else{
        self.textLabel.textColor = [UIColor blackColor];
    }
}

@end
