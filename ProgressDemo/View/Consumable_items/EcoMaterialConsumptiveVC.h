//
//  EcoMaterialCosumableVC.h
//  ProgressDemo
//
//  Created by Vivien on 2017/12/16.
//  Copyright © 2017年 ecovacs. All rights reserved.
//

#import "BaseVC.h"
#import "EcoComsumableItemsView.h"
@interface EcoMaterialConsumptiveVC : BaseVC<UIScrollViewDelegate>

@property (nonatomic, strong) EcoComsumableItemsView *wholeView;
@property (nonatomic, strong) NSMutableArray *lifeArray;
@property (nonatomic, strong) NSMutableArray *leftHourArr;
@end
