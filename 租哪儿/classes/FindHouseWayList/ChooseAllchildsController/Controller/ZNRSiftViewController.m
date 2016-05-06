//
//  ZNRSiftViewController.m
//  租哪儿
//
//  Created by yuan on 16/4/7.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import "ZNRSiftViewController.h"

@interface ZNRSiftViewController ()

/**微信绑定选中标识 */
@property (weak, nonatomic) IBOutlet UIImageView *weChatselectLog;
/**实名认证选中标识 */
@property (weak, nonatomic) IBOutlet UIImageView *realyNameselectLog;

@end

@implementation ZNRSiftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //    初始化
    self.allRentBtn.selected = YES;
    self.togetherRentBtn.imageView.hidden = YES;
    self.weChatselectLog.hidden = YES;
    self.realyNameselectLog.hidden = YES;
    self.defaultBtn.selected = YES;

}

//整租按钮点击
- (IBAction)allRenBtnClick:(ZNRRentBtn*)sender {
    
    sender.selected = !sender.selected;
    
}

//合租按钮点击
- (IBAction)togetherBtnClick:(ZNRRentBtn *)sender {
   
    sender.selected = !sender.selected;
  
}

//微信绑定按钮点击
- (IBAction)weChatBtnClick:(UIButton *)sender {
    
    sender.selected = !sender.selected;
    
    if (sender.selected == YES) {
        [sender setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        self.weChatselectLog.hidden = NO;
        
    }else if (sender.selected == NO)
    {
        [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.weChatselectLog.hidden = YES;
       
    }
}

//实名认证按钮点击
- (IBAction)realyNameBtnClick:(UIButton *)sender {

    sender.selected = !sender.selected;

    if (sender.selected == YES) {
        [sender setTitleColor:[UIColor blueColor] forState:UIControlStateSelected];
        self.realyNameselectLog.hidden = NO;
        
    }else if (sender.selected == NO)
    {
        [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.realyNameselectLog.hidden = YES;
    }

}

//默认排序按钮点击
- (IBAction)defaultBtnClick:(ZNRArrayBtn *)sender {
    self.defaultBtn.selected = YES;
    self.lowBtn.selected = NO;
    self.hightBtn.selected = NO;

}

//由高到低排序按钮点击
- (IBAction)lowBtnClick:(ZNRArrayBtn *)sender {
    self.defaultBtn.selected = NO;
    self.lowBtn.selected = YES;
    self.hightBtn.selected = NO;
  
}

//由低到高排序按钮点击
- (IBAction)hightBtnClick:(ZNRArrayBtn *)sender {
    self.defaultBtn.selected = NO;
    self.lowBtn.selected = NO;
    self.hightBtn.selected = YES;
    
}

//重置按钮点击
- (IBAction)replaceBtnClick:(UIButton *)sender {
    //整租合租按钮选中
    self.allRentBtn.selected = YES;
    self.togetherRentBtn.selected = YES;
    //实名认证和微信按钮不选中
    self.weChatBtn.selected = NO;
    self.weChatselectLog.hidden = YES;
    self.realyNameBtn.selected = NO;
    self.realyNameselectLog.hidden = YES;
    //默认按钮选中
    self.defaultBtn.selected = YES;
    self.lowBtn.selected = NO;
    self.hightBtn.selected = NO;
    
    //发布通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"replaceBtnClickNotification" object:self];
    
}

//确认按钮点击
- (IBAction)confirmBtnClick:(UIButton *)sender {
    //发布通知
    [[NSNotificationCenter defaultCenter]postNotificationName:@"confirmBtnClickNotification" object:self];
    
}




@end
