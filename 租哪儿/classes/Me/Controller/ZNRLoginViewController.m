//
//  ZNRLoginViewController.m
//  租哪儿
//
//  Created by yuan on 16/4/6.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import "UIBarButtonItem+ZNRItem.h"
#import "ZNRLoginViewController.h"
#import "ZNRUserProtoColViewController.h"

#import <AFNetworking/AFNetworking.h>
#import <MJExtension/MJExtension.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "ZNRSaveTool.h"


@interface ZNRLoginViewController()
/**已有账号label*/
@property (weak, nonatomic) IBOutlet UILabel *alreadyAccountLabel;
/**账号文本框*/
@property (weak, nonatomic) IBOutlet UITextField *accountTextF;
/**密码文本框*/
@property (weak, nonatomic) IBOutlet UITextField *pwdtextF;
/**注册的View验证*/
@property (weak, nonatomic) IBOutlet UIView *registerCodeV;
/**验证文本框*/
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTextF;
/**立即登录按钮*/
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

/**注册登录View的高度*/
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *loginAccountVIewHight;
/**用户协议按钮*/
@property (weak, nonatomic) IBOutlet UIButton *userProtocolBtn;



/**网络请求*/
@property (nonatomic, strong)AFHTTPSessionManager *manager;
@property (nonatomic,assign)NSInteger verifyCodeCount;
@property (nonatomic,strong)NSMutableDictionary *parameters;
@end

@implementation ZNRLoginViewController

//偏好设置保存定义用户数据的key
static NSString *ZNRAccountDictdata =@"ZNRAccountDict";
//偏好设置保存用户登录状态的key
static NSString *userIsLogin =@"isLogin";
#pragma mark *********懒加载***********
/**
 *懒加载
 */
- (NSMutableDictionary *)parameters
{
    if (_parameters == nil) {
        _parameters = [NSMutableDictionary dictionary];
    }
    return _parameters;
}
- (AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [[AFHTTPSessionManager alloc]init];
        
    }
    return _manager;
}

#pragma mark *********按钮点击***********
//发送验证码按钮点击
- (IBAction)sendVerifyBtnClick:(id)sender {
    
    NSLog(@"发送验证码");
     NSLog(@"%@",self.accountTextF.text);
    
    
}
//登录按钮点击
#pragma mark *********View加载***********
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"用户登录";
    [self setupNavigation];
    self.verifyCodeCount = 0;
}
//View将要显示
 - (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.loginAccountVIewHight.constant = 121;
    self.registerCodeV.hidden = YES;
    self.userProtocolBtn.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 隐藏指示器
    [SVProgressHUD dismiss];
    
    // 取消所有请求数据
    [_manager.tasks makeObjectsPerformSelector:@selector(cancel)];
    
}

//设置导航条上内容
- (void)setupNavigation
{
    UIBarButtonItem *rightBarBtn=[[UIBarButtonItem alloc]initWithTitle:@"注册" style:UIBarButtonItemStylePlain target:self action:@selector(changeLoginAndRegister:)];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
   
}
#pragma mark *********导航条右边按钮的点击监听***********
//导航条右边按钮的点击监听
- (void)changeLoginAndRegister:(UIBarButtonItem *)barBtn;
{
    if ([barBtn.title isEqualToString:@"登录"]) {
        barBtn.title  = @"注册";
        self.title = @"用户登录";
        self.alreadyAccountLabel.text = @"使用已有账号登录";
        self.loginAccountVIewHight.constant = 121;
        self.registerCodeV.hidden = YES;
         self.loginBtn.titleLabel.text = @"立即登录";
        self.userProtocolBtn.hidden = YES;
        
        
        
    }else if ([barBtn.title isEqualToString:@"注册"]){
        barBtn.title = @"登录";
        self.title = @"用户注册";
        self.alreadyAccountLabel.text = @"注册完成账号";
        self.loginAccountVIewHight.constant = 165;
        self.registerCodeV.hidden = NO;
        self.loginBtn.titleLabel.text = @"立即注册";
        self.userProtocolBtn.hidden = NO;
    }
}
#pragma mark *********租哪儿用户协议按钮点击***********

