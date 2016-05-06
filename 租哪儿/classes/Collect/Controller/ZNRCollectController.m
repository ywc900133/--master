
//
//  ZNRCollectController.m
//  租哪儿
//
//  Created by yuan on 16/4/7.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import "ZNRCollectController.h"
#import "ZNRCollectCell.h"
#import <AFNetworking/AFNetworking.h>
@interface ZNRCollectController()

/**网络请求*/
@property (nonatomic, strong)AFHTTPSessionManager *manager;
@end
@implementation ZNRCollectController
static NSString * const ColletCellId = @"collect";
- (AFHTTPSessionManager *)manager
{
    if (_manager == nil) {
        _manager = [[AFHTTPSessionManager alloc]init];
        
    }
    return _manager;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
  [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZNRCollectCell class]) bundle:nil] forCellReuseIdentifier:ColletCellId];
    
//    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZNRCollectCell class]) bundle:nil] forCellReuseIdentifier:ColletCellId];
    [self postCollectData];
}

- (void)postCollectData
{
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
     parameters[@"num"] = @"1";
    parameters[@"page"] = @"1";
      NSString *str = @"http://www_t.zunars.com/account/get_favorite_list";
    [self.manager POST:str parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary*  _Nullable responseObject) {
        
        NSLog(@"%@",responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error){
            
            NSLog(@"请求发送失败");
        }
    }];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZNRCollectCell *cell = [tableView dequeueReusableCellWithIdentifier:ColletCellId];
     cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 148;
}

@end
