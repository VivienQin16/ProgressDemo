//
//  EcoMaterialCosumableVC.m
//  ProgressDemo
//
//  Created by Vivien on 2017/12/16.
//  Copyright © 2017年 ecovacs. All rights reserved.
//

#import "EcoMaterialConsumptiveVC.h"

@interface EcoMaterialConsumptiveVC ()<EcoComsumableItemsViewDelegate>

@end

@implementation EcoMaterialConsumptiveVC

- (void)initViews
{
    [super initViews];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = NSLocalizedString(@"Consumptive_Counting", nil); 
    [self.view addSubview:self.wholeView];
    WS(ws);
    [self.wholeView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(ws.view);
    }];
    
    NSArray *titleArr = [[NSArray alloc]initWithObjects:NSLocalizedString(@"SideBrush", nil),NSLocalizedString(@"Brush", nil),NSLocalizedString(@"Hepa", nil),nil];
    [_wholeView setListViewTitleArr:titleArr];
    NSArray *bottomTitleArr = [[NSArray alloc]initWithObjects:@"XX复位",@"XX购买",nil];
    [_wholeView setBottomBtnsViewTitleArr:bottomTitleArr];
    
}

- (void)setup
{

 
}

//#pragma mark ———— EcoComsumableItemsViewDelegate
- (void)bottomBtnAction:(int)btnIndex index:(int)listIndex
{


}


#pragma mark —— 视图初始化
- (EcoComsumableItemsView *)wholeView
{
    if (!_wholeView) {
        _wholeView = [[EcoComsumableItemsView alloc]init];
        _wholeView.delegate = self;
    }
    return _wholeView;
}
- (NSMutableArray *)lifeArray
{
    if (!_lifeArray) {
        _lifeArray = [[NSMutableArray alloc]init];
    }
    return _lifeArray;
}
@end
