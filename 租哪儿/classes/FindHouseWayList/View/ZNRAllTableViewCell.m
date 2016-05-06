//
//  ZNRAllTableViewCell.m
//  租哪儿
//
//  Created by yuan on 16/4/6.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import "ZNRAllTableViewCell.h"
#import "ZNRRomes.h"
#import <UIImageView+WebCache.h>
@interface ZNRAllTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *cover_picture;

@property (weak, nonatomic) IBOutlet UILabel *room_name;

@property (weak, nonatomic) IBOutlet UILabel *square;
@property (weak, nonatomic) IBOutlet UILabel *payment;
@property (weak, nonatomic) IBOutlet UILabel *subway;
@property (weak, nonatomic) IBOutlet UILabel *wechat_bind;
@property (weak, nonatomic) IBOutlet UILabel *servers;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subwayLineLayoutC;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *subwayLineWidth;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *wechatLineLayoutC;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *wechatLineWidth;


@end
@implementation ZNRAllTableViewCell

- (void)setRomes:(ZNRRomes *)romes
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _romes = romes;

    NSString *str = [NSString stringWithFormat:@"https://zunars.b0.upaiyun.com%@!small",romes.cover_pictures.url];
   

    [_cover_picture sd_setImageWithURL:[NSURL URLWithString:str]];
    self.room_name.text = [NSString stringWithFormat:@"%@.%@.%@室%@厅%@卫",romes.district_name,romes.area_name,romes.bed_room,romes.hall_room,romes.bath_room];
    self.square.text = [NSString stringWithFormat:@"%@.整租.%@㎡",romes.community,romes.square];
    self.payment.text = [NSString stringWithFormat:@"¥%@/月",romes.payment];
    
    
    if (romes.subway) {
        self.subway.hidden = NO;
        self.subway.text = [NSString stringWithFormat:@"%@",romes.subway[0][@"subway"]];
        self.subwayLineLayoutC.constant = 8;
        self.subwayLineWidth.constant = 41;
    }else
    {
        
        self.subway.hidden = YES;
        
        self.subwayLineLayoutC.constant = 0;
        self.subwayLineWidth.constant = 0;
    }
    
  
    if (romes.wechat_bind != NULL) {
        self.wechat_bind.hidden = NO;
        self.wechat_bind.text = @"微信认证";
        self.wechatLineLayoutC.constant = 8;
        self.wechatLineWidth.constant = 60;
    }else
    {
        self.wechat_bind.hidden = YES;
        
        self.wechatLineLayoutC.constant = 0;
        self.wechatLineWidth.constant = 0;
        
    }
    
    self.servers.text = @"免中介费";
    
    
    
}

@end
