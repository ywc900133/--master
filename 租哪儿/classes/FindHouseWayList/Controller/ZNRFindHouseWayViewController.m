//
//  ZNRFindHouseWayViewController.m
//  租哪儿
//
//  Created by yuan on 16/4/6.
//  Copyright © 2016年 zunars. All rights reserved.
//



#import "ZNRFindHouseWayViewController.h"
#import "UIView+ZNRFrame.h"
#import "ZNRChooseBtn.h"

#import "ZNRAllViewController.h"
#import "ZNRMapViewViewController.h"

#import "UIBarButtonItem+ZNRItem.h"
@interface ZNRFindHouseWayViewController ()
/** 筛选栏*/
@property (nonatomic, strong)UIView *chooseView;


/** 被点击的按钮 */
@property (nonatomic, weak) UIButton *clickedTitleButton;
// 记录上一个选中按钮
@property (nonatomic, weak) UIButton *selectButton;

/** 所有按钮的数组 */
@property(nonatomic ,strong) NSMutableArray<UIButton *> *titleBtns;

@end

@implementation ZNRFindHouseWayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //背景颜色
    self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    
    // 初始化子控制器
    [self setUpNavigation];
    // 筛选栏
    [self setupChooseView];
    
    // 初始化子控制器
    [self setupChildVc];
    
    //    监听通知
    [self addObserverNotificationCenter];
    
   
}
#pragma mark//    导航条相关**********************************
- (void)setUpNavigation
{
    // 设置地图切换按钮
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:[UIImage imageNamed:@"tabbar_home_highlighted"] selImage:[UIImage imageNamed:@"tabbar_me_highlighted"] target:self action:@selector(backMap:)];
}
//导航条按钮点击监听
- (void)backMap:(UIButton *)btn
{
    btn.selected = !btn.selected;
    NSLog(@"%zd",btn.selected);
    NSLog(@"%@",self.title);
}



