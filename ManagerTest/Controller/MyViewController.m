//
//  MyViewController.m
//  ManagerTest
//
//  Created by 刘润东 on 2017/7/20.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import "MyViewController.h"
#import "OneCell.h"
#import "TwoCell.h"
#import "ThreeCell.h"
#import "MainPageModel.h"

@interface MyViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSArray *imgArray;
@property (nonatomic, strong) NSArray *textArray;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = [NSMutableArray new];
    self.imgArray = @[@"del_selected",@"del_selected",@"del_selected",@"del_selected"];
    self.textArray = @[@"text1",@"text2",@"text3",@"text4"];
    [self.tableView registerClass:[OneCell class] forCellReuseIdentifier:NSStringFromClass([OneCell class])];
    [self.tableView registerClass:[TwoCell class] forCellReuseIdentifier:NSStringFromClass([TwoCell class])];
    [self.tableView registerClass:[ThreeCell class] forCellReuseIdentifier:NSStringFromClass([ThreeCell class])];
    [self getRequestWithPath:@"http://10.0.20.152:8081/home_test_data" params:nil toInsert:NO tag:nil];
    [self startLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)successRequestForDict:(NSDictionary *)dic toInsert:(BOOL)insert tag:(NSString *)tag {
    MainPageModel *model = [MainPageModel mj_objectWithKeyValues:dic];
    for (MainPageDetailModel *detailModel in model.data) {
        [self.dataSource addObject:detailModel];
    }
    [self.tableView reloadData];
    [self stopLoad];
}

#pragma mark - Tableview Delegate & DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 3;
    }
    return self.dataSource.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        OneCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([OneCell class])];
        MainPageUpperModel *mo = [MainPageUpperModel new];
        mo.imgArray=self.imgArray;
        mo.titleArray=self.textArray;
        mo.title=@"hhh";
        cell.model = mo;
        return cell;
    }
    if(indexPath.row == 0){
        TwoCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TwoCell class])];
        return cell;
    }
    ThreeCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ThreeCell class])];
    MainPageDetailModel *mo = self.dataSource[indexPath.row-1];
    cell.model = mo;
    [cell setTapBlock:^(NSString *aaaa){
        DLog(@"title:%@",aaaa);
    }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section) {
        if (!indexPath.row) {
            return 50;
        }else {
            return 90;
        }
    }else {
        return 80;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 1)
        return SECTIONGAP;
    return 0.001;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DLog(@"section:%ld,row:%ld",indexPath.section,indexPath.row);
}

@end
