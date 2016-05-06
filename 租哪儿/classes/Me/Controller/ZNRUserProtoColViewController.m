//
//  ZNRUserProtoColViewController.m
//  租哪儿
//
//  Created by 袁武昌 on 16/4/25.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import "ZNRUserProtoColViewController.h"
#import <AFNetworking/AFNetworking.h>
#import "ZNRAccout.h"
@interface ZNRUserProtoColViewController ()
@property (weak, nonatomic) IBOutlet UITextField *pwd;
@property (weak, nonatomic) IBOutlet UITextField *user;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
/**网络请求*/
@property (nonatomic, strong)AFHTTPSessionManager *manager;
/**账号密码模型*/
@property (nonatomic, strong)ZNRAccout *accountDict;
@end

@implementation ZNRUserProtoColViewController
/**
 *懒加载
 */
- (AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [[AFHTTPSessionManager alloc]init];
        
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)login:(id)sender {
    
    [self logindata];
   
}

- (void)logindata
{
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"account"] = self.user.text;
    parameters[@"password"] = self.pwd.text;
    
     NSString *str = @"http://www_t.zunars.com/account/login_api";
    [self.manager POST:str parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary*  _Nullable responseObject) {
        
        NSDictionary *dict = responseObject[@"data"];
        
        self.accountDict = [ZNRAccout accountWithDict:dict];
        
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error){
            
            NSLog(@"请求发送失败");
            NSLog(@"%@",error);
            
        }
    }];
    
    [self setupcookie];

}

-(void)setupcookie
{
    // 寻找URL为HOST的相关cookie，不用担心，步骤2已经自动为cookie设置好了相关的URL信息
    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:@"http://www_t.zunars.com"]]; // 这里的HOST是你web服务器的域名地址
    // 比如你之前登录的网站地址是abc.com（当然前面要加http://，如果你服务器需要端口号也可以加上端口号），那么这里的HOST就是http://abc.com
    
    // 设置header，通过遍历cookies来一个一个的设置header
    for (NSHTTPCookie *cookie in cookies){
        
        // cookiesWithResponseHeaderFields方法，需要为URL设置一个cookie为NSDictionary类型的header，注意NSDictionary里面的forKey需要是@"Set-Cookie"
        NSArray *headeringCookie = [NSHTTPCookie cookiesWithResponseHeaderFields:
                                    [NSDictionary dictionaryWithObject:
                                     [[NSString alloc] initWithFormat:@"%@=%@",[cookie name],[cookie value]]
                                                                forKey:@"Set-Cookie"]
                                                                          forURL:[NSURL URLWithString:@"http://www_t.zunars.com"]];
        
        // 通过setCookies方法，完成设置，这样只要一访问URL为HOST的网页时，会自动附带上设置好的header
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookies:headeringCookie
                                                           forURL:[NSURL URLWithString:@"http://www_t.zunars.com"]
                                                  mainDocumentURL:nil];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
