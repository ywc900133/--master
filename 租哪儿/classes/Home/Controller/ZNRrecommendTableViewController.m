//
//  ZNRrecommendTableViewController.m
//  租哪儿
//
//  Created by yuan on 16/4/8.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import "ZNRrecommendTableViewController.h"
#import "ZNRHouseDetailsViewController.h"
#import "ZNRrecommendCell.h"
@interface ZNRrecommendTableViewController ()

@end

@implementation ZNRrecommendTableViewController
static NSString * const ZNRrecommendCellId = @"recommendCellId";
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZNRrecommendCell class]) bundle:nil] forCellReuseIdentifier:ZNRrecommendCellId];
    self.tableView.scrollEnabled = NO;
    
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZNRrecommendCell *cell = [tableView dequeueReusableCellWithIdentifier:ZNRrecommendCellId];
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 138;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZNRHouseDetailsViewController *detailsVC = [[ZNRHouseDetailsViewController alloc] init];
    detailsVC.title = @"房源详情";
    [self.navigationController pushViewController:detailsVC animated:YES];
    
}


@end
