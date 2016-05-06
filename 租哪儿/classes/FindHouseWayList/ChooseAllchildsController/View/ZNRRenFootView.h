//
//  ZNRRenFootView.h
//  租哪儿
//
//  Created by yuan on 16/4/7.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZNRRenFootView : UIView
/**低价文本输入框*/
@property (weak, nonatomic) IBOutlet UITextField *lowPayTextF;
/**高价文本输入框*/
@property (weak, nonatomic) IBOutlet UITextField *hightPayTextF;
/**加载xib方法*/
+ (instancetype)rentFootView;
@end
