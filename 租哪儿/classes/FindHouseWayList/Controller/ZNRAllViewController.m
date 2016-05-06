//
//  ZNRAllViewController.m
//  租哪儿
//
//  Created by yuan on 16/4/6.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import "ZNRAllViewController.h"
#import "ZNRAllTableViewCell.h"
#import "ZNRHouseDetailsViewController.h"

#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import <SDImageCache.h>

#import "ZNRRomes.h"
@interface ZNRAllViewController ()
/**房源数组*/
@property(nonatomic ,strong)NSMutableArray<ZNRRomes*> *romesArray;
/**轻触加载更多View*/
@property (nonatomic, weak)UIView *tableFootView;
/**网络请求参数*/
@property(nonatomic,strong)NSMutableDictionary *parameters;
/** 区域控制器*/
@property(nonatomic,weak)ZNRregionViewController *regionVc;
/** 区域的Item*/
@property (nonatomic, weak) UIBarButtonItem *districtItem;

@property (nonatomic,weak)UIButton *tableFootBtn;
@property(nonatomic,assign)NSInteger pageIndex;
@end
@implementation ZNRAllViewController
static NSString * const ZNRAllCellId = @"allCellId";
/*
 *懒加载
 */
- (NSMutableDictionary *)parameters
{
    if (_parameters == nil) {
        _parameters = [NSMutableDictionary dictionary];
    }
    return _parameters;
}
- (NSMutableArray<ZNRRomes *> *)romesArray
{
    if (_romesArray == nil) {
        _romesArray = [NSMutableArray array];
    }
    return _romesArray;
}
- (void)viewDidLoad
{
    [super viewDidLoad];

     //    注册cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZNRAllTableViewCell class]) bundle:nil] forCellReuseIdentifier:ZNRAllCellId];
    
    
    //数据请求
    [self loadData];
    //加载更多
    [self setuptableFootView];
    
     //监听通知
    [self addObserverNotificationCenter];
    
    _pageIndex = 1;
    
}

#pragma mark***********//监听通知***********************

//    监听通知
- (void)addObserverNotificationCenter
{
    //    监听通知
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(confirmBtnClick:) name:@"confirmBtnClickNotification" object:nil];
    [center addObserver:self selector:@selector(replaceBtnClick:) name:@"replaceBtnClickNotification" object:nil];
    [center addObserver:self selector:@selector(UserTypeTableViewClick:) name:@"UserTypeTableViewClickNotification" object:nil];
    [center addObserver:self selector:@selector(rentTableViewClick:) name:@"rentTableViewClickNotification" object:nil];
    [center addObserver:self selector:@selector(renFootViewCertainBtnClick:) name:@"renFootViewCertainBtnClickNotification" object:nil];
    [center addObserver:self selector:@selector(districtNoti:) name:ZNRDistrictNotification object:nil];
    
}
//移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)districtNoti:(NSNotification *)noti
{
    // 1.从通知当中取出数据
    ZNRDistrict *district = noti.userInfo[ZNRDistrictNotificationKey];
    NSString *districtStr = noti.userInfo[ZNRSubDistrictNotificationKey];
//    NSLog(@"%@,%@",district.name,districtStr);

}


