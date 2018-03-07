//
//  EcoComsumableItemsView.m
//  ProgressDemo
//
//  Created by Vivien on 2017/12/23.
//  Copyright © 2017年 ecovacs. All rights reserved.
//

#import "EcoComsumableItemsView.h"
#import "EcoComsumableItemsListView.h"
#import "EcoComsumableItemLeftView.h"
#import "EcoComsumableItemsBottomBtnView.h"
#define EcoComsumableItemLeftViewTAG   100

@interface EcoComsumableItemsView()<UIScrollViewDelegate>
{
    UIView *contentView;
}
@property (nonatomic, strong) EcoComsumableItemsListView *listView;
@property (nonatomic, strong) EcoComsumableItemLeftView *leftView;
@property (nonatomic, strong) EcoComsumableItemsBottomBtnView *bottomBtnView;
@property (nonatomic, strong) UIScrollView *mainScroll;
@property (nonatomic, strong) NSMutableArray *leftValueArr; //剩余值数组
@property (nonatomic, strong) NSMutableArray *headTitleArr; //顶部list
@end
@implementation EcoComsumableItemsView

- (void)initViews
{
    _currentIndex = 0;
    [self addSubview:self.listView];
//    self.listView.currentIndex = _currentIndex;
    [self addSubview:self.bottomBtnView];
    WS(ws);
    _bottomBtnView.bottomBtnClicked = ^(int btnTag){
        if ([ws.delegate respondsToSelector:@selector(bottomBtnAction:index:)]) {
            [ws.delegate bottomBtnAction:btnTag index:(int)ws.currentIndex];
        }
    };
    
    [self addSubview:self.mainScroll];
    
    contentView = [[UIView alloc]init];
    [self.mainScroll addSubview:contentView];

    __weak typeof(_mainScroll) unscrollView = _mainScroll;
    __weak typeof(self) unself = self;
    _listView.listBarItemClickBlock = ^(NSInteger itemIndex){
        unself.currentIndex = (int)itemIndex;
        unscrollView.contentOffset =  CGPointMake(itemIndex * kScreenWidth, 0);
        EcoComsumableItemLeftView *leftView = [unself viewWithTag:(EcoComsumableItemLeftViewTAG+itemIndex)];
        [leftView startAnimationWithProgress:leftView.leftValue];
    };

}
- (void)addLeftViews:(NSArray *)arr
{
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        EcoComsumableItemLeftView *tempLeftView = [[EcoComsumableItemLeftView alloc]init];
        tempLeftView.tag = EcoComsumableItemLeftViewTAG + idx;
        [contentView addSubview:tempLeftView];
        [tempLeftView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(contentView);
            make.width.mas_equalTo(kScreenWidth);
            make.left.mas_equalTo(contentView).offset(idx*kScreenWidth);
        }];
        if (idx == arr.count-1) {
            [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(tempLeftView);
            }];
        }
    }];
    
}

- (void)setCurrentIndex:(int)currentIndex
{
    _currentIndex = currentIndex;
    _listView.currentIndex = _currentIndex;
    self.mainScroll.contentOffset =  CGPointMake(currentIndex * kScreenWidth, 0);
}

- (void)setLayout
{
    WS(ws);
    
    [_listView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.centerX.top.mas_equalTo(ws);
        make.height.mas_equalTo(kHeightPro(162));
    }];
  
    [_mainScroll mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_listView.mas_bottom).priorityHigh();
        make.left.right.centerX.mas_equalTo(ws);
        make.bottom.mas_equalTo(_bottomBtnView.mas_top).offset(-kHeightPro(260));
    }];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_mainScroll);
        make.height.equalTo(_mainScroll.mas_height);
    }];
    
    [_bottomBtnView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(ws);
        make.bottom.mas_equalTo(ws).offset(-kHeightPro(140));
        make.height.mas_equalTo(kHeightPro(150));
    }];
    
    NSLog(@"contentSize:%@,size:%@",NSStringFromCGSize(_mainScroll.contentSize),NSStringFromCGSize(_mainScroll.frame.size));
    
    MASAttachKeys(_listView,_mainScroll,_bottomBtnView,ws,contentView);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"scrollViewDidEndDecelerating");
    [_listView itemClickByScrollerWithIndex:scrollView.contentOffset.x / scrollView.frame.size.width];
}
#pragma mark ———— 子视图设置
- (void)setListViewHeight:(CGFloat)listViewHeight
{
    _listViewHeight = listViewHeight;
    [_listView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(listViewHeight);
    }];
}
- (void)setListViewTitleArr:(NSArray *)arr
{
    [self.headTitleArr setArray:arr];
    NSMutableArray *tempArray = [[NSMutableArray alloc]initWithArray:arr];
    [_listView setTitleArr:tempArray];
    [self addLeftViews:arr];
}

