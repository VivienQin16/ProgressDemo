//
//  EcoComsumableItemsListView.m
//  ProgressDemo
//
//  Created by Vivien on 2017/12/23.
//  Copyright © 2017年 ecovacs. All rights reserved.
//

#import "EcoComsumableItemsListView.h"
#define EcoComsumableItemsListTAG   300

@interface EcoComsumableItemsListView ()

@property (nonatomic, strong) UIImageView *triangleView;
@property (nonatomic, strong) UIButton *btnSelect;
@property (nonatomic, strong) NSMutableArray *btnLists;

@property (nonatomic, strong) NSMutableArray *titleArr;

@property (nonatomic, strong) UIColor *bgColor;//按钮默认背景色
@property (nonatomic, strong) UIColor *selectedColor;//按钮被选中颜色

@end

@implementation EcoComsumableItemsListView

- (void)initViews
{
    [super initViews];
    _bgColor = UIColorFromRGB(0xffffff);
    _selectedColor = UIColorFromRGB(0x005eb8);
    [self addSubViews];
    
    _currentIndex = 0;
}

/**
 根据TitleArray添加视图
 */
- (void)addSubViews
{
    if (_titleArr.count > 0 ) {
        
        [_titleArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *tempBtn = [[UIButton alloc]init];
            [tempBtn setTitle:_titleArr[idx] forState:UIControlStateNormal];
            tempBtn.tag = EcoComsumableItemsListTAG + idx;
            [tempBtn setTitleColor:UIColorFromRGB(0x253746) forState:UIControlStateNormal];
            [tempBtn setBackgroundColor:_bgColor];
            [tempBtn addTarget:self action:@selector(listBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:tempBtn];
            
            UIView *line = [[UIView alloc]init];
            line.tag = EcoComsumableItemsListTAG*2 + idx;
            line.backgroundColor = [UIColor clearColor];
            [tempBtn addSubview:line];
            
            [self.btnLists addObject:tempBtn];
            
            WS(ws);
            CGFloat btnWidth = kScreenWidth/(1.0*_titleArr.count);
            [tempBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.height.top.mas_equalTo(ws);
                make.left.mas_equalTo(ws).mas_offset(btnWidth*idx);
                make.width.mas_equalTo(btnWidth);
            }];
            
            [line mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.right.bottom.mas_equalTo(tempBtn);
                make.height.mas_equalTo(kWidthPro(8)); 
            }];
        }];
        
        [self setBtnSelected:_currentIndex];
        [self layoutIfNeeded];

    }
}
//清除视图
- (void)removeAllSubViews
{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
}

//按钮的默认颜色
- (void)setBtnBGColor:(UIColor *)color
{
    _bgColor = color;
     for (UIButton *tempBtn in _btnLists) {
         tempBtn.backgroundColor = _bgColor;
     }
}

- (void)setSelectedColor:(UIColor *)color
{
    _selectedColor = color ;
}

- (void)setTitleArr:(NSMutableArray *)titleArr
{
    _titleArr  = titleArr;
    [self removeAllSubViews];
    [_btnLists removeAllObjects];
    [self addSubViews];
}

- (NSMutableArray *)btnLists{
    if (_btnLists == nil) {
        _btnLists = [NSMutableArray array];
    }
    return _btnLists;
}


/**
 @param index
 */
- (void)setBtnSelected:(int)index
{
    if (index >_btnLists.count) {
        return;
    }
    for (UIButton *tempBtn in _btnLists) {
        NSInteger tempIndex = tempBtn.tag - EcoComsumableItemsListTAG;
        UIView *line = [self viewWithTag:(tempIndex + EcoComsumableItemsListTAG*2)];
        if (tempIndex == index) {
             _btnSelect = tempBtn;
             line.backgroundColor = _selectedColor;
             [tempBtn setTitleColor:_selectedColor forState:UIControlStateNormal];
        }else{
            line.backgroundColor = [UIColor clearColor];
            [tempBtn setTitleColor:UIColorFromRGB(0x253746) forState:UIControlStateNormal];
        }
    }
}

#pragma mark —————— 交互
- (void)itemClickByScrollerWithIndex:(NSInteger)index{
    UIButton *item = (UIButton *)self.btnLists[index];
    [self listBtnClicked:item];
}

//按钮点击事件
- (void)listBtnClicked:(id)sender
{
    UIButton *btn  = (UIButton *)sender;
    NSInteger index = [_btnLists indexOfObject:btn];
    _currentIndex = (int)index;
    [self setBtnSelected:(int)index];
    
    if (self.listBarItemClickBlock) {
        self.listBarItemClickBlock(index);
    }
    
}




@end

