//
//  Macro.h
//  ProgressDemo
//
//  Created by Vivien on 2018/3/7.
//  Copyright © 2018年 Vivien. All rights reserved.
//

#define UIColorFromRGB(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


//屏幕竖屏宽和高
#define SCREEN_HEIGHT MIN( [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width)
#define SCREEN_WIDTH  MAX( [UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height)

//以6plus为标准，在其他机型上控件大小等比缩放
//竖屏时宽比
#define kHeightPro(a) ( ((a)  * SCREEN_WIDTH) / 2208)
//竖屏时高比
#define kWidthPro(b) ( ((b)  * SCREEN_HEIGHT) / 1242)

//size
#define kScreenHeight         [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth          [[UIScreen mainScreen] bounds].size.width


#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;


#define NSLocalizedString(key, comment) [[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"Resources"  ofType:@"bundle"]] localizedStringForKey:(key) value:comment table:@"Root"]




