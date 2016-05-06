//
//  ZNRHouseDetailsViewController.m
//  租哪儿
//
//  Created by yuan on 16/4/6.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import "ZNRHouseDetailsViewController.h"
#import "ZNRDetailDataViewController.h"
#import "ZNRContactHostViewController.h"
@interface ZNRHouseDetailsViewController ()
/**底部backScrollerView*/
@property(nonatomic,strong)UIScrollView *backScrollerV;
/** 设置加入清单和联系房东按钮*/
@property (nonatomic,strong)UIView *listAndContactV;
/**加入清单按钮*/
@property (nonatomic,strong)UIButton *addListBtn;

@end

@implementation ZNRHouseDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor orangeColor];
 
//    1.设置导航条
    [self setupNavigation];
//    2.设置backScrollerView
    [self setupBackScrollerV];
//    3.设置pageScrollerView
    [self setupPageScrollerV];
//    4.设置详情数据
    [self setupDetailDataV];
//      5.设置加入清单和联系房东按钮
    [self setupAddListAndContactHostV];
    
    
}
//    1.设置导航条
- (void)setupNavigation
{
    
}
//    2.设置backScrollerView
- (void)setupBackScrollerV
{
    UIScrollView *backScrollerV = [[UIScrollView alloc]init];
    backScrollerV.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    backScrollerV.backgroundColor = [UIColor grayColor];
    [self.view addSubview:backScrollerV];
    _backScrollerV = backScrollerV;
    backScrollerV.contentSize = CGSizeMake(self.view.width, 3300);
}

//    2.设置pageScrollerView
- (void)setupPageScrollerV
{
    UIScrollView *pageScrollerV = [[UIScrollView alloc]init];
    pageScrollerV.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    pageScrollerV.backgroundColor = [UIColor yellowColor];
    [self.backScrollerV addSubview:pageScrollerV];
    pageScrollerV.scrollEnabled = YES;
    pageScrollerV.contentSize = CGSizeMake(self.view.width *4, 300);
    
}
//    3.设置详情数据
- (void)setupDetailDataV
{
    [self addChildViewController: [[ZNRDetailDataViewController alloc]init]];
    UIViewController *childVc = self.childViewControllers[0];
    // 如果这个子控制器view已经显示在上面, 就直接返回
    if (childVc.view.superview) return;
    [self.backScrollerV addSubview:childVc.view];
    
    childVc.view.frame = CGRectMake(0, 300, self.view.width, 2400);
    
}
//      5.设置加入清单和联系房东按钮
- (void)setupAddListAndContactHostV
{
    UIView *listAndContactV = [[UIView alloc]init];
    listAndContactV.frame = CGRectMake(0, self.view.height-44, self.view.width, 44);
    listAndContactV.backgroundColor = [UIColor blueColor];
    [self.view addSubview:listAndContactV];
    _listAndContactV = listAndContactV;
//    加入清单按钮
    UIButton *addListBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addListBtn.frame = CGRectMake(0, 0, self.listAndContactV.width*0.33, self.listAndContactV.height);
    addListBtn.backgroundColor = [UIColor orangeColor];
    [addListBtn setTitle:@"加入的清单" forState:UIControlStateNormal];
    [addListBtn setImage:[UIImage imageNamed:@"FBMM_Barbutton"] forState:UIControlStateNormal];
    [addListBtn addTarget:self action:@selector(addListBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.listAndContactV addSubview:addListBtn];
    _addListBtn = addListBtn;
//    联系房东
    UIButton *contactHostBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    contactHostBtn.frame = CGRectMake(self.addListBtn.width, 0, self.listAndContactV.width - self.addListBtn.width, self.listAndContactV.height);
    contactHostBtn.backgroundColor = [UIColor orangeColor];
    [contactHostBtn setTitle:@"联系房东" forState:UIControlStateNormal];
    [contactHostBtn setImage:[UIImage imageNamed:@"FBMM_Barbutton"] forState:UIControlStateNormal];
    [contactHostBtn addTarget:self action:@selector(contactHostBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.listAndContactV addSubview:contactHostBtn];

    
    
    
}
//加入清单按钮点击监听
- (void)addListBtnClick:(UIButton *)btn
{
    NSLog(@"加入清单");
}
//联系房东按钮点击监听
- (void)contactHostBtnClick:(UIButton *)btn
{
    NSLog(@"联系房东");
    ZNRContactHostViewController *contactHostVc = [[ZNRContactHostViewController alloc] init];
    contactHostVc.title = @"预约看房";
    [self.navigationController pushViewController:contactHostVc animated:YES];
    
}

@end
