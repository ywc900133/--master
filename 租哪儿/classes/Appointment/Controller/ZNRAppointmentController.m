
//
//  ZNRAppointmentController.m
//  租哪儿
//
//  Created by yuan on 16/4/7.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import "ZNRAppointmentController.h"
#import "ZNRLoginViewController.h"
#import "ZNRSaveTool.h"
@interface ZNRAppointmentController()
/**登录控制器*/
@property(nonatomic,strong)ZNRLoginViewController *loginVc;
/**是否登录属性*/
@property(nonatomic,assign)BOOL isLogin;
@end
@implementation ZNRAppointmentController

static NSString *userIsLogin =@"isLogin";
/*
 *懒加载
 **/
- (ZNRLoginViewController *)loginVc
{
    if (_loginVc == nil) {
        _loginVc = [[ZNRLoginViewController alloc] init];
        
    }
    return _loginVc;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    UILabel *lable = [[UILabel alloc]init];
    lable.backgroundColor = [UIColor redColor];
    lable.frame = CGRectMake(100, 100, 200, 100);
    lable.text = @"您的预约申请";
    
    [self.view addSubview:lable];
//    初始化
    [self setupView];
//  接受通知
    [self receiveNotification];
   
}
//    初始化
- (void)setupView
{
    [self addChildViewController:self.loginVc];
    self.view.backgroundColor = [UIColor orangeColor];
    _isLogin = [ZNRSaveTool boolForKey:userIsLogin];
    if (!_isLogin) {
        [self.view addSubview:self.loginVc.view];
    }
}
//  接受通知
- (void)receiveNotification
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(backLoginButtonClick) name:@"backLoginButtonClickNotification" object:nil];
    [center addObserver:self selector:@selector(getPostAccountData:) name:@"postAccountDataNotification" object:nil];
}
//监听退出登录按钮点击通知调用方法
- (void)backLoginButtonClick
{
    if (![ZNRSaveTool boolForKey:userIsLogin]) {
        
       [self.view addSubview:self.loginVc.view];
        
    }
}
//监听用户注册或登录成功通知调用方法
- (void)getPostAccountData:(NSNotification *)note
{
    [self.loginVc.view removeFromSuperview];
}
//移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


@end
