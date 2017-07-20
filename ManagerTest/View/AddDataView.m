//
//  AddDataView.m
//  ManagerTest
//
//  Created by begoss on 2017/7/19.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import "AddDataView.h"

@interface AddDataView ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *baseView;
@property (nonatomic, strong) UILabel *addIdLabel;
@property (nonatomic, strong) UILabel *addNameLabel;
@property (nonatomic, strong) UILabel *addDescLabel;
@property (nonatomic, strong) UITextField *addIdTF;
@property (nonatomic, strong) UITextField *addNameTF;
@property (nonatomic, strong) UITextField *addDescTF;
@property (nonatomic, strong) UIButton *addButton;
@property (nonatomic, strong) UIButton *cancelAddButton;

@end

@implementation AddDataView

- (instancetype)initView {
    if (self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)]) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        [self addSubview:self.baseView];
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
//        [self addGestureRecognizer:tap];
        
        [self.baseView addSubview:self.addIdTF];
        [self.baseView addSubview:self.addNameTF];
        [self.baseView addSubview:self.addDescTF];
        [self.baseView addSubview:self.addButton];
        [self.baseView addSubview:self.cancelAddButton];
        [self.addIdTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
            make.left.offset(60);
            make.right.offset(-60);
            make.top.offset(40);
        }];
        [self.addNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
            make.left.offset(60);
            make.right.offset(-60);
            make.top.equalTo(self.addIdTF.mas_bottom).offset(40);
        }];
        [self.addDescTF mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@40);
            make.left.offset(60);
            make.right.offset(-60);
            make.top.equalTo(self.addNameTF.mas_bottom).offset(40);
        }];
        [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@80);
            make.height.equalTo(@30);
            make.bottom.offset(-40);
            make.left.equalTo(self.addIdTF);
        }];
        [self.cancelAddButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@80);
            make.height.equalTo(@30);
            make.bottom.offset(-40);
            make.right.equalTo(self.addIdTF);
        }];
    }
    return self;
}

- (void)show {
    UIWindow *keywindow = [[UIApplication sharedApplication] keyWindow];
    [keywindow addSubview:self];
    self.baseView.frame = CGRectMake(SCREEN_WIDTH/4, SCREEN_HEIGHT+20, SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    self.alpha = 0;
    [UIView animateWithDuration:0.2 animations:^{
        self.baseView.frame = CGRectMake(SCREEN_WIDTH/4, SCREEN_HEIGHT/6, SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
        self.alpha = 1;
    }];
}

-(void)hide{
    [UIView animateWithDuration:0.2 animations:^{
        self.baseView.frame = CGRectMake(SCREEN_WIDTH/4, SCREEN_HEIGHT+20, SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.baseView = nil;
    }];
}

- (void)addDataAction {
    if (!self.addIdTF.text.length || !self.addNameTF.text.length || !self.addDescTF.text.length) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入完整信息" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    DLog(@"id:%@,name:%@,desc:%@",self.addIdTF.text,self.addNameTF.text,self.addDescTF.text);
    if (self.addDataBlock) {
        self.addDataBlock(self.addIdTF.text, self.addNameTF.text, self.addDescTF.text);
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

#pragma mark - setter

-(UIView *)baseView{
    if (!_baseView) {
        _baseView = [[UIView alloc] init];
        _baseView.backgroundColor = [UIColor whiteColor];
        _baseView.layer.cornerRadius = 5.0f;
        _baseView.clipsToBounds = YES;
    }
    return _baseView;
}

//- (UILabel *)addIdLabel {
//    if (!_addIdLabel) {
//        _addIdLabel = [UILabel new];
//        _addIdLabel.font = Font(16);
//        _addIdLabel.textColor = [UIColor text2Color];
//        _addIdLabel.text = @"";
//    }
//    return _addIdLabel;
//}

- (UITextField *)addIdTF {
    if (!_addIdTF) {
        _addIdTF = [[UITextField alloc] init];
        _addIdTF.textColor = [UIColor text1Color];
        _addIdTF.placeholder = @"输入id";
        _addIdTF.font = Font(15);
        _addIdTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _addIdTF.borderStyle = UITextBorderStyleRoundedRect;
        _addIdTF.textAlignment = UITextAlignmentLeft;
        _addIdTF.keyboardType = UIKeyboardTypeDefault;
        _addIdTF.autocorrectionType = UITextAutocorrectionTypeNo;
        _addIdTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _addIdTF.delegate = self;
    }
    return _addIdTF;
}

- (UITextField *)addNameTF {
    if (!_addNameTF) {
        _addNameTF = [[UITextField alloc] init];
        _addNameTF.textColor = [UIColor text1Color];
        _addNameTF.placeholder = @"输入名字";
        _addNameTF.font = Font(15);
        _addNameTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _addNameTF.borderStyle = UITextBorderStyleRoundedRect;
        _addNameTF.textAlignment = UITextAlignmentLeft;
        _addNameTF.keyboardType = UIKeyboardTypeDefault;
        _addNameTF.autocorrectionType = UITextAutocorrectionTypeNo;
        _addNameTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _addNameTF.delegate = self;
    }
    return _addNameTF;
}

- (UITextField *)addDescTF {
    if (!_addDescTF) {
        _addDescTF = [[UITextField alloc] init];
        _addDescTF.textColor = [UIColor text1Color];
        _addDescTF.placeholder = @"输入描述";
        _addDescTF.font = Font(15);
        _addDescTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _addDescTF.borderStyle = UITextBorderStyleRoundedRect;
        _addDescTF.textAlignment = UITextAlignmentLeft;
        _addDescTF.keyboardType = UIKeyboardTypeDefault;
        _addDescTF.autocorrectionType = UITextAutocorrectionTypeNo;
        _addDescTF.autocapitalizationType = UITextAutocapitalizationTypeNone;
        _addDescTF.delegate = self;
    }
    return _addDescTF;
}

- (UIButton *)addButton {
    if (!_addButton) {
        _addButton = [[UIButton alloc] init];
        _addButton.backgroundColor = Color(100, 181, 246);
        [_addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _addButton.titleLabel.font = Font(15);
        [_addButton setTitle:@"确认添加" forState:UIControlStateNormal];
        [_addButton.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
        [_addButton.layer setBorderWidth:1.0];
        [_addButton.layer setBorderColor:Color(100, 181, 246).CGColor];//边框颜色
        [_addButton addTarget:self action:@selector(addDataAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

- (UIButton *)cancelAddButton {
    if (!_cancelAddButton) {
        _cancelAddButton = [[UIButton alloc] init];
        _cancelAddButton.backgroundColor = Color(100, 181, 246);
        [_cancelAddButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _cancelAddButton.titleLabel.font = Font(15);
        [_cancelAddButton setTitle:@"取消添加" forState:UIControlStateNormal];
        [_cancelAddButton.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
        [_cancelAddButton.layer setBorderWidth:1.0];
        [_cancelAddButton.layer setBorderColor:Color(100, 181, 246).CGColor];//边框颜色
        [_cancelAddButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelAddButton;
}

@end
