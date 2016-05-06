//
//  ZNRNewFeatureCell.h
//  租哪儿
//
//  Created by yuan on 16/4/7.
//  Copyright © 2016年 zunars. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZNRNewFeatureCell : UICollectionViewCell
@property(nonatomic ,strong) UIImage *image;

/**分页pageControl*/
@property (nonatomic ,weak)UIPageControl *pageControl;
/**添加立即体验按钮 方法*/
- (void)setStartBtn:(NSIndexPath *)indexPath count:(NSInteger)count;

@end
