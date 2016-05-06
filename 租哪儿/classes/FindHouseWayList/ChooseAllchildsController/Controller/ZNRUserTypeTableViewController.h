//
//  ZNRUserTypeTableViewController.h
//  租哪儿
//
//  Created by yuan on 16/4/7.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZNRUserTypeTableViewController : UITableViewController
/**户型cell的标题的数组*/
@property (nonatomic ,strong)NSArray *userTypeArr;
/**cell的IndexPath*/
@property (nonatomic, strong)NSIndexPath *selecetIndexPath;
@end
