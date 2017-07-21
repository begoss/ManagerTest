//
//  TestViewController.m
//  ManagerTest
//
//  Created by begoss on 2017/7/18.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import "TestViewController.h"
#import "BaseTableViewCell.h"
#import "BaseTableHeaderView.h"
#import "TestModel.h"
#import "TestFormHead.h"
#import "TestFormDataCell.h"
#import "AddDataView.h"

@interface TestViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UITextField *searchNameField;
@property (nonatomic, strong) UIButton *searchNameButton;
@property (nonatomic, assign) BOOL isEditing;
@property (nonatomic, strong) UIButton *deleteDataButton;
@property (nonatomic, strong) UIView *delView;
@property (nonatomic, strong) UIButton *cancelDelButton;
@property (nonatomic, strong) UIButton *selectAllButton;
@property (nonatomic, strong) UIButton *confirmDelButton;
@property (nonatomic, strong) NSMutableDictionary *delDic;
@property (nonatomic, strong) UIButton *addDataButton;

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"测试表格";
    [self setUI];
    self.dataSource = [NSMutableArray new];
    self.dataArray = [NSMutableArray new];
    self.delDic = [NSMutableDictionary new];
    self.isEditing = NO;
    [self.tableView registerClass:[BaseTableHeaderView class] forHeaderFooterViewReuseIdentifier:NSStringFromClass([BaseTableHeaderView class])];
    [self.tableView registerClass:[TestFormHead class] forCellReuseIdentifier:NSStringFromClass([TestFormHead class])];
    [self.tableView registerClass:[TestFormDataCell class] forCellReuseIdentifier:NSStringFromClass([TestFormDataCell class])];
    [self getRequestWithPath:@"http://10.0.20.152:8081/process_get" params:nil toInsert:NO tag:nil];
    WS(weakSelf);
//    [self.tableView viewWithUpLoad:^{
//        [self.tableView stopFooterRefreshing];
//    }];
    [self.tableView viewWithPullDown:^{
        [weakSelf getData];
    }];
    [self startLoad];
}

- (void)setUI {
     self.tableView.frame = CGRectMake(0, 144, SCREEN_WIDTH, SCREEN_HEIGHT - 144 - DEFULTTABBARHEIGHT);
    self.tableView.alwaysBounceVertical = YES;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.searchNameButton];
    [self.view addSubview:self.searchNameField];
    [self.view addSubview:self.deleteDataButton];
    [self.view addSubview:self.delView];
    [self.delView addSubview:self.cancelDelButton];
    [self.delView addSubview:self.selectAllButton];
    [self.delView addSubview:self.confirmDelButton];
    [self.view addSubview:self.addDataButton];
    [self.searchNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(20);
        make.bottom.equalTo(self.tableView.mas_top).offset(-20);
        make.width.equalTo(@200);
        make.height.equalTo(@40);
    }];
    [self.searchNameButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.searchNameField.mas_right).offset(20);
        make.centerY.equalTo(self.searchNameField);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
    }];
    [self.deleteDataButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.searchNameField);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
        make.left.equalTo(self.searchNameButton.mas_right).offset(50);
    }];
    [self.delView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.searchNameField);
        make.width.equalTo(@260);
        make.height.equalTo(@30);
        make.left.equalTo(self.deleteDataButton);
    }];
    [self.cancelDelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.delView);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
        make.left.equalTo(self.delView);
    }];
    [self.selectAllButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.delView);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
        make.centerX.equalTo(self.delView);
    }];
    [self.confirmDelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.delView);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
        make.right.equalTo(self.delView);
    }];
    self.delView.hidden = YES;
    [self.addDataButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.delView);
        make.width.equalTo(@80);
        make.height.equalTo(@30);
        make.left.equalTo(self.delView.mas_right).offset(50);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getData {
    [self getRequestWithPath:@"http://10.0.20.152:8081/process_get" params:nil toInsert:NO tag:nil];
}

- (void)successRequestForDict:(NSDictionary *)dic toInsert:(BOOL)insert tag:(NSString *)tag {
    if (!insert) {
        [self.dataSource removeAllObjects];
        [self.dataArray removeAllObjects];
    }
    TestModel *model = [TestModel mj_objectWithKeyValues:dic];
    for (TestModelData *data in model.data) {
        [self.dataSource addObject:data];
    }
    self.dataArray = [self.dataSource mutableCopy];
    [self.tableView reloadData];
    [self stopLoad];
    if ([self.tableView isHeadRefreshing]) {
        [self.tableView stopHeaderRefreshing];
    }
    if ([self.tableView isFootRefreshing]) {
        [self.tableView stopFooterRefreshing];
    }
}