//租哪儿用户协议按钮点击
- (IBAction)userProtocolBtnClick:(id)sender {
    NSLog(@"租哪儿用户协议");
    ZNRUserProtoColViewController *userProtoColVc = [[ZNRUserProtoColViewController alloc] init];
    userProtoColVc.title = @"租哪儿用户协议";
    [self.navigationController pushViewController:userProtoColVc animated:YES];
    
}
//登录或者注册按钮点击
- (IBAction)loginBtnClick:(id)sender {
    
    if (self.verifyCodeCount >5) {
        NSLog(@"图片验证码错误");
        NSString *str = @"http://www_t.zunars.com/common/fetch_verify_code?key=account_login&rand=52697553";
        self.parameters[@"account"] = self.accountTextF.text;
        self.parameters[@"password"] = self.pwdtextF.text;
        
        //发送网络请求
        [self postAccountDataParameters:nil getStr:str];
        
        
    }else{
        NSString *tabBarTitle = self.navigationItem.rightBarButtonItem.title;
        if ([tabBarTitle isEqualToString:@"注册"]) {
            
            NSString *str = @"http://www_t.zunars.com/account/login_api";
            self.parameters[@"account"] = self.accountTextF.text;
            self.parameters[@"password"] = self.pwdtextF.text;
            
            //发送网络请求
            [self postAccountDataParameters:self.parameters getStr:str];
            
            
        }else{
            NSString *str = @"http://www_t.zunars.com/account/registe_open_api";
            //发送网络请求
            [self postAccountDataParameters:nil getStr:str];
        }
    }
  
    
   
   
   
}


#pragma mark *********网络请求***********
- (void)postAccountDataParameters:(NSMutableDictionary *)parameters getStr:(NSString *)getStr
{
    // 0.提示用户当前正在加载
    [SVProgressHUD showWithStatus:@"正在加载数据..."];
    
    
    [self.manager POST:getStr parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary*  _Nullable responseObject) {
        NSLog(@"%@",responseObject[@"message"]);
        NSString *codeStr = responseObject[@"code"];
        NSString *messageStr = responseObject[@"message"];
        [SVProgressHUD showWithStatus:messageStr];
        
//        登录成功
        if ([codeStr isEqualToString:@"200"]) {
          
            
            [self  dealWithDataAndSendNotification:responseObject[@"data"]];
            
        }else{
            self.verifyCodeCount ++;
            
            if ([codeStr isEqualToString:@"400"]){
                
                
            }else if ([codeStr isEqualToString:@"201"])
            {
                
            }else if ([codeStr isEqualToString:@"405"])
            {
                
            }

        }
        // 隐藏指示器
        [SVProgressHUD dismiss];

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error){
            // 隐藏指示器
            [SVProgressHUD dismiss];
            
            NSLog(@"请求发送失败");
            NSLog(@"%@",error);
            
        }
    }];
    
}
//请求数据成功,保存数据和发送通知
- (void)dealWithDataAndSendNotification:(NSDictionary*)dictData
{
    self.accountDict = [ZNRAccout accountWithDict:dictData];
    //        保存用户数据和登录状态
    [ZNRSaveTool setObject:dictData forKey:ZNRAccountDictdata];
    [ZNRSaveTool setBool:YES forKey:userIsLogin];
    
    //发布通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"postAccountDataNotification" object:self];
     [self.navigationController  popViewControllerAnimated:YES];
}

#pragma mark *********第三方登录按钮***********
//第三方登录按钮
- (IBAction)otherLoginWayBtn:(id)
sender {
  
    
    NSLog(@"第三方分享移除");
   
}
//第三方登录按钮
- (IBAction)sinaLogin {
    NSLog(@"新浪登录更新");
    
    
    
}
//第三方登录按钮
- (IBAction)qqLogin {
    NSLog(@"qq登录保存");
    
}


- (IBAction)autoLogin
{
    NSLog(@"自动登录");
    [self removeLoginSession];
    
}

#pragma mark *********保存登录的session***********
- (void)removeLoginSession

{
    
    
    
}


@end
