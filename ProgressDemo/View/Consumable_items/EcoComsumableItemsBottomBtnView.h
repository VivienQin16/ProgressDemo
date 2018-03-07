//
//  EcoComsumableItemsBottomBtnView.h
//  ProgressDemo
//
//  Created by Vivien on 2017/12/23.
//  Copyright © 2017年 ecovacs. All rights reserved.
//

#import "EcoBaseView.h"
//XX计时，底部按钮
@interface EcoComsumableItemsBottomBtnView : EcoBaseView

- (void)setTitleArr:(NSArray *)titleArr;
- (void)setBorderColor:(UIColor *)color;
- (void)setBorderWidth:(CGFloat)width;

//按钮点击block
@property (nonatomic, copy) void (^bottomBtnClicked)(int btnTag);

@end
