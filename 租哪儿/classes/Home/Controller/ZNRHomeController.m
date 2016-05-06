
//
//  ZNRHomeController.m
//  租哪儿
//
//  Created by yuan on 16/4/7.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import "ZNRHomeController.h"
#import "UIView+ZNRFrame.h"
#import "ZNRFindVTitleButton.h"
#import "ZNRFindHouseWayViewController.h"


#import "ZNRPageView.h"

#import "ZNRrecommendTableViewController.h"

#import <MJExtension/MJExtension.h>
#import <AFNetworking/AFNetworking.h>
#import <UIImageView+WebCache.h>

@interface ZNRHomeController()
/**底部的ScrollView*/
@property(nonatomic, strong) UIScrollView *backScroller;
/**滚动页面的ScrollView*/
@property(nonatomic, strong) UIScrollView *pageScroller;
/**房子类型的View */
@property (nonatomic, strong)UIView *findView;
/**添加品牌公寓*/
@property (nonatomic,strong)UIView *brandV;
/**添加品牌和和左滑查看更多标签*/
@property (nonatomic ,strong)UIView *brandLog;
/**品牌公寓添加滚动视图片ScroolerView*/
@property (nonatomic, strong)UIScrollView *brandScrollV;
/**推荐房源的View*/
@property (nonatomic,strong)UIView *recommendV;
/**热门区域的View*/
@property (nonatomic,strong)UIView *hotRegionV;
/**热门区域和左滑查看更多标签*/
@property (nonatomic,strong)UIView *hotLog;
/**热门区域添加滚动视图片ScroolerView*/
@property (nonatomic,strong)UIScrollView *hotScrollV;
@end
@implementation ZNRHomeController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //1添加ScrollView
    [self setUpAddBackScroller];
    //2.添加展示的页面
    [self setUpAddPageScroller];
    //3.添加房子类型的View
    [self findHouseWayView];
    //4.添加品牌公寓
    [self brandHouseView];
    //5.推荐房源的View
    [self recommendHouseView];
    //6.热门区域的View
    [self hotRegionView];
  
}


- (void)loadData
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    // 拼接请求参数
//    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
//    parameters[@"code2"] = code2;
    
    
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:@"https://www.baidu.com" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObject) {
        // 请求成功回调

    
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        // 请求失败回调
        NSLog(@"%@",error);
        
    }];
}
#pragma mark - 状态栏控制
//状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
//1添加ScrollView
-(void)setUpAddBackScroller
{
    UIScrollView *backScroller = [[UIScrollView alloc]init];
    backScroller.frame = CGRectMake(0, 0, self.view.bounds.size.width, 666);
    backScroller.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    backScroller.contentSize = CGSizeMake(self.view.bounds.size.width, 1966);
    [self.view addSubview:backScroller];
    _backScroller = backScroller;
}
#pragma mark setUpAddPageScroller添加展示的页面

//添加展示的页面
-(void)setUpAddPageScroller
{
    ZNRPageView *pageView = [ZNRPageView pageView];
    
    [self.backScroller addSubview:pageView];
    
}
#pragma mark findHouseWayView添加房子类型的View
//3.添加房子类型的View
- (void)findHouseWayView
{
    UIView *findV = [[UIView alloc] init];
    findV.frame = CGRectMake(0, 320, self.view.bounds.size.width, 170);
    findV.backgroundColor = [UIColor whiteColor];
    [self.backScroller addSubview:findV];
    _findView = findV;
    
    // 标题按钮
    [self setupTitleButtons];
    //添加分隔线
    [self setupSeparateline];
    
    
}
//3.1添加房子类型的View的按钮
/**
 *  标题按钮
 */