//自定义租金按钮通知监听
- (void)renFootViewCertainBtnClick:(NSNotification *)note
{
    self.romesArray = nil;
    ZNRRenFootView *renFootView = note.object;

        // 拼接请求参数
        self.parameters[@"pl"] = renFootView.lowPayTextF.text;
        self.parameters[@"ph"] = renFootView.hightPayTextF.text;
    //数据请求
    [self loadAllData:self.parameters];
}
//选择租金cell通知监听
- (void)rentTableViewClick:(NSNotification*)note
{
    self.romesArray = nil;
    ZNRRentTableViewController *rentTableVc = note.object;
    
    //拼接请求参数
   
    NSString *rentstr = rentTableVc.rentArr[rentTableVc.rentIndexPath.row];

    if ([rentstr isEqualToString:@"不限"]) {
        self.parameters[@"pl"] = nil;
        self.parameters[@"ph"] = nil;
    }else if ([rentstr isEqualToString:@"10000元以上"])
    {
        self.parameters[@"pl"] = @(10000);
        self.parameters[@"ph"] = nil;
        
    }else{
    NSString *payLow;
    NSString *payHight;
    
   NSArray *arr =  [rentstr componentsSeparatedByString:@"-"];
    
        payLow = arr[0];
        payHight = [arr[1] stringByReplacingOccurrencesOfString:@"元" withString:@""];
        self.parameters[@"pl"] = payLow;
        self.parameters[@"ph"] = payHight;
    }
    //数据请求
    [self loadAllData:self.parameters];
}
//选择户型cell通知监听
- (void)UserTypeTableViewClick:(NSNotification*)note
{
    self.romesArray = nil;
    ZNRUserTypeTableViewController *userTypeTableVC = note.object;
    
   self.parameters[@"be"] = @(userTypeTableVC.selecetIndexPath.row);
  //数据请求
  [self loadAllData:self.parameters];
}
//筛选确定按钮通知监听
- (void)confirmBtnClick:(NSNotification *)note
{
    self.romesArray = nil;
    ZNRSiftViewController *siftViewController = note.object;
    
   //既有整租也有合租
    BOOL rememberSelectBtnAndTogetherRentBtn = siftViewController.allRentBtn.selected == YES && siftViewController.togetherRentBtn.selected == YES;
    //    既没有整租也没有合租
    BOOL notRememberSelectBtnAndTogetherRentBtn = siftViewController.allRentBtn.selected == NO && siftViewController.allRentBtn.selected == NO;
    
    if (rememberSelectBtnAndTogetherRentBtn || notRememberSelectBtnAndTogetherRentBtn ) {
        self.parameters[@"r"] = nil;
    }else{
        
        if (siftViewController.allRentBtn.selected == YES) {
            self.parameters[@"r"] = @(1);
        }else{
        
            self.parameters[@"r"] = @(2);
            
        }
       
    }
    if (siftViewController.weChatBtn.selected == YES) {
        self.parameters[@"w"] = @(1);
    }else{
        self.parameters[@"w"] = @(0);
    }
    if (siftViewController.realyNameBtn.selected == YES) {
        self.parameters[@"i"] = @(1);
    }else{
        self.parameters[@"i"] = @(0);
    }
    if (siftViewController.defaultBtn.selected == YES) {
        self.parameters[@"o"] = @(0);
    }else if (siftViewController.lowBtn.selected == YES)
    {
        self.parameters[@"o"] = @(1);
    }else if (siftViewController.hightBtn.selected == YES)
    {
        self.parameters[@"o"] = @(2);
    }
    //数据请求
    [self loadAllData:self.parameters];
    
}
//重置按钮点击通知监听
- (void)replaceBtnClick:(NSNotification *)note
{
    self.romesArray = nil;
    //数据请求
    [self loadAllData:nil];
    
}

#pragma mark***********//数据请求***********************
- (void)loadData
{
    // 拼接请求参数
    self.parameters[@"r"] = @(1);
    [self loadAllData:self.parameters];
    
}


//数据请求
- (void)loadAllData:(NSMutableDictionary *)parameters
{
    
    // AFN发送请求
    // 1.创建请求会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
   
    // 2.发送网络请求
    [manager GET:@"https://www.zunars.com/room/fetch_room_list?" parameters:self.parameters success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary* _Nullable responseObject) {
        
        NSMutableArray *arr = [NSMutableArray array];
        
        arr = [ZNRRomes mj_objectArrayWithKeyValuesArray:responseObject[@"rooms"]];
        if (arr.count == 20) {
            [self.tableFootBtn setTitle:@"轻触加载更多" forState:UIControlStateNormal];
        
            
            
            
        }else{
            [self.tableFootBtn setTitle:@"没有更多房源啦~" forState:UIControlStateNormal];
        }
        for (int i = 0; i < arr.count; i++) {
            ZNRRomes *room = [[ZNRRomes alloc]init];
            room = arr[i];
            [self.romesArray addObject:room];
            
        }
//        刷新数据
        [self.tableView reloadData];
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败回调
        NSLog(@"%@",error);
        
    }];
}
#pragma mark***********Table view data source******************

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.romesArray.count;
    
   
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZNRAllTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ZNRAllCellId];
    cell.romes = self.romesArray[indexPath.row];
     return cell;
    
}
//返回cell的高度
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
#pragma mark***********轻触加载更多*************************
- (void)setuptableFootView
{
    UIView *tableFootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.width, 44)];
    //    tableFootView.backgroundColor = [UIColor redColor];
    self.tableView.tableFooterView = tableFootView;
    _tableFootView = tableFootView;
 
    UIButton *tableFootBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    tableFootBtn.frame = tableFootView.bounds;
    [tableFootBtn setTitle:@"轻触加载更多" forState:UIControlStateNormal];
    [tableFootBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [tableFootBtn setBackgroundColor:[UIColor orangeColor]];
    [tableFootBtn addTarget:self action:@selector(loadMoreData:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableFootView addSubview:tableFootBtn];
    _tableFootBtn = tableFootBtn;
}

- (void)loadMoreData:(UIButton *)Btn
{
    self.pageIndex++;
    [self.tableFootBtn setTitle:@"加载中..." forState:UIControlStateNormal];
    
    self.parameters[@"p"] = @(self.pageIndex);
  
        // 3.调用控制的加载数据方法
        [self loadAllData:self.parameters];
    
}

@end
