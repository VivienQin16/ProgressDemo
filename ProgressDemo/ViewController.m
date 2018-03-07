//
//  ViewController.m
//  ProgressDemo
//
//  Created by Vivien on 2018/3/7.
//  Copyright © 2018年 Vivien. All rights reserved.
//

#import "ViewController.h"
#import "DJ35ConsumptiveItemsVC.h"
@interface ViewController ()
@property (nonatomic, strong) NSArray *leftValueArr;
@property (nonatomic, strong) NSArray *hourArr;
@property (nonatomic, assign) int currentIndex;
@end

@implementation ViewController


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(kWidthPro(240),
                                                                  kWidthPro(700 + 50 - 230),
                                                                  kWidthPro(1162 - 480),
                                                                  kWidthPro(120))];
    button.layer.cornerRadius = kWidthPro(60.f);
    button.layer.borderWidth = 1.f;
//    button.text = @"下一步";
    [button setTitle:@"下一步" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor  greenColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}


- (void)btnClicked
{
    DJ35ConsumptiveItemsVC *itemVC = [[DJ35ConsumptiveItemsVC alloc]init];
    [self presentViewController:itemVC animated:YES completion:nil];
//    [self.navigationController pushViewController:itemVC animated:YES];
}


@end
