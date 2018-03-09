//
//  BaseVC.m
//  EcoRobotSDK
//
//  Created by desheng.li on 2017/3/24.
//  Copyright © 2017年 RD4. All rights reserved.
//

#import "BaseVC.h"

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];

    WS(ws);
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view);
    }];

    [self initViews];
}

- (void)initViews
{
    
}


- (void)viewSafeAreaInsetsDidChange {
    [super viewSafeAreaInsetsDidChange];
    WS(ws);
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        if ([UIDevice currentDevice].systemVersion.floatValue >= 11.0) {
            make.edges.equalTo(ws.view).insets(ws.view.safeAreaInsets);
        } else {
            make.edges.equalTo(ws.view);
        }
    }];
//    [self updateNeedLayoutForAdapt_iPhoneX];
}

- (UIView *)contentView
{
    if(!_contentView){
        _contentView = [[UIView alloc]init];
        [self.view addSubview:_contentView];
    }
    return _contentView;
}


@end
