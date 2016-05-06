
//
//  ZNRregionViewController.m
//  租哪儿
//
//  Created by yuan on 16/4/7.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import "ZNRregionViewController.h"
#import <MJExtension/MJExtension.h>
#import "ZNRLRTableView.h"
#import "ZNRDistrictBtn.h"
#define  screenW [UIScreen mainScreen].bounds.size.width

@interface ZNRregionViewController ()<ZNRLRTableViewDatasource,ZNRLRTableViewDelegate>
/** 区域数据*/
@property(nonatomic ,strong) NSArray *districtData;
/**选中的区域的类型*/
@property(nonatomic,strong)ZNRDistrictBtn *selectBtn;
/**lrTableView的宽度*/
@property (nonatomic,assign)CGFloat titleW;

/**lrTableView*/
@property (nonatomic, strong)ZNRLRTableView *lrTableView;
/**区域的类型按钮数组*/
@property(nonatomic,strong)NSMutableArray *districtBtnArr;

@end

@implementation ZNRregionViewController
/**
 *懒加载区域的类型按钮数组
 */
- (NSMutableArray *)districtBtnArr
{
    if (_districtBtnArr == nil) {
        _districtBtnArr = [NSMutableArray array];
    }
    return _districtBtnArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 1.设置背景颜色
    self.view.backgroundColor = [UIColor whiteColor];
    
    //2. 添加商圈和地铁按钮
    [self setupDistrictBtn];
    
    //3.初始化LRTableView
    [self setupLRTableView];
   

}

//View布局完成
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.titleW = self.view.width *0.5;
    
    CGFloat titleH = 44;
    for (ZNRDistrictBtn *btn in self.districtBtnArr) {
        CGFloat titleX = titleH * btn.tag;
        btn.frame = CGRectMake(0, titleX, self.titleW, titleH);
    }
    
    _lrTableView.frame = CGRectMake(screenW *0.5, 0, screenW *0.5, 300);
    self.lrTableView.leftTableView.width = screenW;
    self.lrTableView.rightTableView.width = 0;

}


- (void)setupDistrictBtn
{
    // 文字
    NSArray *districtTitle = @[@"商圈", @"地铁"];
    NSUInteger count = districtTitle.count;
    // 标题的宽高
    self.titleW = screenW *0.5;
     ;
    CGFloat titleH = 44;
    
    for (NSUInteger i = 0; i < count; i++) {
        // 创建添加
       ZNRDistrictBtn *districtBtn = [ZNRDistrictBtn buttonWithType:UIButtonTypeCustom];
        districtBtn.tag = i;
       [districtBtn addTarget:self action:@selector(districtBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:districtBtn];
        // frame
        CGFloat titleX = titleH * i;
        
        districtBtn.frame = CGRectMake(0, titleX, self.titleW, titleH);
        
        // 数据
        [districtBtn setTitle:districtTitle[i] forState:UIControlStateNormal];
        [self.districtBtnArr addObject:districtBtn];
        
        
        if (i == 0) {
            districtBtn.selected = YES;
             _selectBtn = districtBtn;
            [self districtBtnClick:_selectBtn];
        }
    }
}
//区域类型按钮监听
- (void)districtBtnClick:(ZNRDistrictBtn *)districtBtn
{

    if (_selectBtn == districtBtn) {
        _selectBtn.selected = YES;
    }else{
        _selectBtn.selected = NO;
        districtBtn.selected = YES;
        _selectBtn = districtBtn;
    }
    
    self.titleW = self.view.width *0.5;
    
    CGFloat titleH = 44;
    for (ZNRDistrictBtn *btn in self.districtBtnArr) {
        CGFloat titleX = titleH * btn.tag;
        btn.frame = CGRectMake(0, titleX, self.titleW, titleH);
    }
    self.lrTableView.frame = CGRectMake(screenW *0.5, 0, screenW - screenW *0.5, 300);
    self.lrTableView.leftTableView.width = screenW;
    self.lrTableView.rightTableView.width = 0;
    
    if ([districtBtn.titleLabel.text isEqualToString: @"商圈"]) {
        
        NSLog(@"商圈");
       
        
        
    }else if([districtBtn.titleLabel.text isEqualToString: @"地铁"])
    {
        NSLog(@"地铁");
        
    }
}
//添加区域列表
- (void)setupLRTableView
{
    ZNRLRTableView *lrTableView = [ZNRLRTableView lrTableView];

    lrTableView.frame = CGRectMake(screenW *0.5, 0, screenW - screenW *0.5, 300);
    
    [self.view addSubview:lrTableView];
    _lrTableView = lrTableView;
    // 2.设置数据源
    lrTableView.datasource = self;
    
    // 3.设置代理
    lrTableView.delegate = self;
    
}
#pragma mark - 懒加载
- (NSArray *)districtData
{
    if (_districtData == nil) {
        _districtData = [ZNRDistrict mj_objectArrayWithFilename:@"gz.plist"];
    }
    return _districtData;
}

#pragma mark - ZNRLRTableViewDatasource
- (NSInteger)numOfRowsInLeftRow:(ZNRLRTableView *)lrTableView
{
    return self.districtData.count;
}

- (NSString *)lrTableView:(ZNRLRTableView *)lrTableView titleInLeftRow:(NSInteger)leftRow
{
    // 1.取出数据模型
    ZNRDistrict *district = self.districtData[leftRow];
    
    // 2.返回数据
    return district.name;
}

- (NSArray *)lrTableView:(ZNRLRTableView *)lrTableView subDataInLeftRow:(NSInteger)leftRow
{
    // 1.取出数据模型
    ZNRDistrict *district = self.districtData[leftRow];
    
    // 2.返回数据
    return district.subregions;
}

#pragma mark - ZNRLRTableViewDelegate
- (void)lrTableView:(ZNRLRTableView *)lrTableView selectedLeftRow:(NSInteger)leftRow
{
    // 1.取出数据模型
    ZNRDistrict *district = self.districtData[leftRow];

    self.titleW = screenW *0.25;
    
    CGFloat titleH = 44;
    
    for (ZNRDistrictBtn *btn in self.districtBtnArr) {
        CGFloat titleX = titleH * btn.tag;
        btn.frame = CGRectMake(0, titleX, self.titleW, titleH);
    }
    self.lrTableView.frame = CGRectMake(screenW *0.25, 0, screenW - screenW *0.25, 300);
    self.lrTableView.leftTableView.frame = CGRectMake(0, 0,self.lrTableView.width *0.5, 300);
//
    self.lrTableView.rightTableView.frame = CGRectMake(self.lrTableView.width *0.5, 0,self.lrTableView.width *0.5, 300);
    
    // 2.判断是否有子数据
    if (district.subregions.count == 0) { // 没有子数据
        NSDictionary *dict = @{ZNRDistrictNotificationKey : district};
        [[NSNotificationCenter defaultCenter] postNotificationName:ZNRDistrictNotification object:nil userInfo:dict];
    }
}

- (void)lrTableView:(ZNRLRTableView *)lrTableView selectedLeftRow:(NSInteger)leftRow selectedRightRow:(NSInteger)rightRow
{
    // 1.取出数据模型
    ZNRDistrict *district = self.districtData[leftRow];
    NSString *districtStr = district.subregions[rightRow];
    
    // 2.发送通知
    NSDictionary *dict = @{ZNRDistrictNotificationKey : district,
                           ZNRSubDistrictNotificationKey : districtStr};
    [[NSNotificationCenter defaultCenter] postNotificationName:ZNRDistrictNotification object:nil userInfo:dict];
}

@end
