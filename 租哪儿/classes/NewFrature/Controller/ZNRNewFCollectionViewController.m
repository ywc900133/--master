//
//  ZNRNewFCollectionViewController.m
//  租哪儿
//
//  Created by yuan on 16/4/7.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import "ZNRNewFCollectionViewController.h"
#import "ZNRNewFeatureCell.h"
#import "UIView+ZNRFrame.h"
//总页数
#define ZNRPageCount 4

@interface ZNRNewFCollectionViewController ()
/** 上次的偏移量 ScollView上一次的offsetX*/
@property (nonatomic ,assign) CGFloat preOffsetX;
/** guideImageV*/
@property (nonatomic, weak)UIImageView *guide;
/**pageControl*/
@property(nonatomic ,weak)UIPageControl *pageControl;

@end

@implementation ZNRNewFCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

/**状态栏样式*/
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
/**初始化*/
-(instancetype)init{
    
    //创建一个流水布局
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    //修改布局参数,来修改格子的样式.
    //设置每一个格子的尺寸大小.
    flow.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
    //设置每一行的最小间距
    flow.minimumLineSpacing = 0;
    //设置每个item之间的最小间距
    flow.minimumInteritemSpacing = 0;
    //设置滚动的方向
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    return [super initWithCollectionViewLayout:flow];
}


/**注册CollectionViewCell*/
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置分页效果
    self.collectionView.pagingEnabled = YES;
    //取消水平滚动条
    self.collectionView.showsHorizontalScrollIndicator = NO;
    
    //取消弹簧效果
    self.collectionView.bounces = NO;
    
    //UICollectionViewCell必须得要注册.
    [self.collectionView registerClass:[ZNRNewFeatureCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    //添加内部的子控件
//    [self setUp];
}
/**添加pageControl*/
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    ZNRNewFeatureCell * pageControlCell = [[ZNRNewFeatureCell alloc] init];
    
    self.pageControl = pageControlCell.pageControl;
    self.pageControl.center=
    CGPointMake(self.view.width * 0.5, self.view.height *0.95);
    
    [self.view addSubview:self.pageControl];
    
}
/**添加添加内部的子控件*/
- (void)setUp{
    
    //guide1
    UIImageView *guide = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guide1"]];
    guide.x += 40;
    self.guide = guide;
    [self.collectionView addSubview:guide];
    
    //line
    UIImageView *line = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideLine"]];
    line.x -= 150;
    [self.collectionView addSubview:line];
    
    //largeT
    
    UIImageView *largeT = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideLargeText1"]];
    largeT.center = CGPointMake(self.view.width * 0.5, self.view.height * 0.8);
    [self.collectionView addSubview:largeT];
    
    
    //smallT
    UIImageView *smallT = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"guideSmallText1"]];
    smallT.center = CGPointMake(self.view.width * 0.5, self.view.height * 0.7);
    [self.collectionView addSubview:smallT];
    
    
}



//有多少组.
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    
    return 1;
}

//第一组当中有多少Items(格子)
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}
//返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    ZNRNewFeatureCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    //加载图片
    NSString *imageName = [NSString stringWithFormat:@"zsl_bg%ld",indexPath.item +1];
    UIImage *image = [UIImage imageNamed:imageName];
    
    //给Cell当中image进行赋值
    cell.image = image;
    
    
    //添加立即体验按钮
    [cell setStartBtn:indexPath count:ZNRPageCount];
    
    return cell;
    
}
//开始滚动时
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //计算当前滚动的页面
    int page = (int)(scrollView.contentOffset.x / scrollView.frame.size.width + 0.5);
    
    
    //最后一页
    if (page == ZNRPageCount-1) {
        self.pageControl.hidden = YES;
        
    }else{
        self.pageControl.hidden = NO;
        self.pageControl.currentPage = page;
    }
    
}

//当ScollView滚动减速完成时, 调用这个方法
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //移动guide的UIImageV位置.
    
    //计算每次一滚动的偏移量
    CGFloat offsetX = scrollView.contentOffset.x - self.preOffsetX;
    //修改图片的位置
    //开始先设置为2倍的偏移量, 目的是让动画从左侧或右侧出来.
    self.guide.x += 2 * offsetX;
    [UIView animateWithDuration:0.5 animations:^{
        //再通过一个动画形式,减去一个偏移量.
        self.guide.x -= offsetX;
    }];
    
    //把当前的contentOffsetX赋值给上一个偏移量
    self.preOffsetX = scrollView.contentOffset.x;
    //计算当前是多少页
    int page =  scrollView.contentOffset.x / self.collectionView.width;
    
    //重新设置图片
    self.guide.image = [UIImage imageNamed:[NSString stringWithFormat:@"guide%d",page + 1]];
    
    
}@end
