//
//  ZNRLRTableView.m
//  租哪儿
//
//  Created by 袁武昌 on 16/4/20.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import "ZNRLRTableView.h"
#import "ZNRLeftCell.h"
#import "ZNRRightCell.h"
#define  screenW [UIScreen mainScreen].bounds.size.width
@interface ZNRLRTableView()<UITableViewDataSource,UITableViewDelegate>

/** 子数据*/
@property(nonatomic ,strong) NSArray *subData;
/** 左边点击的行数*/
@property (nonatomic ,assign) NSInteger selectedLeftRow;
@end
@implementation ZNRLRTableView

+ (instancetype)lrTableView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ZNRLRTableView" owner:nil options:nil] lastObject];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.leftTableView) { // 左边的TableView
        return [self.datasource numOfRowsInLeftRow:self];
    } else {
        return self.subData.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (tableView == self.leftTableView) { // 左边的TableView
        
        // 0.初始化cell
        cell = [ZNRLeftCell leftCellWithTableView:tableView];
        // 1.设置数据
        cell.textLabel.text = [self.datasource lrTableView:self titleInLeftRow:indexPath.row];
        if ([self.datasource respondsToSelector:@selector(lrTableView:iconInLeftRow:)]) {
            NSString *iconStr = [self.datasource lrTableView:self iconInLeftRow:indexPath.row];
            cell.imageView.image = [UIImage imageNamed:iconStr];
        }
        
        if ([self.datasource respondsToSelector:@selector(lrTableView:highIconInLeftRow:)]) {
            NSString *highIconStr = [self.datasource lrTableView:self highIconInLeftRow:indexPath.row];
            cell.imageView.highlightedImage = [UIImage imageNamed:highIconStr];
        }
        
    } else {
        // 0.初始化cell
        cell = [ZNRRightCell rightCellWithTableView:tableView];
        
        // 1.设置数据
        cell.textLabel.text = self.subData[indexPath.row];
        
    }
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) { // 左边的TableView
        // 1.获取子数据
        self.subData = [self.datasource lrTableView:self subDataInLeftRow:indexPath.row];
        
        // 2.刷新右边TableView
        [self.rightTableView reloadData];
        
        // 3.调用代理方法
        if ([self.delegate respondsToSelector:@selector(lrTableView:selectedLeftRow:)]) {
            [self.delegate lrTableView:self selectedLeftRow:indexPath.row];
        }
        
        // 4.记录左边点击的行数
        self.selectedLeftRow = indexPath.row;
        
    } else {
        if ([self.delegate respondsToSelector:@selector(lrTableView:selectedLeftRow:selectedRightRow:)]) {
            [self.delegate lrTableView:self selectedLeftRow:self.selectedLeftRow selectedRightRow:indexPath.row];
        }
        
    }
}

//
//- (void)layoutSubviews
//{
//    [super layoutSubviews];
////    self.frame = CGRectMake(screenW *0.5, 0, screenW - screenW*0.5, 300);
////    self.leftTableView.frame = CGRectMake(0, 0, self.width, 300);
////    self.rightTableView.frame = CGRectMake(0, 0, 0, 300);
//
//    
//}


@end