- (void)searchNameAction {
    if (!self.searchNameField.text.length) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"搜索内容不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    [self.dataArray removeAllObjects];
    for (TestModelData *data in self.dataSource) {
        if ([data.name rangeOfString:self.searchNameField.text].location != NSNotFound) {
            [self.dataArray addObject:data];
        }
    }
    [self.tableView reloadData];
}

- (void)deleteDataAction {
    if (self.isEditing) {
        self.isEditing = NO;
        self.delView.hidden = YES;
        self.deleteDataButton.hidden = NO;
        [self.delDic removeAllObjects];
    }else {
        self.isEditing = YES;
        self.delView.hidden = NO;
        self.deleteDataButton.hidden = YES;
    }
    [self.tableView reloadData];
}

- (void)cancelDelAction {
    if (self.isEditing) {
        self.isEditing = NO;
        self.delView.hidden = YES;
        self.deleteDataButton.hidden = NO;
        [self.delDic removeAllObjects];
    }else {
        self.isEditing = YES;
        self.delView.hidden = NO;
        self.deleteDataButton.hidden = YES;
    }
    [self.tableView reloadData];
}

- (void)selectAllAction {
    if (self.dataArray.count == self.delDic.count) {
        [self.delDic removeAllObjects];
    }else {
        [self.delDic removeAllObjects];
        for (int i=0; i<self.dataArray.count; i++) {
            TestModelData *data = self.dataArray[i];
            [self.delDic setObject:data forKey:[NSString stringWithFormat:@"%ld",data.id]];
        }
    }
    [self.tableView reloadData];
}

- (void)confirmDelAction {
    if (self.delDic.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"未选择删除项" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    DLog(@"dic:%@",self.delDic);
    NSInteger count = self.delDic.count;
    for (int i=0; i<self.dataArray.count; i++) {
        TestModelData *data = self.dataArray[i];
        if ([self.delDic objectForKey:[NSString stringWithFormat:@"%ld",data.id]]!=nil) {
            [self.dataArray removeObjectAtIndex:i];
            i--;
            count--;
        }
        if (count == 0) {
            break;
        }
    }
    [self.delDic removeAllObjects];
    [self.tableView reloadData];
}

- (void)addDataAction {
    AddDataView *view = [[AddDataView alloc] initView];
    [view show];
    __weak typeof(view) weakView = view;
    [view setAddDataBlock:^(NSString *id,NSString *name,NSString *desc){
        BOOL isExisting = NO;
        for (int i=0; i<self.dataArray.count; i++) {
            TestModelData *data = self.dataArray[i];
            if (data.id == [id integerValue]) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"id已存在" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
                [alert show];
                isExisting = YES;
                return;
            }
        }
        if (!isExisting) {
            TestModelData *addData = [[TestModelData alloc] init];
            addData.id = [id integerValue];
            addData.name = name;
            addData.desc = desc;
            [self.dataArray addObject:addData];
            [self.tableView reloadData];
            [weakView hide];
        }
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.searchNameField endEditing:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.searchNameField endEditing:YES];
}

#pragma mark - Tableview Delegate & DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (!indexPath.row) {
        TestFormHead *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TestFormHead class])];
        return cell;
    }else {
        TestFormDataCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([TestFormDataCell class])];
        TestModelData *data = self.dataArray[indexPath.row-1];
        cell.model = data;
        cell.isEditing = self.isEditing;
        WS(weakSelf);
        [cell setEditBlock:^(BOOL selected){
            if (selected) {
                [weakSelf.delDic setObject:data forKey:[NSString stringWithFormat:@"%ld",data.id]];
            }else {
                [weakSelf.delDic removeObjectForKey:[NSString stringWithFormat:@"%ld",data.id]];
            }
        }];
        if ([self.delDic objectForKey:[NSString stringWithFormat:@"%ld",data.id]]!=nil) {
            cell.isSelected = YES;
        }else {
            cell.isSelected = NO;
        }
        return cell;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    BaseTableHeaderView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:NSStringFromClass([BaseTableHeaderView class])];
    view.label.text = @"测试数据";
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!indexPath.row) {
        return 56;
    }else {
        return 46;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return TITLESECTION_HEIGHT;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row) {
        TestModelData *model = self.dataArray[indexPath.row-1];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"数据" message:[NSString stringWithFormat:@"编号:%ld,名字:%@,描述:%@",model.id,model.name,model.desc] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
    }
}

#pragma mark - setter

