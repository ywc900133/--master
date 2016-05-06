//
//  ZNRRentTableViewController.h
//  租哪儿
//
//  Created by yuan on 16/4/7.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZNRRenFootView.h"
@interface ZNRRentTableViewController : UIViewController
/**租金cell的标题数组*/
@property (nonatomic,strong)NSArray<NSString *> *rentArr;
/**cell的IndexPath*/
@property (nonatomic,strong)NSIndexPath *rentIndexPath;
@end
