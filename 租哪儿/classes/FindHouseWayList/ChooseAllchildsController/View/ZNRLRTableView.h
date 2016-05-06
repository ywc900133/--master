//
//  ZNRLRTableView.h
//  租哪儿
//
//  Created by 袁武昌 on 16/4/20.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZNRLRTableView;
@protocol ZNRLRTableViewDatasource <NSObject>
@required
/** 左边的TableView总共返回多少行 */
- (NSInteger)numOfRowsInLeftRow:(ZNRLRTableView *)lrTableView;

/** 左边的TableView某个返回的文字 */
- (NSString *)lrTableView:(ZNRLRTableView *)lrTableView titleInLeftRow:(NSInteger)leftRow;

/** 左边的TableView某个返回的子数据 */
- (NSArray *)lrTableView:(ZNRLRTableView *)lrTableView subDataInLeftRow:(NSInteger)leftRow;

@optional
/** 左边的TableView某个返回的普通状态下的图标 */
- (NSString *)lrTableView:(ZNRLRTableView *)lrTableView iconInLeftRow:(NSInteger)leftRow;

/** 左边的TableView某个返回的高亮状态下的图标 */
- (NSString *)lrTableView:(ZNRLRTableView *)lrTableView highIconInLeftRow:(NSInteger)leftRow;

@end

@protocol ZNRLRTableViewDelegate <NSObject>

@optional
/** 告诉代理点击了左边的哪一行 */
- (void)lrTableView:(ZNRLRTableView *)lrTableView selectedLeftRow:(NSInteger)leftRow;

/** 告诉代理点击了左边的哪一行,并且点击了右边的哪一行 */
- (void)lrTableView:(ZNRLRTableView *)lrTableView selectedLeftRow:(NSInteger)leftRow selectedRightRow:(NSInteger)rightRow;

@end

@interface ZNRLRTableView : UIView

/** 数据源*/
@property (nonatomic, weak) id<ZNRLRTableViewDatasource> datasource;

/** 代理*/
@property (nonatomic, weak) id<ZNRLRTableViewDelegate> delegate;


@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;

/**
 *  快速创建
 */
+ (instancetype)lrTableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *LRrightTableViewWidth;

@end
