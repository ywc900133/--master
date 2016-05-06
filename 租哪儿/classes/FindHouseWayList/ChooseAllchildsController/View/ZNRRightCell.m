
//
//  ZNRRightCell.m
//  租哪儿
//
//  Created by 袁武昌 on 16/4/20.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import "ZNRRightCell.h"

@implementation ZNRRightCell

+ (instancetype)rightCellWithTableView:(UITableView *)tableView
{
    static NSString *righttCell = @"righttCell";
    ZNRRightCell *cell = [tableView dequeueReusableCellWithIdentifier:righttCell];
    if (!cell) {
        cell = [[ZNRRightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:righttCell];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dropdown_rightpart"]];
        self.selectedBackgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_dropdown_right_selected"]];
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
