//
//  MJRefreshNormalHeader.m
//  MJRefreshExample
//
//  Created by MJ Lee on 15/4/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "MJRefreshNormalHeader.h"
#import "GYCircleView.h"

@interface MJRefreshNormalHeader()
{
    __unsafe_unretained UIImageView *_arrowView;
}
@property (strong, nonatomic) UIImageView *loadingView;
@property (nonatomic, strong) GYCircleView *circleView;
@end

@implementation MJRefreshNormalHeader
#pragma mark - 懒加载子控件
- (UIImageView *)arrowView
{
    if (!_arrowView) {
        UIImage *image = [UIImage imageNamed:MJRefreshSrcName(@"arrow.png")] ?: [UIImage imageNamed:MJRefreshFrameworkSrcName(@"arrow.png")];
        UIImageView *arrowView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:_arrowView = arrowView];
        _arrowView.hidden = YES;
    }
    return _arrowView;
}

- (GYCircleView *)circleView {
    if (!_circleView) {
        _circleView = [[GYCircleView alloc] init];
        _circleView.circleColor = [UIColor colorWithHexString:@"d0d6dc"];
        _circleView.circleLineWidth = 2;
        [self addSubview:_circleView];
    }
    return _circleView;
}

- (UIImageView *)loadingView
{
    if(!_loadingView) {
        _loadingView = [[UIImageView alloc] initWithFrame:self.frame];
        NSArray *imageList = [NSArray new];
        for (NSUInteger i = 0; i < 40; i+=1) {
            NSString *iname = [NSString stringWithFormat:@"load-000%02lu", (unsigned long)i];
            UIImage *image = [UIImage imageNamed:iname];
            if (image) {
                imageList = [imageList arrayByAddingObject:image];
            }
        }
        _loadingView.animationImages = imageList;
        [_loadingView setAnimationRepeatCount:0];
        _loadingView.animationDuration = 0.6;
        _loadingView.contentMode = UIViewContentModeCenter;
        
//        CGPoint point = _loadingView.center;
//        [GMDCircleLoader setOnView:_loadingView withCGPoint:point  animated:YES];
//        
        
        
        [self addSubview:_loadingView];
    }
    return _loadingView;
}

#pragma mark - 公共方法
- (void)setActivityIndicatorViewStyle:(UIActivityIndicatorViewStyle)activityIndicatorViewStyle
{
    _activityIndicatorViewStyle = activityIndicatorViewStyle;
    
    self.loadingView = nil;
    [self setNeedsLayout];
}

#pragma mark - 重写父类的方法
- (void)prepare
{
    [super prepare];
    
    self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
}

- (void)placeSubviews
{
    [super placeSubviews];
    self.stateLabel.hidden = YES;
    // 箭头的中心点
    CGFloat arrowCenterX = self.mj_w * 0.5;
    if (!self.stateLabel.hidden) {
        arrowCenterX -= 100;
    }
    CGFloat arrowCenterY = self.mj_h * 0.5;
    CGPoint arrowCenter = CGPointMake(arrowCenterX, arrowCenterY);
    
    // 箭头
    if (self.arrowView.constraints.count == 0) {
        self.circleView.mj_size = CGSizeMake(32, 32);
        self.circleView.center = arrowCenter;
    }
        
    // 圈圈
    if (self.loadingView.constraints.count == 0) {
        self.loadingView.center = arrowCenter;
    }
}

- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState
    
    // 根据状态做事情
    if (state == MJRefreshStateIdle) {
        if (oldState == MJRefreshStateRefreshing) {
            self.arrowView.transform = CGAffineTransformIdentity;
            
            [UIView animateWithDuration:MJRefreshSlowAnimationDuration animations:^{
                self.loadingView.alpha = 0.0;
            } completion:^(BOOL finished) {
                // 如果执行完动画发现不是idle状态，就直接返回，进入其他状态
                if (self.state != MJRefreshStateIdle) return;
                
                self.loadingView.alpha = 1.0;
                [self.loadingView stopAnimating];
                self.circleView.hidden = NO;
            }];
        } else {
            [self.loadingView stopAnimating];
            self.circleView.hidden = NO;
            [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
                self.arrowView.transform = CGAffineTransformIdentity;
            }];
        }
    } else if (state == MJRefreshStatePulling) {
        [self.loadingView stopAnimating];
        self.circleView.hidden = NO;
        [UIView animateWithDuration:MJRefreshFastAnimationDuration animations:^{
            self.arrowView.transform = CGAffineTransformMakeRotation(0.000001 - M_PI);
        }];
    } else if (state == MJRefreshStateRefreshing) {
        self.loadingView.alpha = 1.0; // 防止refreshing -> idle的动画完毕动作没有被执行
        [self.loadingView startAnimating];
        self.circleView.hidden = YES;
    }
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
    
    // 当前的contentOffset
    CGFloat offsetY = self.scrollView.mj_offsetY;
    // 头部控件刚好出现的offsetY
    CGFloat happenOffsetY = - self.scrollViewOriginalInset.top;
    
    // 如果是向上滚动到看不见头部控件，直接返回
    // >= -> >
    if (offsetY > happenOffsetY) return;
    
    // 普通 和 即将刷新 的临界点
    CGFloat pullingPercent = (happenOffsetY - offsetY - 30) / 24;
    
    self.circleView.offsetY = -pullingPercent * 100 ;
    
}
@end