- (void)setupTitleButtons
{
    // 文字
    NSArray *titles = @[@"整租房", @"合租房", @"地图找房", @"发布房源", @"找求租/发求租", @"袋鼠搬家(即将推出)"];
    NSUInteger count = titles.count;
    
    CGFloat titleH = self.findView.height *0.5;
    
    for (NSUInteger i = 0; i < count; i++) {
        // 创建添加
        ZNRFindVTitleButton *titleButton = [ZNRFindVTitleButton buttonWithType:UIButtonTypeCustom];
        [titleButton setImage:[UIImage imageNamed:@"tabbar_home_highlighted"] forState:UIControlStateNormal];
        titleButton.tag = i;
        [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.findView addSubview:titleButton];
        
        // frame
        if (i < 4) {
            CGFloat titleW = self.view.width / (count - 2);
            CGFloat titleX = titleW * i;
            titleButton.frame = CGRectMake(titleX, 0, titleW, titleH);
            
            // 数据
            [titleButton setTitle:titles[i] forState:UIControlStateNormal];

        }else
        {
            CGFloat titleW = self.view.width * 0.5;
            CGFloat titleX = titleW * (i - 4);
            titleButton.frame = CGRectMake(titleX, titleH, titleW, titleH);
            
            // 数据
            [titleButton setTitle:titles[i] forState:UIControlStateNormal];
            
            if (i == 5)

                [titleButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
                titleButton.enabled = NO;
            
        }
        
    }
    
}
/**
 *  分隔线
 */
- (void)setupSeparateline
{
    // 下划线
    UIView *separateline = [[UIView alloc] init];
    separateline.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    separateline.height = 2;
    separateline.frame = CGRectMake(0,self.findView.height *0.5 , self.findView.width, 2);
    [self.findView addSubview:separateline];
}

/**
 *  监听标题按钮点击
 */
- (void)titleClick:(ZNRFindVTitleButton *)titleButton
{
   ZNRFindHouseWayViewController *findHouseWayVC = [[ZNRFindHouseWayViewController alloc] init];
    [self.navigationController pushViewController:findHouseWayVC animated:YES];
    findHouseWayVC.title = titleButton.titleLabel.text;
}

#pragma mark  brandHouseView添加品牌公寓
//4.添加品牌公寓
- (void)brandHouseView
{
    UIView *brandV = [[UIView alloc] init];
    brandV.frame = CGRectMake(10, 500, self.view.bounds.size.width-20, 200);
    brandV.ywc_centerX  = self.view.ywc_centerX;
    brandV.backgroundColor = [UIColor whiteColor];
    [self.backScroller addSubview:brandV];
    _brandV = brandV;
    
    //添加品牌和和左滑查看更多标签
    [self brandLabelView];
    
    //添加滚动视图片按钮
    [self brandScrollView];
    
}

//添加品牌和和左滑查看更多标签
- (void)brandLabelView
{
    UIView *brandLog = [[UIView alloc] init];
    brandLog.frame = CGRectMake(0, 0, self.brandV.width, 44);
    [self.brandV addSubview:brandLog];
    _brandLog = brandLog;
    //品牌公寓
    [self brandLabel];
    //查看更多
    [self moreLabel];
    
}
//品牌公寓
- (void)brandLabel
{
    UILabel *brandL = [[UILabel alloc] init];
    brandL.frame = CGRectMake(20, 10, 80, 20);
    brandL.text = @"品牌公寓";
    [self.brandLog addSubview:brandL];
    
}
//查看更多
- (void)moreLabel
{
    UILabel *moreL = [[UILabel alloc] init];
    moreL.frame = CGRectMake(self.brandLog.width -100, 10, 85, 20);
    moreL.text = @"左滑查看更多";
    moreL.textColor = [UIColor grayColor];
    moreL.font = [UIFont systemFontOfSize:12];
    moreL.textAlignment = NSTextAlignmentCenter;
    [self.brandLog addSubview:moreL];
}



//添加滚动视图片按钮
- (void)brandScrollView
{
    UIScrollView *brandScrollV = [[UIScrollView alloc] init];
    brandScrollV.frame = CGRectMake(0, 44, self.brandV.width -10, self.brandV.height - 44);
    brandScrollV.pagingEnabled = NO;
    brandScrollV.bounces = NO;

    [self.brandV addSubview:brandScrollV];
    _brandScrollV = brandScrollV;
    
    // 品牌图片按钮
    [self brandScrollViewButtons];
    
}


- (void)brandScrollViewButtons
{
        CGFloat brandW = 100;
        CGFloat brandH = 100;
        CGFloat Margin  = 18;
    
    for (NSUInteger i = 0; i < 4; i++) {
        // 创建添加
        ZNRFindVTitleButton *brandButton = [ZNRFindVTitleButton buttonWithType:UIButtonTypeCustom];
        [brandButton setImage:[UIImage imageNamed:@"iconImage"] forState:UIControlStateNormal];
        
        brandButton.tag = i;
        [brandButton addTarget:self action:@selector(brandClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.brandScrollV addSubview:brandButton];
        CGFloat brandX = (brandW + Margin) * i + 18;
        brandButton.frame = CGRectMake(brandX, 10, brandW, brandH);
        
        // 4.7 设置标题滚动条滚动范围
        CGFloat contentW = 4 * (brandW + Margin) + Margin;
        self.brandScrollV.contentSize = CGSizeMake(contentW, 0);
        self.brandScrollV.showsHorizontalScrollIndicator = NO;
        self.brandScrollV.pagingEnabled = NO;
        self.brandScrollV.bounces = NO;
    }
    
}

- (void)brandClick:(UIButton *)brandClick
{
    ZNRFindHouseWayViewController *findHouseWayVC = [[ZNRFindHouseWayViewController alloc] init];
    [self.navigationController pushViewController:findHouseWayVC animated:YES];
    findHouseWayVC.title = @"整租&合租";
}

#pragma mark recommendHouseView推荐房源的View

//5.推荐房源的View
- (void)recommendHouseView
{
    UIView *recommendV = [[UIView alloc] init];
    recommendV.frame = CGRectMake(10, 710, self.view.bounds.size.width-20, 1040);
    recommendV.ywc_centerX = self.view.ywc_centerX;
    recommendV.backgroundColor = [UIColor whiteColor];
    [self.backScroller addSubview:recommendV];
    _recommendV = recommendV;
    
    //添加推荐房源的Label
    //品牌公寓
    [self recommendLabel];
    
    //添加推荐房源的TableView
    [self recommendTableView];
    
    //点击查看更多
    [self moreRecommendBtn];
    
}

//品牌公寓
- (void)recommendLabel
{
    UILabel *recommendL = [[UILabel alloc] init];
    recommendL.frame = CGRectMake(20, 10, 80, 20);
    recommendL.text = @"推荐房源";
    [self.recommendV addSubview:recommendL];
    
}
//5.推荐房源的scrollView
- (void)recommendTableView
{
    [self addChildViewController:[[ZNRrecommendTableViewController alloc] init]];
    // 添加对应的子控制器view到scrollView上面
    UIViewController *childVc = self.childViewControllers[0];
    childVc.view.frame = CGRectMake(0, 40, self.recommendV.width, self.recommendV.height - 40);
    // 如果这个子控制器view已经显示在上面, 就直接返回
    if (childVc.view.superview) return;
    
    [self.recommendV addSubview:childVc.view];
}
#pragma mark附近房源还有12套,点击查看更多按钮
//附近房源还有12套,点击查看更多按钮
- (void)moreRecommendBtn

{
    UIButton *moreRecommendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    moreRecommendBtn.frame = CGRectMake(10, self.recommendV.height - 40, self.recommendV.width-20, 40);
    moreRecommendBtn.ywc_centerX = self.recommendV.ywc_centerX;
    [moreRecommendBtn setTitle:@"附近房源还有12套,点击查看更多  " forState:UIControlStateNormal];
    [moreRecommendBtn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [moreRecommendBtn addTarget:self action:@selector(moreRecommendBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.recommendV addSubview:moreRecommendBtn];
}
//附近房源还有12套,点击查看更多按钮监听
- (void)moreRecommendBtnClick:(UIButton*)btn
{
    ZNRFindHouseWayViewController *findHouseWayVC = [[ZNRFindHouseWayViewController alloc] init];
    [self.navigationController pushViewController:findHouseWayVC animated:YES];
    findHouseWayVC.title = @"地图";
}
#pragma mark recommendHouseView热门区域的View
//6.热门区域的View
- (void)hotRegionView
{
    UIView *hotRegionV = [[UIView alloc] init];
    hotRegionV.frame = CGRectMake(10, 1760, self.view.bounds.size.width-20, 200);
    hotRegionV.ywc_centerX  = self.view.ywc_centerX;
    hotRegionV.backgroundColor = [UIColor whiteColor];
    [self.backScroller addSubview:hotRegionV];
    _hotRegionV = hotRegionV;
    //添加品牌和和左滑查看更多标签
    [self hotLabelView];
    //添加滚动视图片按钮
    [self hotScrollView];
    
}

//添加品牌和和左滑查看更多标签
- (void)hotLabelView
{
    UIView *hotLog = [[UIView alloc] init];
    //    hotLog.backgroundColor = [UIColor redColor];
    hotLog.frame = CGRectMake(0, 0, self.hotRegionV.width, 44);
    [self.hotRegionV addSubview:hotLog];
    _hotLog = hotLog;
    //品牌公寓
    [self hotLabel];
    //查看更多
    [self hotMoreLabel];
    
}
//品牌公寓
- (void)hotLabel
{
    UILabel *hotL = [[UILabel alloc] init];
    hotL.frame = CGRectMake(20, 10, 80, 20);
    hotL.text = @"热门区域";
    [self.hotLog addSubview:hotL];
    
}
//查看更多
- (void)hotMoreLabel
{
    UILabel *moreL = [[UILabel alloc] init];
    moreL.frame = CGRectMake(self.hotLog.width -100, 10, 85, 20);
    moreL.text = @"左滑查看更多";
    moreL.textColor = [UIColor grayColor];
    moreL.font = [UIFont systemFontOfSize:12];
    moreL.textAlignment = NSTextAlignmentCenter;
    [self.hotLog addSubview:moreL];
}

//添加滚动视图片按钮
- (void)hotScrollView
{
    UIScrollView *hotScrollV = [[UIScrollView alloc] init];
    hotScrollV.frame = CGRectMake(0, 44, self.hotRegionV.width -10, self.hotRegionV.height - 44);
    hotScrollV.pagingEnabled = NO;
    hotScrollV.bounces = NO;
    
    [self.hotRegionV addSubview:hotScrollV];
    
    _hotScrollV = hotScrollV;
    
    // 热门区域按钮
    [self hotScrollViewButtons];
    
}

// 热门区域按钮
- (void)hotScrollViewButtons
{
    // 标题的宽高
    //        CGFloat titleW = self.view.width / count;
    CGFloat hotW = 100;
    CGFloat hotH = 100;
    CGFloat Margin  = 18;
    
    for (NSUInteger i = 0; i < 4; i++) {
        // 创建添加
        ZNRFindVTitleButton *hotButton = [ZNRFindVTitleButton buttonWithType:UIButtonTypeCustom];
        [hotButton setImage:[UIImage imageNamed:@"iconImage"] forState:UIControlStateNormal];
        
        hotButton.tag = i;
        [hotButton addTarget:self action:@selector(hotClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.hotScrollV addSubview:hotButton];
        CGFloat hotX = (hotW + Margin) * i + 18;
        hotButton.frame = CGRectMake(hotX, 10, hotW, hotH);
        
        // 4.7 设置标题滚动条滚动范围
        CGFloat contentW = 4 * (hotW + Margin) + Margin;
        self.hotScrollV.contentSize = CGSizeMake(contentW, 0);
        self.hotScrollV.showsHorizontalScrollIndicator = NO;
        self.hotScrollV.pagingEnabled = NO;
        self.hotScrollV.bounces = NO;
    }
    
}
// 热门区域按钮监听
- (void)hotClick:(UIButton *)hotClick
{
    ZNRFindHouseWayViewController *findHouseWayVC = [[ZNRFindHouseWayViewController alloc] init];
    [self.navigationController pushViewController:findHouseWayVC animated:YES];
    findHouseWayVC.title = @"整租&合租";
    
}

@end
