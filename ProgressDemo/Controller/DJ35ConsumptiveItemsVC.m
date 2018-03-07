//
//  ACMaterialConsumptiveVC.m
//  Anbot
//
//  Created by QinTing on 15/12/25.
//  Copyright © 2015年 Ecovacs. All rights reserved.
//

#import "DJ35ConsumptiveItemsVC.h"
//#import "EcoRobotConsumablesHelper.h"
//#import "UIAlertController+Blocks.h"
@interface DJ35ConsumptiveItemsVC ()
{

}

@end

@implementation DJ35ConsumptiveItemsVC

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    int hepaValue =   30;
    hepaValue = hepaValue < 0 ?0:hepaValue;
    int hepaHour = 40;
    hepaHour = hepaHour < 0 ?0:hepaHour;
    int sideLifeValue =  50;
    sideLifeValue = sideLifeValue < 0 ?0:sideLifeValue;
    int sideLifeHour = 150;
    sideLifeHour = sideLifeHour < 0 ?0:sideLifeHour;
    int rollingLifeValue = 50;
    rollingLifeValue = rollingLifeValue < 0 ?0:rollingLifeValue;
    int rollingLifeHour = 150;
    rollingLifeHour = rollingLifeHour < 0 ?0:rollingLifeHour;

   
    [self.wholeView setLeftValue:sideLifeValue leftHour:sideLifeHour index:0];
    [self.wholeView setLeftValue:rollingLifeValue leftHour:rollingLifeHour  index:1];
    [self.wholeView setLeftValue:hepaValue leftHour:hepaHour index:2];
    
    _leftValueArr = [[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%d",sideLifeValue],[NSString stringWithFormat:@"%d",rollingLifeValue],[NSString stringWithFormat:@"%d",hepaValue],nil];
    
    _hourArr = [[NSArray alloc]initWithObjects:[NSString stringWithFormat:@"%d",sideLifeHour],[NSString stringWithFormat:@"%d",rollingLifeHour],[NSString stringWithFormat:@"%d",hepaHour],nil];
    
}

- (void)setCurrentIndex:(int)currentIndex
{
    _currentIndex = currentIndex;
    self.wholeView.currentIndex = _currentIndex;
//    [self.wholeView setViewScrollToIndex:_currentIndex];
}
#pragma mark ———— EcoComsumableItemsViewDelegate

/**
 @param btnIndex 点击的是XX复位还是XX购买
 @param listIndex 是哪种XX
 */
- (void)bottomBtnAction:(int)btnIndex index:(int)listIndex
{
    if (btnIndex == 0) {
        [self resetAlertShow:listIndex];
    }else{ //XX购买，页面跳转
//        NSString * currentConsumable = [EcoCommonFunc getCurrentConsumableWithIndex:listIndex];
//        [[EcoRobotConsumablesHelper shared] getMoreConsumableswWithConsumableType:currentConsumable consumablesPercentage:_leftValueArr[listIndex] control:self];
    }
}

/**
 弹框
 */
- (void)resetAlertShow:(int)listIndex
{
    NSArray *titleArr = [[NSArray alloc]initWithObjects:NSLocalizedString(@"SideBrush", nil),NSLocalizedString(@"Brush", nil),NSLocalizedString(@"Hepa", nil), nil];
//    [UIAlertController showAlertInViewController:self withTitle:nil message:[NSString stringWithFormat:(@"Reset_Alert_Message", nil),titleArr[listIndex]]  cancelButtonTitle:IOTWiFiConfigurationLocalizedString(@"Cancel",nil) destructiveButtonTitle:nil otherButtonTitles:@[@"确认"] tapBlock:^(UIAlertController * _Nonnull controller, UIAlertAction * _Nonnull action, NSInteger buttonIndex) {
//        if (buttonIndex == 2) {
//            [self consumptiveItemsReset:listIndex];
//        }
//    }];
}

/**
 Reset功能
 */
- (void)consumptiveItemsReset:(int)listIndex//DJ35ConsumptiveItemsVC
{
    WS(ws);
    NSArray *valueArray = [[NSArray alloc]initWithObjects:@"sideBrush",@"rollingBrush",@"hepa", nil];
    if (listIndex >= valueArray.count) {
        return;
    }
//    [[AlinkStatusViewModel sharedAlinkViewModel] setStatusKey:@"ResetLifeSpan" value:valueArray[listIndex] result:^(AlinkResponse * response) {
//        if (response.successed) {
//            int leftHour = [_hourArr[listIndex] intValue] ;
//            [ws.wholeView setLeftValue:100 leftHour:leftHour index:listIndex];
//        }else{
//             [ComView showToast:ws.view Msg:NSLocalizedString(@"DataPush_TimeOut_Error", nil) Duration:3 PositionCenter:CSToastPositionUnderneath];
//        }
//    }];
}

@end
