//
//  BaseTableViewController.m
//  ManagerTest
//
//  Created by begoss on 2017/7/18.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import "BaseTableViewController.h"
#import "Reachability.h"
#import "UIScrollView+MJRefresh.h"

@interface BaseTableViewController ()

@property (nonatomic, strong) Reachability *reachability;

@property (nonatomic, assign) NSInteger lastRefreshCount;

@property (nonatomic, assign) BOOL isLoadAnimation;

@end

@implementation BaseTableViewController

#pragma mark - life style
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    self.needRefresh = YES;
    WS(weakSelf);
    self.netWorkError = ^(){
        [weakSelf.view addSubview:weakSelf.netErrorView];
        [weakSelf stopLoad];
    };
    //    [self startLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.isLoadAnimation) {
        [self stopLoadAnimation];
        [self startLoadAnimation];
    }
    //    self.needRefresh = YES;
    //    [self startLoad];
    if (self.reachability.currentReachabilityStatus == NotReachable) {
        //        [self stopLoad];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)failureRequestMessage:(NSString *)msg tag:(NSString *)tag {
    [self stopLoad];
    [self.tableView stopHeaderRefreshing];
    [self.tableView stopFooterRefreshing];
    [self.view showBadtipsAlert:msg];
}

#pragma mark - method
- (void)refreshFrame {
    self.tableView.frame = CGRectMake(0, self.headerHeight, SCREEN_WIDTH, SCREEN_HEIGHT - self.headerHeight - DEFULTTABBARHEIGHT);
    //    CGFloat top = self.tableView.contentInset.top;
    //    CGFloat bottom = self.tableView.contentInset.bottom;
    //    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

- (void)startLoad {
    if (self.netWorkEnable) {
        [self startAnimation];
    }
}

- (void)startAnimation{
    self.tableView.scrollEnabled = NO;
    CGFloat top = self.tableView.contentInset.top;
    
    CGFloat bottom = self.tableView.contentInset.bottom - ((self.tableView.mj_footer)?44:0);
    self.loadBackgroundImage.frame = CGRectMake(0, self.tableView.frame.origin.y + top, self.tableView.frame.size.width, self.tableView.frame.size.height-top-bottom);
    self.loadBackgroundImage.center = CGPointMake(self.tableView.center.x, self.tableView.center.y + top/2 - bottom/2);
    [self.view addSubview:self.loadBackgroundImage];
    [self.view bringSubviewToFront:self.loadBackgroundImage];
    
    self.loadImage.center = self.loadBackgroundImage.center;
    [self.view addSubview:self.loadImage];
    [self.view bringSubviewToFront:self.loadImage];
    [self startLoadAnimation];
    self.isLoadAnimation = YES;
}

- (void)stopLoad {
    //[self.tableView stopLoad];
    self.tableView.scrollEnabled = YES;
    //    [self.loadImage stopAnimating];
    [self stopLoadAnimation];
    [self.loadImage removeFromSuperview];
    [self.loadBackgroundImage removeFromSuperview];
    self.isLoadAnimation = NO;
}

- (void)reloginRequest {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"userInfo"];
    [[NSUserDefaults standardUserDefaults] setObject:@"true" forKey:@"relogin"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadTabBarController" object:nil];
}

#pragma mark - tableView dataSource and delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {return 0;}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {return nil;}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {return 0.001;}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {return 0.001;}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    NSInteger section = [tableView numberOfSections];
    NSInteger rows = [tableView numberOfRowsInSection:section - 1];
    //如果rows < lastRefreshCount 说明下拉刷新了界面
    if (self.lastRefreshCount > rows) {
        self.lastRefreshCount = 0;
    }
    if ((rows - indexPath.row) == 15 && self.needRefresh && indexPath.row > 10 && rows >= 29 && rows != self.lastRefreshCount) {
        self.lastRefreshCount = rows;
        [tableView startFooterRefreshing];
        self.needRefresh = NO;
    }
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
    if (translation.y>0) {
        self.needRefresh = NO;
    }else {
        self.needRefresh = YES;
    }
}

-(void)netErrorAction{
    [self.netErrorView removeFromSuperview];
    [self startAnimation];
    [self.tableView startHeaderRefreshing];
}

#pragma mark - getter and setter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headerHeight, SCREEN_WIDTH, SCREEN_HEIGHT - self.headerHeight - 49) style:UITableViewStyleGrouped];
        _tableView.contentInset = UIEdgeInsetsMake(-64, 0, 0, 0);
        _tableView.backgroundColor = [UIColor bg1Color];
        _tableView.separatorColor = [UIColor selectedColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}

- (UIImageView *)loadImage {
    if (!_loadImage) {
        _loadImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
        UIImage *imgIndicator;
        switch (self.LoadingStyle) {
            case LoadingStyleLight:
                imgIndicator = [UIImage imageNamed:@"indicator_light"];
                break;
            case LoadingStyleDark:
                imgIndicator = [UIImage imageNamed:@"indicator_dark"];
                break;
            default:
                break;
        }
        [_loadImage setImage:imgIndicator];
        _loadImage.contentMode = UIViewContentModeCenter;
        _loadImage.backgroundColor = [UIColor clearColor];
    }
    return _loadImage;
}
- (UIImageView *)loadBackgroundImage {
    if (!_loadBackgroundImage) {
        _loadBackgroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        UIImage *imgBgIndicator;
        switch (self.LoadingStyle) {
            case LoadingStyleLight:
                imgBgIndicator = [UIImage imageNamed:@"bg_indicator_light"];
                break;
            case LoadingStyleDark:
                imgBgIndicator = [UIImage imageNamed:@"bg_indicator_dark"];
                break;
            default:
                break;
        }
        [_loadBackgroundImage setImage:imgBgIndicator];
        _loadBackgroundImage.contentMode = UIViewContentModeCenter;
        _loadBackgroundImage.backgroundColor = Color(225, 230, 235);
    }
    return _loadBackgroundImage;
}
- (void)startLoadAnimation{
    [self.loadImage.layer addAnimation:[self rotation:LOADING_ANMI_TIME degree:M_PI * 2 direction:1] forKey:@"loadRotation"];
}
- (void)stopLoadAnimation{
    
    [self.loadImage.layer removeAllAnimations];
}
-(CABasicAnimation *)rotation:(float)dur degree:(float)degree direction:(int)direction{
    //    CATransform3D rotationTransform = CATransform3DMakeRotation(M_PI, 0, 0, direction);
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation.toValue = [NSNumber numberWithFloat:degree];
    animation.duration  =  dur;
    animation.autoreverses = NO;
    animation.cumulative = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.repeatCount = HUGE_VALF;
    animation.delegate = self;
    
    return animation;
    
}
- (Reachability *)reachability {
    if (!_reachability) {
        _reachability = [Reachability reachabilityForInternetConnection];
    }
    return _reachability;
}


@end
