//
//  MJRefreshAutoNormalFooter.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/4/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "MJRefreshAutoNormalFooter.h"

@interface MJRefreshAutoNormalFooter()
@property (strong, nonatomic) UIImageView *loadingView;
@end

@implementation MJRefreshAutoNormalFooter
#pragma mark - 懒加载子控件
//- (UIActivityIndicatorView *)loadingView
//{
//    if (!_loadingView) {
//        UIActivityIndicatorView *loadingView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:self.activityIndicatorViewStyle];
//        loadingView.hidesWhenStopped = YES;
//        [self addSubview:_loadingView = loadingView];
//    }
//    return _loadingView;
//}
- (UIImageView *) loadingView
{
    if(!_loadingView) {
        _loadingView = [[UIImageView alloc] initWithFrame:self.frame];
        NSArray *imageList = [NSArray new];
        for (NSUInteger i = 0; i < 40; i+=1) {
            NSString *iname = [NSString stringWithFormat:@"load-000%02lu", (unsigned long)i];
            imageList = [imageList arrayByAddingObject:[UIImage imageNamed:iname]];
        }
        
        _loadingView.animationImages = imageList;
        [_loadingView setAnimationRepeatCount:0];
        _loadingView.animationDuration = 0.6;
        _loadingView.contentMode = UIViewContentModeCenter;
        
        //                [self addSubview:_indicator = indicator];
        
        //                self.indicator = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
        //                self.indicator.center = self.view.center;
        //        indicator.frame = CGRectMake(0, 0, 32, 32);
        //        indicator.image = [UIImage imageNamed:@"load-00001"];
        //        indicator.contentMode = UIViewContentModeScaleAspectFit;
        //        //
        //        CABasicAnimation* rotationAnimation;
        //        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        //        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 /* full rotation*/ * 1.0];
        //        rotationAnimation.duration = 0.9;
        //        rotationAnimation.cumulative = YES;
        //        rotationAnimation.repeatCount = 999999;
        //        //
        //        [indicator.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        [self addSubview:_loadingView];
    }
    return _loadingView;
}
- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle
{
    _activityIndicatorViewStyle = activityIndicatorViewStyle;
    
    self.loadingView = nil;
    [self setNeedsLayout];
}
#pragma makr - 重写父类的方法
- (void)prepare
{
    [super prepare];
    
    self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}

- (void)placeSubviews
{
    [super placeSubviews];
    
    if (self.loadingView.constraints.count) return;
    
    // 圈圈
    CGFloat loadingCenterX = self.mj_w * 0.5;
    if (!self.isRefreshingTitleHidden) {
        loadingCenterX -= 100;
    }
    CGFloat loadingCenterY = self.mj_h * 0.5;
    self.loadingView.center = CGPointMake(loadingCenterX, loadingCenterY);
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    // 根据状态做事情
    if (state == MJRefreshStateNoMoreData || state == MJRefreshStateIdle) {
        [self.loadingView stopAnimating];
    } else if (state == MJRefreshStateRefreshing) {
        [self.loadingView startAnimating];
    }
}

@end