- (UITextField *)searchNameField {
    if (!_searchNameField) {
        _searchNameField = [[UITextField alloc] init];
        _searchNameField.textColor = [UIColor text1Color];
        _searchNameField.placeholder = @"输入名字";
        _searchNameField.font = Font(15);
        _searchNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchNameField.borderStyle = UITextBorderStyleRoundedRect;
        _searchNameField.textAlignment = UITextAlignmentLeft;
        _searchNameField.keyboardType = UIKeyboardTypeDefault;
        _searchNameField.autocorrectionType = UITextAutocorrectionTypeNo;
        _searchNameField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _searchNameField.delegate = self;
    }
    return _searchNameField;
}

- (UIButton *)searchNameButton {
    if (!_searchNameButton) {
        _searchNameButton = [[UIButton alloc] init];
        _searchNameButton.backgroundColor = Color(100, 181, 246);
        [_searchNameButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _searchNameButton.titleLabel.font = Font(15);
        [_searchNameButton setTitle:@"搜索名字" forState:UIControlStateNormal];
        [_searchNameButton.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
        [_searchNameButton.layer setBorderWidth:1.0];
        [_searchNameButton.layer setBorderColor:Color(100, 181, 246).CGColor];//边框颜色
        [_searchNameButton addTarget:self action:@selector(searchNameAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchNameButton;
}

- (UIButton *)deleteDataButton {
    if (!_deleteDataButton) {
        _deleteDataButton = [[UIButton alloc] init];
        _deleteDataButton.backgroundColor = Color(100, 181, 246);
        [_deleteDataButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _deleteDataButton.titleLabel.font = Font(15);
        [_deleteDataButton setTitle:@"删除数据" forState:UIControlStateNormal];
        [_deleteDataButton.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
        [_deleteDataButton.layer setBorderWidth:1.0];
        [_deleteDataButton.layer setBorderColor:Color(100, 181, 246).CGColor];//边框颜色
        [_deleteDataButton addTarget:self action:@selector(deleteDataAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteDataButton;
}

- (UIView *)delView {
    if (!_delView) {
        _delView = [[UIView alloc] init];
        _delView.backgroundColor = [UIColor bg2Color];
    }
    return _delView;
}

- (UIButton *)cancelDelButton {
    if (!_cancelDelButton) {
        _cancelDelButton = [[UIButton alloc] init];
        _cancelDelButton.backgroundColor = Color(100, 181, 246);
        [_cancelDelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _cancelDelButton.titleLabel.font = Font(15);
        [_cancelDelButton setTitle:@"取消删除" forState:UIControlStateNormal];
        [_cancelDelButton.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
        [_cancelDelButton.layer setBorderWidth:1.0];
        [_cancelDelButton.layer setBorderColor:Color(100, 181, 246).CGColor];//边框颜色
        [_cancelDelButton addTarget:self action:@selector(cancelDelAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelDelButton;
}

- (UIButton *)selectAllButton {
    if (!_selectAllButton) {
        _selectAllButton = [[UIButton alloc] init];
        _selectAllButton.backgroundColor = Color(100, 181, 246);
        [_selectAllButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _selectAllButton.titleLabel.font = Font(15);
        [_selectAllButton setTitle:@"选择全部" forState:UIControlStateNormal];
        [_selectAllButton.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
        [_selectAllButton.layer setBorderWidth:1.0];
        [_selectAllButton.layer setBorderColor:Color(100, 181, 246).CGColor];//边框颜色
        [_selectAllButton addTarget:self action:@selector(selectAllAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectAllButton;
}

- (UIButton *)confirmDelButton {
    if (!_confirmDelButton) {
        _confirmDelButton = [[UIButton alloc] init];
        _confirmDelButton.backgroundColor = Color(100, 181, 246);
        [_confirmDelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmDelButton.titleLabel.font = Font(15);
        [_confirmDelButton setTitle:@"确认删除" forState:UIControlStateNormal];
        [_confirmDelButton.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
        [_confirmDelButton.layer setBorderWidth:1.0];
        [_confirmDelButton.layer setBorderColor:Color(100, 181, 246).CGColor];//边框颜色
        [_confirmDelButton addTarget:self action:@selector(confirmDelAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmDelButton;
}

- (UIButton *)addDataButton {
    if (!_addDataButton) {
        _addDataButton = [[UIButton alloc] init];
        _addDataButton.backgroundColor = Color(100, 181, 246);
        [_addDataButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _addDataButton.titleLabel.font = Font(15);
        [_addDataButton setTitle:@"添加数据" forState:UIControlStateNormal];
        [_addDataButton.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
        [_addDataButton.layer setBorderWidth:1.0];
        [_addDataButton.layer setBorderColor:Color(100, 181, 246).CGColor];//边框颜色
        [_addDataButton addTarget:self action:@selector(addDataAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addDataButton;
}

@end
