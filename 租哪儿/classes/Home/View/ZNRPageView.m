
//
//  ZNRPageView.m
//  租哪儿
//
//  Created by yuan on 16/4/7.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import "ZNRPageView.h"
#import "UIView+ZNRFrame.h"
#define kCount 5

@interface ZNRPageView()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *imageScrollView;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

/**中间的图片*/
@property (nonatomic, weak)UIImageView *centerImageV;
/**重用的图片*/
@property (nonatomic, weak)UIImageView *reuseImageV;

@end
@implementation ZNRPageView

//初始化属性
- (void)awakeFromNib
{
    self.imageScrollView.pagingEnabled = YES;
    // 1.设置单页的时候是否隐藏pageControl
    self.imageScrollView.delegate = self;
    //隐藏垂直滚动条
    self.imageScrollView.showsVerticalScrollIndicator = NO;
    self.imageScrollView.contentSize = CGSizeMake(3 *self.width, 180);
    self.imageScrollView.bounds = self.bounds;
    //添加子控件
    [self setUp];
    
    // 2.设置pageControl
     self.pageControl.hidesForSinglePage = YES;
    _pageControl.pageIndicatorTintColor = [UIColor    colorWithWhite:1.0 alpha:0.7];
    _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
   
    
    // 3.开启定时器
    [self startTimer];
}
//子控件布局
- (void)layoutSubviews
{
    [super layoutSubviews];
     self.pageControl.hidesForSinglePage = YES;
     self.pageControl.center = CGPointMake(self.width * 0.5, self.height *0.85);
}

//添加子控件
- (void)setUp
{
    //创建一个可见的UIImageView(也就是中间的UIImageView)
    UIImageView *centerImageV = [[UIImageView alloc] init];
    centerImageV.userInteractionEnabled = YES;
    //记录住中间的centerImageV.
    self.centerImageV = centerImageV;
    //设置一张默认图片
    self.centerImageV.image = [UIImage imageNamed:@"_00"];
    //设置中间图片的x值为一个屏幕的宽度
    self.centerImageV.frame = CGRectMake(self.width, 0,self.width, 180);
    
    //把图片添加到ScrollView上.
    [self.imageScrollView addSubview:self.centerImageV];
    //创建一个可重复利用的UIImageView,也就是一下滚动出来的图片.
    UIImageView *reuserImageV = [[UIImageView alloc] init];
    reuserImageV.userInteractionEnabled = YES;
    //记录住reuseImageV
    self.reuseImageV =reuserImageV;
    
    //把它的位置设置到最左侧.也就是0,0的位置,让它的大小和当前ScrollView的大小一样.
    self.reuseImageV.frame = CGRectMake(0, 0,self.width, 180);
    //把图片添加到ScrollView上.
    [self.imageScrollView addSubview:self.reuseImageV];
    
    //初始化scrollView的偏移量.一开始显示中间部分.
    self.imageScrollView.contentOffset = CGPointMake(self.width, 0);
    
}
//加载xib
+ (instancetype)pageView
{
    
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    
}
#pragma mark - 定时器相关的方法
- (void)startTimer
{
    // 返回一个会自动开始执行任务
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(nextPage:) userInfo:@"123" repeats:YES];
    // 不管主线程在做什么操作,都分配一定的时间处理timer
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
}
/**
 *  停止定时器
 */
- (void)stopTimer
{
    [self.timer invalidate];
    
}
/**
 *  滚到下一页
 */
- (void)nextPage:(NSTimer *)timer
{
    NSString *imageName = [NSString stringWithFormat:@"_0%ld",self.index +1];
    //设置重复利用的图片
    self.reuseImageV.image = [UIImage imageNamed:imageName];
    self.reuseImageV.userInteractionEnabled = YES;
    
    if (self.index > kCount - 1) {
        //如果页数大于总个数.从第0页开始.
        self.index = 0;
    }
    
    [self.imageScrollView setContentOffset:CGPointMake( 2*self.imageScrollView.frame.size.width, 0) animated:YES];
    
}
#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 设置页码
    self.pageControl.currentPage = self.index;
    
    //获取ScrollView X轴方向的偏移量
    CGFloat offsetX =scrollView.contentOffset.x;
    //记录ScollView的宽度.
    CGFloat w = scrollView.frame.size.width;
    //设置循环利用View的位置.
    CGRect reuserImageVFrame = self.reuseImageV.frame;
    //记录当前是第几页
    NSInteger index = self.index;
    //判断是向左滚动还是向右滚动
    if (offsetX > self.centerImageV.frame.origin.x) {
        //如果是向右滚动
        //让重复利用的图片X在中间ImageView的后面.
        reuserImageVFrame.origin.x = CGRectGetMaxX(self.centerImageV.frame);
        //设置页数+1.
        index = self.centerImageV.tag + 1;
        if (index > kCount - 1) {
            //如果页数大于总个数.从第0页开始.
            index = 0;
        }
    }else
    {
        //如果是向左滚动.
        //设置重复利用的图片X在左侧,0的位置
        reuserImageVFrame.origin.x = 0;
        //设置页数-1
        index = self.centerImageV.tag - 1;
        //如果页数小于0页.
        if (index < 0) {
            //从最后一页开始.
            index = kCount - 1;
        }
    }
    //设置重复利用的图片的位置
    self.reuseImageV.frame = reuserImageVFrame;
    //记录当前重复利用的图片是第几页
    _reuseImageV.tag = index;
    //    NSLog(@"2222222%ld", index);
    self.index = index;
    self.pageControl.currentPage = index;
    //设置图片名称
    NSString *imageName = [NSString stringWithFormat:@"_0%ld", index];
    //设置重复利用的图片
    self.reuseImageV.image =[UIImage imageNamed:imageName];
    //设置如果滚动到最左侧,或者滚动的最右侧.
    if (offsetX <= 0 || offsetX >= 2 *w) {
        //交换中间的图片 和 重复利用图片两个对象.
        UIImageView *temp = self.centerImageV;
        self.centerImageV = self.reuseImageV;
        self.reuseImageV = temp;
        //交换两个图片的位置.
        self.centerImageV.frame = self.reuseImageV.frame;
        //初始化scrollView的偏移量.一开始显示中间部分.
        self.imageScrollView.contentOffset = CGPointMake(w, 0);
    }
}
/**
 *  即将开始拖拽的时候,停止定时器
 */
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopTimer];
    
}

/**
 *  停止拖拽的时候,开启定时器
 */
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startTimer];
}

@end
