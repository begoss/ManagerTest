//
//  UIScrollView+Refresh.m
//  ManagerTest
//
//  Created by begoss on 2017/7/18.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import "UIScrollView+Refresh.h"
#import "MJRefresh.h"

@implementation UIScrollView (Refresh)

@dynamic headRefreshing, footRefreshing;

- (BOOL)isHeadRefreshing {
    return self.mj_header.isRefreshing;
}

- (BOOL)isFootRefreshing {
    return self.mj_footer.isRefreshing;
}

- (void)viewWithPullDown:(PullDwonBlock)block {
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        block();
    }];
    header.stateLabel.hidden = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    self.mj_header = header;
    //    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
    //        block();
    //    }];
    //    header.lastUpdatedTimeLabel.hidden = YES;
    //    header.stateLabel.hidden = YES;
    //    NSMutableArray *idleImages = [NSMutableArray array];
    //    for (NSUInteger i = 1; i<=27; i++) {
    //        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"header00%zd", i]];
    //        [idleImages addObject:image];
    //    }
    //    // 设置普通状态的动画图片
    //    [header setImages:idleImages forState:MJRefreshStateIdle];
    //    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    //    [header setImages:idleImages forState:MJRefreshStatePulling];
    //    // 设置正在刷新状态的动画图片
    //    [header setImages:idleImages forState:MJRefreshStateRefreshing];
    //
    //    // 设置header
    //    self.mj_header = header;
}

- (void)viewWithPullDownIgnoreInsetTop:(PullDwonBlock)block {
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        block();
    }];
    header.ignoredScrollViewContentInsetTop = 45;
    header.stateLabel.hidden = YES;
    header.lastUpdatedTimeLabel.hidden = YES;
    self.mj_header = header;
    
}

- (void)viewWithUpLoad:(UpLoadBlock)block {
    MJRefreshAutoNormalFooter *foot = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        block();
    }];
    
    foot.refreshingTitleHidden = YES;
    foot.stateLabel.hidden = YES;
    self.mj_footer = foot;
    
}

- (void)startHeaderRefreshing {
    [self.mj_header beginRefreshing];
}

- (void)stopHeaderRefreshing {
    [self.mj_header endRefreshing];
}

- (void)startFooterRefreshing {
    [self.mj_footer beginRefreshing];
}

- (void)stopFooterRefreshing {
    [self.mj_footer endRefreshing];
}

-(void)removeFooterRefreshing{
    [self.mj_footer removeFromSuperview];
    self.mj_footer = nil;
}

-(void)hideFooterRefreshing{
    self.mj_footer.hidden = YES;
}

-(void)showFooterRefreshing{
    self.mj_footer.hidden = NO;
}

@end

