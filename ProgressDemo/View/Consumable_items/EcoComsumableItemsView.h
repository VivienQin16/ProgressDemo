//
//  EcoComsumableItemsView.h
//  ProgressDemo
//
//  Created by Vivien on 2017/12/23.
//  Copyright © 2017年 ecovacs. All rights reserved.
//

#import "EcoBaseView.h"


@protocol EcoComsumableItemsViewDelegate <NSObject>
@optional

/**
 @param btnIndex btnIndex: 底部按钮index
 @param listIndex 顶部按钮Index
 */
- (void)bottomBtnAction:(int)btnIndex index:(int)listIndex;
@end

@interface EcoComsumableItemsView : EcoBaseView
//设置listview高度
@property (nonatomic, assign) CGFloat listViewHeight;
@property (nonatomic, assign) int currentIndex;//当前index

@property (weak, nonatomic) id<EcoComsumableItemsViewDelegate> delegate;

/**
 设置顶部listView的title
 @param arr 
 */
- (void)setListViewTitleArr:(NSArray *)arr;
/**
 设置底部按钮的title 数组
 @param arr
 */
- (void)setBottomBtnsViewTitleArr:(NSArray *)arr;
//只有一个按钮时调用
- (void)setBottomBtnViewTitle:(NSString *)str;

- (void)startAnimationWithProgress:(int)number;

/**
 根据索引设置XX剩余值
 @param value  剩余百分比
 @param hour   剩余小时数
 @param index 当前索引
 */
- (void)setLeftValue:(int)value index:(int)index;
- (void)setLeftValue:(int)value leftHour:(int)hour index:(int)index;
/**
 一次性设置所有XX的剩余值
 @param valueArr
 */
- (void)setLeftValueArr:(NSArray *)valueArr;

@end
