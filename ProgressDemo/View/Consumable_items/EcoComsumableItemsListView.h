//
//  EcoComsumableItemsListView.h
//  ProgressDemo
//
//  Created by Vivien on 2017/12/23.
//  Copyright © 2017年 ecovacs. All rights reserved.
//

#import "EcoBaseView.h"

@interface EcoComsumableItemsListView : EcoBaseView

@property (nonatomic, assign) int currentIndex; //当前正指向哪个按钮
@property (nonatomic,copy) void(^listBarItemClickBlock)(NSInteger itemIndex);

- (void)itemClickByScrollerWithIndex:(NSInteger)index;
- (void)setTitleArr:(NSMutableArray *)titleArr;
//按钮的背景色
- (void)setBtnBGColor:(UIColor *)color;
- (void)setSelectedColor:(UIColor *)color;
@end

