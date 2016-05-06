
//
//  ZNRMeController.m
//  租哪儿
//
//  Created by 袁武昌 on 16/4/25.
//  Copyright © 2016年 zunars. All rights reserved.
//
#import "ZNRrealNameCertifyViewController.h"
#import "ZNRaccountConttactTableViewController.h"
#import "ZNRmodifyPwdViewController.h"
#import "ZNRdiscountCouponViewController.h"
#import "ZNRCollectController.h"
#import "ZNRLoginViewController.h"

#import "ZNRMeController.h"


#import <UIImageView+WebCache.h>
#import "ZNRUserIcon.h"
#import "ZNRSaveTool.h"
@interface ZNRMeController ()
/**头像图片*/
@property (weak, nonatomic) IBOutlet ZNRUserIcon *avatar;

/**账号*/
@property (weak, nonatomic) IBOutlet UILabel *nickname;
/**用户数据模型*/
@property (nonatomic, strong)ZNRAccout *account;

/**登录控制器属性*/
@property(strong,nonatomic)ZNRLoginViewController *loginVc;
/**请登录注册*/
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

/**是否登录*/
@property(nonatomic,assign)BOOL isLogin;
@end


@implementation ZNRMeController
static NSString *userIsLogin =@"isLogin";
static NSString *ZNRAccountDictdata =@"ZNRAccountDict";

/*
 *懒加载
 **/
- (ZNRLoginViewController *)loginVc
{
    if (_loginVc == nil) {
        _loginVc = [[ZNRLoginViewController alloc] init];
        _loginVc.title = @"个人中心";
    }
    return _loginVc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//   初始化View
    [self setupView];
//    接收通知
    [self receiveNotification];
    
    
}
//   初始化View
- (void)setupView
{
    _isLogin = [ZNRSaveTool boolForKey:userIsLogin];
    if (_isLogin) {
        [self getLocalAccountData];
        self.loginBtn.hidden = YES;
    }
    
}
//    接收通知
- (void)receiveNotification
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(getPostAccountData:) name:@"postAccountDataNotification" object:nil];
}
//监听用户注册或登录成功通知调用方法
- (void)getPostAccountData:(NSNotification *)note
{
    self.loginVc = note.object;
    
    _account =  self.loginVc.accountDict;
    [_avatar sd_setImageWithURL:[NSURL URLWithString:_account.avatar]];
    _nickname.text = _account.nickname;
    
    _loginBtn.hidden = YES;
}

//移除通知
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

//读取本地用户数据
- (void)getLocalAccountData
{
 NSDictionary *dict =  [ZNRSaveTool objectForKey:ZNRAccountDictdata];
    _account = [ZNRAccout accountWithDict:dict];
    
    [_avatar sd_setImageWithURL:[NSURL URLWithString:_account.avatar]];
    _nickname.text = _account.nickname;

}
/**登录按钮*/
- (IBAction)loginBtnClick {
    
    [self.navigationController pushViewController:self.loginVc animated:YES];
    
}
/**退出登录按钮*/
- (IBAction)backLogin:(id)sender {
    [ZNRSaveTool setBool:NO forKey:userIsLogin];
    _isLogin = NO;
    _loginBtn.hidden = NO;
    _avatar.image = [UIImage imageNamed:@"1"];
    _nickname.text = @"未登录";
    //发布通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"backLoginButtonClickNotification" object:nil];
}
//实名认证
- (IBAction)realNameCertify
{
    
    ZNRrealNameCertifyViewController *realNameCertifyVc = [[ZNRrealNameCertifyViewController alloc]init];
    realNameCertifyVc.title = @"实名认证";
    realNameCertifyVc.view.backgroundColor = [UIColor orangeColor];
    if (self.isLogin) {
        
        [self.navigationController pushViewController:realNameCertifyVc animated:YES];
    }else{
        [self.navigationController pushViewController:self.loginVc animated:YES];
    }
    
}
//账号绑定
- (IBAction)accountConttact {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:NSStringFromClass([ZNRaccountConttactTableViewController class]) bundle:nil];
    ZNRaccountConttactTableViewController *accountConttactVc = [storyboard instantiateInitialViewController];
    accountConttactVc.title = @"账号绑定";
    if (self.isLogin) {
        
        [self.navigationController pushViewController:accountConttactVc animated:YES];
    }else
    {
        [self.navigationController pushViewController:self.loginVc animated:YES];
    }
}
//修改密码
- (IBAction)modifyPwd {
    ZNRmodifyPwdViewController *modifyPwdVc = [[ZNRmodifyPwdViewController alloc]init];
    modifyPwdVc.title = @"修改密码";
    if (self.isLogin) {
        
        [self.navigationController pushViewController:modifyPwdVc animated:YES];
    }else{
        [self.navigationController pushViewController:self.loginVc animated:YES];
    }
}
//优惠券列表
- (IBAction)discountCoupon {
    ZNRdiscountCouponViewController *discountCouponVc = [[ZNRdiscountCouponViewController alloc]init];
    discountCouponVc.title = @"优惠券列表";
    if (self.isLogin) {
        
        [self.navigationController pushViewController:discountCouponVc animated:YES];
    }else{
         [self.navigationController pushViewController:self.loginVc animated:YES];
    }
}
//收藏清单
- (IBAction)collect{
    ZNRCollectController *collectVc = [[ZNRCollectController alloc]init];
    collectVc.title = @"收藏清单";
    if (self.isLogin) {
        
        [self.navigationController pushViewController:collectVc animated:YES];
    }else
    {
         [self.navigationController pushViewController:self.loginVc animated:YES];
    }
}

@end
