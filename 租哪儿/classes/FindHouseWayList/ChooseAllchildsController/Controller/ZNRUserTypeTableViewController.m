
//
//  ZNRUserTypeTableViewController.m
//  租哪儿
//
//  Created by yuan on 16/4/7.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import "ZNRUserTypeTableViewController.h"
#import "ZNRUserTypeCell.h"
@interface ZNRUserTypeTableViewController ()

@end

@implementation ZNRUserTypeTableViewController

static NSString * const ZNRUserTypeCellId = @"userTypeCellId";
/*
 *懒加载
 */
- (NSArray *)userTypeArr
{
    if (_userTypeArr == nil) {
        _userTypeArr = @[@"不限",@"一居",@"二居",@"三居",@"四居及以上"];
    }
    return _userTypeArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass ([ZNRUserTypeCell class]) bundle:nil] forCellReuseIdentifier:ZNRUserTypeCellId];
    
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.userTypeArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZNRUserTypeCell *cell = [tableView dequeueReusableCellWithIdentifier:ZNRUserTypeCellId];
    cell.userTypeLabel.text = self.userTypeArr[indexPath.row];
    
    return cell;
}
//点击cell的时候调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    self.selecetIndexPath = indexPath;

    //发布通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"UserTypeTableViewClickNotification" object:self];
    
}


@end
