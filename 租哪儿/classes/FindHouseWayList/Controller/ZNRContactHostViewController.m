//
//  ZNRContactHostViewController.m
//  租哪儿
//
//  Created by 袁武昌 on 16/4/24.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import "ZNRContactHostViewController.h"
#import "UIBarButtonItem+ZNRItem.h"
#import <AFNetworking/AFNetworking.h>
@interface ZNRContactHostViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameF;

@property (weak, nonatomic) IBOutlet UISegmentedControl *sexSegmentControl;


@property (weak, nonatomic) IBOutlet UITextField *phoneF;
@property (weak, nonatomic) IBOutlet UITextField *imageVerifyCode;
@property (weak, nonatomic) IBOutlet UITextField *ageF;
@property (weak, nonatomic) IBOutlet UITextField *professionalF;
@property (weak, nonatomic) IBOutlet UITextField *othersInformationF;

@end

@implementation ZNRContactHostViewController
- (IBAction)sendPhoneNumberBtnClick:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem backItemWithImage:nil highImage:nil target:self action:@selector(submitAppointment:) title:@"提交预约"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}
- (void)submitAppointment:(UIButton *)btn
{
    NSLog(@"%@",self.nameF.text);
    NSLog(@"%@",[self.sexSegmentControl titleForSegmentAtIndex:self.sexSegmentControl.selectedSegmentIndex]);
    NSLog(@"%@",self.phoneF.text);
    NSLog(@"%@",self.ageF.text);
    NSLog(@"%@",self.professionalF.text);
    NSLog(@"%@",self.othersInformationF.text);
    
    NSLog(@"提交预约");
    //1.创建请求管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //2.发送请求
    NSDictionary *dict = @{
                           @"username":@"520it",
                           @"pwd":@"520it",
                           };
    /*
     第一个参数:请求路径 NSString
     第二个参数:字典
     第三个参数:success 如果请求成功那么会调用这个block
     responseObject 请求体信息
     第四个参数:failure 如果请求失败那么会调用这个block
     */
    //username=sdsf&pwd=sdf&type=JSON
    //AFN内部已经完成了序列化的工作
   [manager POST:@"http://120.25.226.186:32812/login" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary*  _Nullable responseObject) {
       NSLog(@"%@",responseObject[@"success"]);
       
   } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       if(error){
           
           NSLog(@"请求失败");
       }
   }];

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