- (void)setBottomBtnsViewTitleArr:(NSArray *)arr
{
    [_bottomBtnView setTitleArr:arr];
}

- (void)setLeftValue:(int)value index:(int)index
{
    if (index >= _headTitleArr.count ) {
        return;
    }
   EcoComsumableItemLeftView *leftView = [self viewWithTag:(EcoComsumableItemLeftViewTAG +index) ];
    
    leftView.leftValue = value;
    
    [leftView startAnimationWithProgress:value];
}

- (void)setLeftValue:(int)value leftHour:(int)hour index:(int)index
{
    if (index >= _headTitleArr.count ) {
        return;
    }
    EcoComsumableItemLeftView *leftView = [self viewWithTag:(EcoComsumableItemLeftViewTAG +index) ];
    
    leftView.leftValue = value;
    [leftView setTopLeftValue:hour];
    if (index == _currentIndex) {
        [leftView startAnimationWithProgress:value];
    }
}

- (void)setLeftValueArr:(NSMutableArray *)valueArr
{
    if (valueArr.count > _headTitleArr.count) {
        return;
    }
    [valueArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        EcoComsumableItemLeftView *leftView = [self viewWithTag:(EcoComsumableItemLeftViewTAG +idx) ];
        
        leftView.leftValue = [valueArr[idx] intValue];
        if (idx == _currentIndex) {
            [leftView startAnimationWithProgress:leftView.leftValue ];
        }
    }];
    
}

/**
 当底部View只有一个按钮时，可以只传title

 @param str 按钮文字
 */
- (void)setBottomBtnViewTitle:(NSString *)str
{
    NSArray *arr = [[NSArray alloc]initWithObjects:str, nil];
     [_bottomBtnView setTitleArr:arr];
}

- (void)startAnimationWithProgress:(int)number
{
    int btnTag = (int)(EcoComsumableItemLeftViewTAG +_currentIndex);
    EcoComsumableItemLeftView *leftView = (EcoComsumableItemLeftView * )[self viewWithTag:btnTag];
    
    [leftView startAnimationWithProgress:number];
}

- (NSMutableArray *)headTitleArr
{
    if (!_headTitleArr) {
        _headTitleArr = [[NSMutableArray alloc]init];
    }
    return  _headTitleArr;
}

#pragma mark ———— 视图初始化
- (EcoComsumableItemsListView *)listView
{
    if (!_listView) {
        _listView = [[EcoComsumableItemsListView alloc]init];
    }
    return _listView;
}

- (EcoComsumableItemLeftView *)leftView
{
    if (!_leftView) {
        _leftView = [[EcoComsumableItemLeftView alloc]init];
    }
    return _leftView;
}

- (EcoComsumableItemsBottomBtnView *)bottomBtnView
{
    if (!_bottomBtnView) {
        _bottomBtnView = [[EcoComsumableItemsBottomBtnView alloc]init];
    }
    return _bottomBtnView;
    
}

- (UIScrollView *)mainScroll
{
    if (!_mainScroll) {
        _mainScroll = [[UIScrollView  alloc]init];
        _mainScroll.delegate = self;
        [_mainScroll setPagingEnabled:YES];
        [_mainScroll setScrollEnabled:YES];
        [_mainScroll setShowsHorizontalScrollIndicator:NO];
    }
    return _mainScroll;
}


 - (void)layoutSubviews
{
    [super layoutSubviews];
    [self setLayout];
}

@end
