//
//  AddDataView.h
//  ManagerTest
//
//  Created by begoss on 2017/7/19.
//  Copyright © 2017年 begoss. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddDataView : UIView

- (instancetype)initView;
- (void)show;
- (void)hide;
@property (nonatomic, strong) void(^addDataBlock)(NSString *id,NSString *name,NSString *desc);

@end
