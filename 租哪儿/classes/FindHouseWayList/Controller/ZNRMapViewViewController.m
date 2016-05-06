
//
//  ZNRMapViewViewController.m
//  租哪儿
//
//  Created by yuan on 16/4/8.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import "ZNRMapViewViewController.h"

@interface ZNRMapViewViewController ()

@end

@implementation ZNRMapViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(200, 200, 100, 100);
    label.text = @"11111111";
    [self.view addSubview:label];
    
    label.backgroundColor = [UIColor redColor];
    
    label.layer.borderColor = [[UIColor grayColor]CGColor];
    
    label.layer.borderWidth = 5;
    
    label.layer.masksToBounds = YES;
    
    // Do any additional setup after loading the view from its nib.
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
