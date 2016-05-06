
//
//  ZNRRentTableViewController.m
//  租哪儿
//
//  Created by yuan on 16/4/7.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import "ZNRRentTableViewController.h"
#import "ZNRRentTableViewCell.h"


@interface ZNRRentTableViewController ()<UITableViewDataSource,UITableViewDelegate>
/**
 租金的FootView
 */
@property (nonatomic ,strong)UIView * rentFootV;
/**
 租金的TableView
 */
@property(nonatomic,strong)UITableView *renTableView;

@end

@implementation ZNRRentTableViewController
static NSString * const ZNRRentCellId = @"rentCellId";
/**
 *懒加载
 */
- (NSArray<NSString *> *)rentArr
{
    if (_rentArr == nil) {
        _rentArr = @[@"不限",
                     @"300- 600元",
                     @"600- 1000元",
                     @"1000- 1500元",
                     @"1500- 2000元",
                     @"2000- 3000元",
                     @"3000- 4000元",
                     @"4000- 5000元",
                     @"5000- 7000元",
                     @"7000- 10000元",
                     @"10000元以上"];
    }
    return _rentArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
     // 添加TableView
    [self setuprenTableView];
    
   
    
}
//    添加TableView
- (void)setuprenTableView
{
    UITableView *renTableView = [[UITableView alloc] init];
    renTableView.frame = CGRectMake(0, 0, self.view.width, 300);
    [self.view addSubview:renTableView];
    _renTableView = renTableView;
    //设置代理
    self.renTableView.delegate = self;
    self.renTableView.dataSource = self;
    //注册cell
    [self.renTableView registerNib:[UINib nibWithNibName:NSStringFromClass ([ZNRRentTableViewCell class]) bundle:nil] forCellReuseIdentifier:ZNRRentCellId];
    
    ZNRRenFootView * rentFootV = [ZNRRenFootView rentFootView];
    
    self.renTableView.tableFooterView = rentFootV;
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 11;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZNRRentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZNRRentCellId];
    cell.rentLabel.text = self.rentArr[indexPath.row];
    return cell;
}
//点击cell时调用
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{

    self.rentIndexPath = indexPath;
    
    //发布通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"rentTableViewClickNotification" object:self];
}


@end