#pragma mark//    监听通知**********************************

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
//区域按钮的控制器列表TableView监听通知
- (void)districtNoti:(NSNotification *)noti
{
    
    [self.childViewControllers[1].view removeFromSuperview];
    // 1.从通知当中取出数据
    ZNRDistrict *district = noti.userInfo[ZNRDistrictNotificationKey];
    NSString *districtStr = noti.userInfo[ZNRSubDistrictNotificationKey];
    
    [_selectButton setTitle:districtStr forState:UIControlStateNormal];
    if ([district.name isEqualToString:@"全部"]) {
        [_selectButton setTitle:@"区域" forState:UIControlStateNormal];
        [_selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else if ([districtStr isEqualToString:@"全部"] || districtStr==nil ){
        [_selectButton setTitle:district.name forState:UIControlStateNormal];
        [_selectButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }else{
    
        [_selectButton setTitle:districtStr forState:UIControlStateNormal];
        [_selectButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    
    
}

//租金按钮的控制器自定义监听通知
- (void)renFootViewCertainBtnClick:(NSNotification *)note
{
    [self.childViewControllers[2].view removeFromSuperview];
    
    [_selectButton setTitle:@"自定义" forState:UIControlStateNormal];
    [_selectButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
}
//租金按钮的控制器TableView监听通知
- (void)rentTableViewClick:(NSNotification *)note
{
    
    [self.childViewControllers[2].view removeFromSuperview];
    
    ZNRRentTableViewController * RentTableVc= note.object;
    NSString *rentTableTiltle = RentTableVc.rentArr[RentTableVc.rentIndexPath.row];
    if ([rentTableTiltle isEqualToString:@"不限"]) {
        [_selectButton setTitle:@"租金" forState:UIControlStateNormal];
        [_selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else{
        
        [_selectButton setTitle:rentTableTiltle forState:UIControlStateNormal];
        [_selectButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    
    
    
}
//户型按钮的控制器TableView监听通知
- (void)UserTypeTableViewClick:(NSNotification *)note
{
    [self.childViewControllers[3].view removeFromSuperview];
    ZNRUserTypeTableViewController *userTypeTableVc = note.object;
    NSString *userTypeTableTitle = userTypeTableVc.userTypeArr[userTypeTableVc.selecetIndexPath.row];
    if ([userTypeTableTitle isEqualToString:@"不限"]) {
        [_selectButton setTitle:@"户型" forState:UIControlStateNormal];
        [_selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else{
        
        [_selectButton setTitle:userTypeTableTitle forState:UIControlStateNormal];
        [_selectButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    }
    
    
   
    
}
//筛选户型确认按钮的控制器监听通知
- (void)confirmBtnClick:(NSNotification *)note
{
   
    [self.childViewControllers[4].view removeFromSuperview];
    [_selectButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    
    
}
//筛选户型重置按钮的控制器监听通知
- (void)replaceBtnClick:(NSNotification *)note
{
    
    [self.childViewControllers[4].view removeFromSuperview];
    [_selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
}

#pragma mark*********控制器相关*****************************

- (void)viewWillDisappear:(BOOL)animated
{
    [self.childViewControllers[1].view removeFromSuperview];
    [self.childViewControllers[2].view removeFromSuperview];
    [self.childViewControllers[3].view removeFromSuperview];
    [self.childViewControllers[4].view removeFromSuperview];
   
}

// 初始化子控制器
- (void)setupChildVc
{
    if (![self.title isEqualToString:@"地图"]) {
        // 初始化子控制器
        [self addChildViewController:[[ZNRAllViewController alloc] init]];
    }else
    {
        [self addChildViewController:[[ZNRMapViewViewController alloc] init]];
    }
    
    [self addChildViewController:[[ZNRregionViewController alloc] init]];
    [self addChildViewController:[[ZNRRentTableViewController alloc] init]];
    [self addChildViewController:[[ZNRUserTypeTableViewController alloc] init]];
    [self addChildViewController:[[ZNRSiftViewController alloc] init]];
    
    
    // 添加对应的子控制器view到scrollView上面
    UIViewController *childVc = self.childViewControllers[0];
    childVc.view.frame = CGRectMake(0, 108, self.view.width, self.view.height - 108);
    // 如果这个子控制器view已经显示在上面, 就直接返回
    if (childVc.view.superview) return;
    
    [self.view addSubview:childVc.view];
    
    
    
}
#pragma mark*********筛选栏相关*****************************
// 添加筛选栏
- (void)setupChooseView
{
    UIView *chooseView = [[UIView alloc] init];
    chooseView.backgroundColor = [UIColor whiteColor];
    chooseView.frame = CGRectMake(0, 64, self.view.width, 44);
    [self.view addSubview:chooseView];
    _chooseView = chooseView;
    // 标题按钮
    [self setupChooseButtons];
    
}
// 标题按钮
- (void)setupChooseButtons
{
    // 文字
    NSArray *titles = @[@"区域", @"租金", @"户型", @"筛选"];
    NSUInteger count = titles.count;
    // 标题的宽高
    CGFloat titleW = self.view.width / count;
    
    CGFloat titleH = self.chooseView.height;
    
    for (NSUInteger i = 0; i < count; i++) {
        // 创建添加
        ZNRChooseBtn *chooseButton = [ZNRChooseBtn buttonWithType:UIButtonTypeCustom];
        chooseButton.tag = i;
        [chooseButton addTarget:self action:@selector(ChoosetitleClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.chooseView addSubview:chooseButton];
        
        // frame
        CGFloat titleX = titleW * i;
        chooseButton.frame = CGRectMake(titleX, 0, titleW, titleH);
        
        // 数据
        [chooseButton setTitle:titles[i] forState:UIControlStateNormal];
        [chooseButton setImage:[UIImage imageNamed:@"YellowDownArrow"] forState:UIControlStateNormal];
        
        //添加左右分隔线
        if (i != 0) {
            UIView * cellLine = [[UIView alloc] init];
            cellLine.backgroundColor = [UIColor grayColor];
            cellLine.frame = CGRectMake(titleX, 5, 1, titleH - 10);
            [self.chooseView addSubview:cellLine];
        }
        
    }
    //添加下分隔线
    UIView * separateline = [[UIView alloc] init];
    separateline.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    separateline.frame = CGRectMake( 0, titleH - 1, self.chooseView.width, 1);
    [self.chooseView addSubview:separateline];

    
}
/**
 *  监听标题按钮点击
 */
- (void)ChoosetitleClick:(UIButton *)titleButton
{
   self.clickedTitleButton = titleButton;
    if (titleButton.state == titleButton.selected) {
        
        // 1.让标题按钮选中
        [self selectTitleButton:titleButton];
        if (titleButton.tag == 0) {
            UIViewController *childVc = self.childViewControllers[1];
            // 如果这个子控制器view已经显示在上面, 就直接返回
            if (childVc.view.superview) return;
            [self.view addSubview:childVc.view];
    
            childVc.view.frame = CGRectMake(0, 104, self.view.width , 300);
            
            
//            childVc.view.backgroundColor = [UIColor redColor];
           
            
        }else if(titleButton.tag == 1)
        {
            NSLog(@"租金");
            UIViewController *childVc = self.childViewControllers[2];
            // 如果这个子控制器view已经显示在上面, 就直接返回
            if (childVc.view.superview) return;
            [self.view addSubview:childVc.view];

            childVc.view.frame = CGRectMake(0, 104, self.view.width, 300);
            
        }else if (titleButton.tag == 2)
        {
            NSLog(@"户型");
            
            UIViewController *childVc = self.childViewControllers[3];
            // 如果这个子控制器view已经显示在上面, 就直接返回
            if (childVc.view.superview) return;
            [self.view addSubview:childVc.view];
                        childVc.view.backgroundColor = [UIColor grayColor];
            childVc.view.frame = CGRectMake(0, 104, self.view.width, 217);

            
        }else if (titleButton.tag == 3)
        {
            NSLog(@"筛选");
            
            UIViewController *childVc = self.childViewControllers[4];
            // 如果这个子控制器view已经显示在上面, 就直接返回
            if (childVc.view.superview) return;
            [self.view addSubview:childVc.view];
            childVc.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
            childVc.view.frame = CGRectMake(0, 104, self.view.width, 400);
            
        }

    }else{
        [self normalTitleButton:titleButton];
         [self.childViewControllers[1].view removeFromSuperview];
        [self.childViewControllers[2].view removeFromSuperview];
        [self.childViewControllers[3].view removeFromSuperview];
        [self.childViewControllers[4].view removeFromSuperview];
       
    }
    
    
}
// 5.1 选中按钮
- (void)selectTitleButton:(UIButton *)btn
{
    // 恢复上一个按钮颜色
//    [_selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // 恢复上一个形变
//    _selectButton.transform = CGAffineTransformIdentity;
     btn.selected = !btn.selected;
    // 设置当前选中按钮的颜色
//    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
//    CGFloat titleScale = 1.3;
    // 设置标题缩放
//    btn.transform = CGAffineTransformMakeScale(titleScale, titleScale);
    
    // 记录当前选中的按钮
    _selectButton = btn;
    
    
}
// 5.1 恢复选中按钮
- (void)normalTitleButton:(UIButton *)btn
{
    btn.selected = NO;
    // 恢复上一个按钮颜色
//    [_selectButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // 恢复上一个形变
//    _selectButton.transform = CGAffineTransformIdentity;
    
    // 恢复上一个按钮颜色
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    // 恢复上一个形变
//    btn.transform = CGAffineTransformIdentity;
    // 记录当前选中的按钮
    _selectButton = btn;
}

@end
