//
//  EcoComsumableItemLeftView.h
//  ProgressDemo
//
//  Created by Vivien on 2017/12/23.
//  Copyright © 2017年 ecovacs. All rights reserved.
//

#import "EcoBaseView.h"
//XX剩余
@interface EcoComsumableItemLeftView : EcoBaseView

@property (nonatomic, assign) int leftValue; //剩余的值
/**
 XX正常时，进度条颜色
 */
@property (nonatomic, strong) UIColor *progressStrokeColor;

/**
 当XX低于阀值时，警告颜色
 */
@property (nonatomic, strong) UIColor *warningStoreColor;
@property (nonatomic, assign) CGFloat bottomHeight; //距离底部的高度

/**
 警告罚值；默认为5;
 progressLayer在leftValue超过warnValue时的颜色为progressStrokeColor；
 低于warnValue时为warningStoreColor；
 */
@property (nonatomic, assign) CGFloat warnValue;
//动画
- (void)startAnimationWithProgress:(int)number;

/**
 顶部提示语，@"预计剩余**小时"

 @param text String
 */
- (void)setTopHintText:(NSString *)text;
- (void)setTopLeftValue:(int )hour;
- (void)setBottomTitleText:(NSString *)text;

@end
