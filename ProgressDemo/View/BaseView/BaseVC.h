//
//  BaseVC.h
//  EcoRobotSDK
//
//  Created by desheng.li on 2017/3/24.
//  Copyright © 2017年 RD4. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseVC : UIViewController
@property(nonatomic, strong) UIView   *contentView; //用来做iPhoneX的适配。
- (void)initViews;

@end
